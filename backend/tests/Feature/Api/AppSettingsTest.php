<?php

namespace Tests\Feature\Api;

use App\Models\AppSetting;
use App\Models\User;
use Tests\TestCase;

class AppSettingsTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_get_app_settings(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/settings');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_app_settings_include_required_keys(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/settings');

        $response->assertOk();

        $data = $response->json('data');

        $this->assertArrayHasKey('app_name', $data);
        $this->assertArrayHasKey('currency_symbol', $data);
    }

    public function test_cancellation_pin_not_exposed_in_settings(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/settings');

        $response->assertOk();

        $data = $response->json('data');
        $this->assertArrayNotHasKey('cancellation_pin', $data, 'Cancellation PIN should never be exposed via API');
    }
}
