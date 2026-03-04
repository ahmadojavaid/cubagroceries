<?php

namespace Tests\Feature\Api;

use App\Models\User;
use Tests\TestCase;

class HomeDataTest extends TestCase
{
    public function test_home_data_endpoint_returns_success(): void
    {
        $response = $this->actingAs(User::first(), 'sanctum')
            ->getJson('/api/v1/home');

        $response->assertOk()
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data' => [
                    'banners',
                    'featured_sections',
                    'holiday',
                ],
            ]);
    }

    public function test_home_data_includes_holiday_status(): void
    {
        $response = $this->actingAs(User::first(), 'sanctum')
            ->getJson('/api/v1/home');

        $response->assertOk();

        $holiday = $response->json('data.holiday');
        $this->assertArrayHasKey('is_holiday', $holiday);
    }

    public function test_home_data_requires_auth(): void
    {
        $response = $this->getJson('/api/v1/home');
        $response->assertStatus(401);
    }
}
