<?php

namespace Tests\Feature\Api;

use App\Models\AppSetting;
use Tests\TestCase;

class AppSettingsTest extends TestCase
{
    public function test_get_app_settings(): void
    {
        $response = $this->getJson('/api/v1/settings');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_app_settings_include_required_keys(): void
    {
        $response = $this->getJson('/api/v1/settings');
        $response->assertOk();

        $data = $response->json('data');

        // These keys should exist
        $this->assertArrayHasKey('app_name', $data);
        $this->assertArrayHasKey('currency_symbol', $data);
    }

    public function test_cancellation_pin_not_exposed_in_public_settings(): void
    {
        $response = $this->getJson('/api/v1/settings');
        $response->assertOk();

        $data = $response->json('data');
        $this->assertArrayNotHasKey('cancellation_pin', $data, 'Cancellation PIN should never be exposed via API');
    }
}
