<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Coupon;
use Illuminate\Http\Request;

class CouponController extends Controller
{
    /**
     * Validate and return coupon details for checkout.
     */
    public function apply(Request $request)
    {
        $request->validate([
            'code' => 'required|string',
            'order_total' => 'required|numeric|min:0',
        ]);

        $coupon = Coupon::where('code', strtoupper($request->code))->first();

        if (!$coupon) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid coupon code.',
            ], 422);
        }

        if (!$coupon->is_active) {
            return response()->json([
                'success' => false,
                'message' => 'This coupon is no longer active.',
            ], 422);
        }

        if ($coupon->isExpired()) {
            return response()->json([
                'success' => false,
                'message' => 'This coupon has expired.',
            ], 422);
        }

        if ($coupon->isUsedUp()) {
            return response()->json([
                'success' => false,
                'message' => 'This coupon has been fully redeemed.',
            ], 422);
        }

        if ($coupon->min_order_amount && $request->order_total < $coupon->min_order_amount) {
            return response()->json([
                'success' => false,
                'message' => 'Minimum order of Rs ' . number_format($coupon->min_order_amount, 0) . ' required.',
            ], 422);
        }

        // Calculate discount
        $discount = $coupon->type === 'percentage'
            ? ($request->order_total * $coupon->value / 100)
            : $coupon->value;

        // Apply max discount cap for percentage coupons
        if ($coupon->type === 'percentage' && $coupon->max_discount) {
            $discount = min($discount, $coupon->max_discount);
        }

        $discount = round(min($discount, $request->order_total), 2);

        return response()->json([
            'success' => true,
            'data' => [
                'code' => $coupon->code,
                'type' => $coupon->type,
                'value' => $coupon->value,
                'discount' => $discount,
                'description' => $coupon->description,
            ],
        ]);
    }
}
