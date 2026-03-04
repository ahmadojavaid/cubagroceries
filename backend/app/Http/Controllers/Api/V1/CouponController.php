<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Coupon;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CouponController extends Controller
{
    use ApiResponse;

    /**
     * Validate and return coupon details for checkout.
     * POST /api/v1/coupons/apply
     */
    public function apply(Request $request): JsonResponse
    {
        $request->validate([
            'code' => 'required|string',
            'order_total' => 'required|numeric|min:0',
            'shipping_amount' => 'nullable|numeric|min:0',
        ]);

        $coupon = Coupon::where('code', strtoupper($request->code))->first();

        if (!$coupon) {
            return $this->error('Invalid coupon code.', 422);
        }

        if (!$coupon->is_active) {
            return $this->error('This coupon is no longer active.', 422);
        }

        if ($coupon->isExpired()) {
            return $this->error('This coupon has expired.', 422);
        }

        if ($coupon->isUsedUp()) {
            return $this->error('This coupon has been fully redeemed.', 422);
        }

        // User-specific coupon check
        if ($coupon->isUserSpecific() && $coupon->user_id !== $request->user()->id) {
            return $this->error('This coupon is not available for your account.', 422);
        }

        if ($coupon->min_order_amount && $request->order_total < $coupon->min_order_amount) {
            return $this->error(
                'Minimum order of Rs ' . number_format($coupon->min_order_amount, 0) . ' required.',
                422
            );
        }

        // Calculate discount based on type
        $discount = 0;
        $shippingAmount = $request->input('shipping_amount', 0);

        switch ($coupon->type) {
            case 'percentage':
                $discount = $request->order_total * $coupon->value / 100;
                if ($coupon->max_discount) {
                    $discount = min($discount, $coupon->max_discount);
                }
                // Don't exceed order total
                $discount = min($discount, $request->order_total);
                break;

            case 'fixed':
                $discount = min($coupon->value, $request->order_total);
                break;

            case 'free_delivery':
                // Discount equals the shipping amount (makes delivery free)
                $discount = $shippingAmount;
                break;
        }

        $discount = round($discount, 2);

        return $this->success([
            'code' => $coupon->code,
            'type' => $coupon->type,
            'value' => $coupon->value,
            'discount' => $discount,
            'description' => $coupon->description,
        ]);
    }
}
