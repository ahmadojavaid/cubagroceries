<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Address;
use App\Models\Order;
use App\Models\Price;
use App\Models\Product;
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
            ->with(['address', 'products.product', 'products.unit'])
            ->first();

        if (!$order) {
            return $this->error('Order not found', 404);
        }

        return $this->success($order);
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
            $shippingAmount = $shipping ? $shipping->amount : 0;
        }

        $totalAmount = $subtotal + $shippingAmount;

        // Create order in a transaction
        $order = DB::transaction(function () use ($user, $address, $lineItems, $totalAmount) {
            // Create order
            $order = Order::create([
                'order_id' => OrderIdGenerator::generate(),
                'user_id' => $user->id,
                'status' => 'pending',
                'total_amount' => $totalAmount,
            ]);

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
