<?php

namespace Tests\Feature\Api;

use App\Models\AppSetting;
use App\Models\User;
use Tests\TestCase;

class StoreHolidayTest extends TestCase
{
    public function test_home_returns_holiday_active_when_enabled(): void
    {
        AppSetting::setValue('store_holiday_mode', '1');
        AppSetting::setValue('store_holiday_message', 'We are closed for Eid!');

        $response = $this->actingAs(User::first(), 'sanctum')
            ->getJson('/api/v1/home');

        $response->assertOk();

        $holiday = $response->json('data.holiday');
        $this->assertTrue($holiday['is_holiday'], 'Holiday should be active');
    }

    public function test_home_returns_holiday_inactive_when_disabled(): void
    {
        AppSetting::setValue('store_holiday_mode', '0');

        $response = $this->actingAs(User::first(), 'sanctum')
            ->getJson('/api/v1/home');

        $response->assertOk();

        $holiday = $response->json('data.holiday');
        $this->assertFalse($holiday['is_holiday'], 'Holiday should be inactive');
    }
}
