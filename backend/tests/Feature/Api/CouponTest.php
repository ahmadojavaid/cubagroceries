<?php

namespace Tests\Feature\Api;

use App\Models\Coupon;
use App\Models\User;
use Tests\TestCase;

class CouponTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_apply_valid_coupon(): void
    {
        // Create a test coupon
        $coupon = Coupon::create([
            'code' => 'TEST' . strtoupper(uniqid()),
            'type' => 'percentage',
            'value' => 10,
            'is_active' => true,
            'max_uses' => 100,
            'used_count' => 0,
        ]);

        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->postJson('/api/v1/coupons/apply', [
                'code' => $coupon->code,
                'subtotal' => 500,
            ]);

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_apply_expired_coupon_fails(): void
    {
        $coupon = Coupon::create([
            'code' => 'EXPIRED' . strtoupper(uniqid()),
            'type' => 'fixed',
            'value' => 50,
            'is_active' => true,
            'max_uses' => 100,
            'used_count' => 0,
            'expires_at' => now()->subDay(),
        ]);

        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->postJson('/api/v1/coupons/apply', [
                'code' => $coupon->code,
                'subtotal' => 500,
            ]);

        $response->assertStatus(422);
    }

    public function test_apply_invalid_coupon_code_fails(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->postJson('/api/v1/coupons/apply', [
                'code' => 'TOTALLYINVALIDXYZ',
                'subtotal' => 500,
            ]);

        $response->assertStatus(422);
    }

    public function test_user_specific_coupon_works_for_correct_user(): void
    {
        $user = $this->authUser();

        $coupon = Coupon::create([
            'code' => 'VIP' . strtoupper(uniqid()),
            'type' => 'fixed',
            'value' => 100,
            'is_active' => true,
            'max_uses' => 10,
            'used_count' => 0,
            'user_id' => $user->id,
        ]);

        $response = $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/coupons/apply', [
                'code' => $coupon->code,
                'subtotal' => 500,
            ]);

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_user_specific_coupon_fails_for_wrong_user(): void
    {
        $user1 = User::first();
        $user2 = User::where('id', '!=', $user1->id)->first();

        if (!$user2) {
            $this->markTestSkipped('Need at least 2 users');
        }

        $coupon = Coupon::create([
            'code' => 'PRIV' . strtoupper(uniqid()),
            'type' => 'fixed',
            'value' => 100,
            'is_active' => true,
            'max_uses' => 10,
            'used_count' => 0,
            'user_id' => $user1->id,
        ]);

        $response = $this->actingAs($user2, 'sanctum')
            ->postJson('/api/v1/coupons/apply', [
                'code' => $coupon->code,
                'subtotal' => 500,
            ]);

        $response->assertStatus(422);
    }

    public function test_coupon_requires_auth(): void
    {
        $response = $this->postJson('/api/v1/coupons/apply', [
            'code' => 'TEST',
            'subtotal' => 100,
        ]);

        $response->assertStatus(401);
    }
}
