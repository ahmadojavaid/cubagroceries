<?php

namespace Tests\Feature\Api;

use App\Models\AppSetting;
use App\Models\User;
use Tests\TestCase;

class StoreHolidayTest extends TestCase
{
    public function test_orders_blocked_during_holiday_mode(): void
    {
        // Enable holiday mode
        AppSetting::setValue('store_holiday_mode', '1');

        $user = User::first();

        $response = $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/orders', [
                'address_id' => 1,
                'items' => [
                    ['product_id' => 1, 'unit_id' => 7, 'quantity' => 1],
                ],
            ]);

        // Should be rejected (422 or 503)
        $this->assertTrue(in_array($response->status(), [422, 503]),
            'Orders should be blocked during holiday mode, got: ' . $response->status());

        // Disable holiday mode (cleanup)
        AppSetting::setValue('store_holiday_mode', '0');
    }

    public function test_orders_work_when_holiday_mode_off(): void
    {
        AppSetting::setValue('store_holiday_mode', '0');

        $user = User::first();

        // Just check it doesn't return a holiday error
        // (may fail for other validation reasons, that's fine)
        $response = $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/orders', [
                'address_id' => 99999,
                'items' => [
                    ['product_id' => 1, 'unit_id' => 7, 'quantity' => 1],
                ],
            ]);

        // Should NOT be a holiday rejection — 422 for validation is expected
        $body = $response->json('message') ?? '';
        $this->assertStringNotContainsStringIgnoringCase('holiday', $body);
        $this->assertStringNotContainsStringIgnoringCase('closed', $body);
    }
}
