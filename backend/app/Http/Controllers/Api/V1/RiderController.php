<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class RiderController extends Controller
{
    /**
     * GET /api/v1/rider/orders
     * List orders assigned to the authenticated rider's delivery boy record.
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
     * Get a single order detail by order number.
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
}
