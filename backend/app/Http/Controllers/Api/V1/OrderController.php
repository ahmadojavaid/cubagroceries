<?php

namespace App\Http\Controllers\Api\V1;

use App\Enums\OrderStatus;
use App\Http\Controllers\Controller;
use App\Models\Address;
use App\Models\Order;
use App\Models\Price;
use App\Models\Product;
use App\Models\OrderStatusHistory;
use App\Models\WalletTransaction;
use App\Services\OrderIdGenerator;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class OrderController extends Controller
{
    use ApiResponse;

    /**
     * Order history for authenticated user (paginated).
     */
    public function index(Request $request): JsonResponse
    {
        $orders = Order::where('user_id', $request->user()->id)
            ->withCount('products')
            ->orderByDesc('created_at')
            ->paginate($request->input('per_page', 20));

        return $this->paginated($orders);
    }

    /**
     * Order detail by order_number.
     */
    public function show(Request $request, string $orderNumber): JsonResponse
    {
        $order = Order::where('order_id', $orderNumber)
            ->where('user_id', $request->user()->id)
            ->with(['address', 'products.product', 'products.unit', 'deliveryBoy:id,name,phone', 'orderReview'])
            ->first();

        if (!$order) {
            return $this->error('Order not found', 404);
        }

        $data = $order->toArray();

        // Add est delivery info
        $data['est_delivery_minutes'] = $order->est_delivery_minutes;
        $data['est_delivery_set_at'] = $order->est_delivery_set_at?->toIso8601String();

        // Add payment breakdown
        $data['shipping_title'] = $order->shipping_title;
        $data['shipping_amount'] = $order->shipping_amount;
        $data['coupon_code'] = $order->coupon_code;
        $data['coupon_discount'] = $order->coupon_discount;
        $data['wallet_amount_used'] = $order->wallet_amount_used;

        return $this->success($data);
    }

    /**
     * Cancel a pending order.
     * PUT /api/v1/orders/{order_number}/cancel
     */
    public function cancel(Request $request, string $orderNumber): JsonResponse
    {
        $order = Order::where('order_id', $orderNumber)
            ->where('user_id', $request->user()->id)
            ->first();

        if (!$order) {
            return $this->error('Order not found', 404);
        }

        if ($order->status !== OrderStatus::Pending) {
            return $this->error('Only pending orders can be cancelled.', 422);
        }

        $oldStatus = $order->status;
        $order->update(['status' => OrderStatus::Cancelled]);

        // Record status history
        OrderStatusHistory::record(
            $order->id,
            $oldStatus->value,
            OrderStatus::Cancelled->value,
            'customer',
            'Cancelled by customer',
        );

        // Refund wallet if wallet was used
        if ($order->wallet_amount_used > 0) {
            $user = $request->user();
            $user->increment('wallet_amount', $order->wallet_amount_used);

            WalletTransaction::recordCredit(
                userId: $user->id,
                amount: (float) $order->wallet_amount_used,
                source: 'order_refund',
                referenceId: $order->id,
                note: "Refund for cancelled order {$order->order_id}",
            );
        }

        // Restore stock
        foreach ($order->products as $item) {
            Product::where('id', $item->product_id)
                ->increment('stock', $item->quantity);
        }

        return $this->success([
            'order_id' => $order->order_id,
            'status' => OrderStatus::Cancelled->value,
        ], 'Order cancelled successfully.');
    }

    /**
     * Place a new order.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'address_id' => 'required|integer|exists:addresses,id',
            'shipping_charge_id' => 'nullable|integer|exists:shippingcharge,id',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|integer|exists:product,id',
            'items.*.unit_id' => 'required|integer|exists:unit,id',
            'items.*.quantity' => 'required|integer|min:1',
            'coupon_code' => 'nullable|string',
            'use_wallet' => 'nullable|boolean',
        ]);

        $user = $request->user();

        // Verify address belongs to user
        $address = Address::where('id', $validated['address_id'])
            ->where('user_id', $user->id)
            ->first();

        if (!$address) {
            return $this->error('Address not found', 404);
        }

        // Validate stock and resolve prices
        $lineItems = [];
        $subtotal = 0;

        foreach ($validated['items'] as $item) {
            $product = Product::find($item['product_id']);

            if ($product->stock < $item['quantity']) {
                return $this->error(
                    "Insufficient stock for {$product->name}. Available: {$product->stock}",
                    422
                );
            }

            // Find price for this product-unit combination
            $price = Price::where('product_id', $item['product_id'])
                ->where('unit_id', $item['unit_id'])
                ->first();

            if (!$price) {
                return $this->error(
                    "Price not found for {$product->name} with the selected unit",
                    422
                );
            }

            $lineTotal = $price->price * $item['quantity'];
            $subtotal += $lineTotal;

            $lineItems[] = [
                'product_id' => $item['product_id'],
                'unit_id' => $item['unit_id'],
                'quantity' => $item['quantity'],
                'price' => $price->price,
                'product' => $product,
            ];
        }

        // Calculate shipping
        $shippingAmount = 0;
        if (!empty($validated['shipping_charge_id'])) {
            $shipping = \App\Models\ShippingCharge::find($validated['shipping_charge_id']);
            if ($shipping) {
                if ($shipping->min_order_amount && $subtotal < $shipping->min_order_amount) {
                    return $this->error(
                        "'{$shipping->title}' requires a minimum order of Rs " . number_format($shipping->min_order_amount, 0) . '.',
                        422
                    );
                }
                $shippingAmount = $shipping->amount;
            }
        }

        // Validate and calculate coupon discount
        $couponDiscount = 0;
        $couponCode = null;
        if (!empty($validated['coupon_code'])) {
            $coupon = \App\Models\Coupon::where('code', strtoupper($validated['coupon_code']))
                ->first();

            if ($coupon && $coupon->is_active && !$coupon->isExpired() && !$coupon->isUsedUp()) {
                if (!$coupon->min_order_amount || $subtotal >= $coupon->min_order_amount) {
                    $couponCode = $coupon->code;

                    switch ($coupon->type) {
                        case 'percentage':
                            $couponDiscount = $subtotal * $coupon->value / 100;
                            if ($coupon->max_discount) {
                                $couponDiscount = min($couponDiscount, $coupon->max_discount);
                            }
                            $couponDiscount = min($couponDiscount, $subtotal);
                            break;

                        case 'fixed':
                            $couponDiscount = min($coupon->value, $subtotal);
                            break;

                        case 'free_delivery':
                            $couponDiscount = $shippingAmount;
                            break;
                    }

                    $couponDiscount = round($couponDiscount, 2);

                    // Increment usage
                    $coupon->increment('used_count');
                }
            }
        }

        $totalAmount = $subtotal + $shippingAmount - $couponDiscount;

        // Calculate wallet credit usage
        $walletUsed = 0;
        $useWallet = $validated['use_wallet'] ?? false;
        if ($useWallet && $user->wallet_amount > 0) {
            $walletUsed = min((float) $user->wallet_amount, $totalAmount);
            $walletUsed = round($walletUsed, 2);
            $totalAmount = round($totalAmount - $walletUsed, 2);
        }

        // Create order in a transaction
        $order = DB::transaction(function () use ($user, $address, $lineItems, $totalAmount, $couponCode, $couponDiscount, $walletUsed, $shippingAmount, $validated) {
            // Resolve shipping title for snapshot
            $shippingTitle = null;
            if ($shippingAmount > 0 && !empty($validated['shipping_charge_id'])) {
                $shippingTitle = \App\Models\ShippingCharge::find($validated['shipping_charge_id'])?->title;
            }

            // Create order
            $order = Order::create([
                'order_id' => OrderIdGenerator::generate(),
                'user_id' => $user->id,
                'status' => 'pending',
                'total_amount' => $totalAmount,
                'wallet_amount_used' => $walletUsed,
                'shipping_title' => $shippingTitle,
                'shipping_amount' => $shippingAmount,
                'coupon_code' => $couponCode,
                'coupon_discount' => $couponDiscount,
            ]);

            // Record initial status
            OrderStatusHistory::record($order->id, null, 'pending', 'customer', 'Order placed');

            // Deduct wallet balance
            if ($walletUsed > 0) {
                $user->decrement('wallet_amount', $walletUsed);

                WalletTransaction::recordDebit(
                    $user->id,
                    $walletUsed,
                    'order_payment',
                    $order->id,
                    'Payment for order ' . $order->order_id,
                );
            }

            // Snapshot address
            $order->address()->create([
                'address' => $address->address,
                'city' => $address->city,
                'phone' => $address->phone,
                'latitude' => $address->latitude,
                'longitude' => $address->longitude,
            ]);

            // Create line items and deduct stock
            foreach ($lineItems as $item) {
                $order->products()->create([
                    'product_id' => $item['product_id'],
                    'unit_id' => $item['unit_id'],
                    'quantity' => $item['quantity'],
                    'price' => $item['price'],
                ]);

                // Deduct stock
                $item['product']->decrement('stock', $item['quantity']);
            }

            return $order;
        });

        // Load relationships for response
        $order->load(['address', 'products.product', 'products.unit']);

        return $this->success($order, 'Order placed successfully', 201);
    }
}
