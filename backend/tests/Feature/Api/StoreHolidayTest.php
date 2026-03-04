<?php

namespace Tests\Feature\Api;

use App\Models\AppSetting;
use App\Models\User;
use Tests\TestCase;

class StoreHolidayTest extends TestCase
{
    public function test_home_returns_holiday_data_when_store_offline(): void
    {
        AppSetting::setValue('is_store_offline', '1');
        AppSetting::setValue('holiday_title', 'Eid Holiday');
        AppSetting::setValue('holiday_message', 'We are closed!');

        $response = $this->actingAs(User::first(), 'sanctum')
            ->getJson('/api/v1/home');

        $response->assertOk();

        $holiday = $response->json('data.holiday');
        $this->assertNotNull($holiday, 'Holiday data should be present when store is offline');
        $this->assertTrue($holiday['is_offline']);
        $this->assertEquals('Eid Holiday', $holiday['title']);
    }

    public function test_home_returns_null_holiday_when_store_online(): void
    {
        AppSetting::setValue('is_store_offline', '0');

        $response = $this->actingAs(User::first(), 'sanctum')
            ->getJson('/api/v1/home');

        $response->assertOk();

        $holiday = $response->json('data.holiday');
        $this->assertNull($holiday, 'Holiday data should be null when store is online');
    }
}
