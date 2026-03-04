<?php

namespace App\Http\Controllers\Api\V1;

use App\Enums\OrderStatus;
use App\Http\Controllers\Controller;
use App\Notifications\OrderStatusChanged;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class RiderController extends Controller
{
    /**
     * GET /api/v1/rider/orders
     */
    public function orders(Request $request): JsonResponse
    {
        $user = $request->user();
        $deliveryBoy = $user->deliveryBoy;

        if (! $deliveryBoy) {
            return response()->json([
                'success' => false,
                'message' => 'No delivery boy profile linked to this account.',
            ], 404);
        }

        $orders = $deliveryBoy->orders()
            ->with([
                'address',
                'user:id,firstname,lastname,identity',
                'products.product:id,name',
                'products.unit:id,name',
            ])
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 20));

        return response()->json([
            'success' => true,
            'data' => $orders->items(),
            'meta' => [
                'current_page' => $orders->currentPage(),
                'last_page' => $orders->lastPage(),
                'per_page' => $orders->perPage(),
                'total' => $orders->total(),
            ],
        ]);
    }

    /**
     * GET /api/v1/rider/orders/{order_number}
     */
    public function show(Request $request, string $orderNumber): JsonResponse
    {
        $user = $request->user();
        $deliveryBoy = $user->deliveryBoy;

        if (! $deliveryBoy) {
            return response()->json([
                'success' => false,
                'message' => 'No delivery boy profile linked to this account.',
            ], 404);
        }

        $order = $deliveryBoy->orders()
            ->where('order_id', $orderNumber)
            ->with([
                'address',
                'user:id,firstname,lastname,identity,email',
                'products.product:id,name',
                'products.unit:id,name',
            ])
            ->first();

        if (! $order) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found.',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $order,
        ]);
    }

    /**
     * PUT /api/v1/rider/orders/{order_number}/status
     *
     * Rider can only:
     *   confirmed  → dispatched  (pick up / start delivery)
     *   dispatched → delivered   (mark delivered)
     */
    public function updateStatus(Request $request, string $orderNumber): JsonResponse
    {
        $request->validate([
            'status' => 'required|string|in:dispatched,delivered',
        ]);

        $user = $request->user();
        $deliveryBoy = $user->deliveryBoy;

        if (! $deliveryBoy) {
            return response()->json([
                'success' => false,
                'message' => 'No delivery boy profile linked to this account.',
            ], 404);
        }

        $order = $deliveryBoy->orders()
            ->where('order_id', $orderNumber)
            ->first();

        if (! $order) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found.',
            ], 404);
        }

        $newStatus = OrderStatus::from($request->status);
        $currentStatus = $order->status;

        // Validate transition
        if (! $currentStatus->canTransitionTo($newStatus)) {
            return response()->json([
                'success' => false,
                'message' => "Cannot change status from {$currentStatus->label()} to {$newStatus->label()}.",
            ], 422);
        }

        // Only allow rider-specific transitions
        $allowed = match ($newStatus) {
            OrderStatus::Dispatched => $currentStatus === OrderStatus::Confirmed,
            OrderStatus::Delivered  => $currentStatus === OrderStatus::Dispatched,
            default => false,
        };

        if (! $allowed) {
            return response()->json([
                'success' => false,
                'message' => 'You are not allowed to perform this status change.',
            ], 403);
        }

        $oldStatus = $currentStatus;
        $order->update(['status' => $newStatus]);

        // Notify customer
        try {
            $order->user->notify(new OrderStatusChanged($order, $oldStatus, $newStatus));
        } catch (\Throwable $e) {
            \Illuminate\Support\Facades\Log::warning('Order notification failed: ' . $e->getMessage());
        }

        return response()->json([
            'success' => true,
            'data' => [
                'order_id' => $order->order_id,
                'status' => $order->status->value,
            ],
            'message' => "Order marked as {$newStatus->label()}.",
        ]);
    }
}
