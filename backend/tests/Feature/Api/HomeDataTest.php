<?php

namespace Tests\Feature\Api;

use App\Models\User;
use Tests\TestCase;

class HomeDataTest extends TestCase
{
    public function test_home_data_returns_categories_and_products(): void
    {
        $response = $this->actingAs(User::first(), 'sanctum')
            ->getJson('/api/v1/home');

        $response->assertOk()
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data' => [
                    'categories',
                    'featured_products',
                ],
            ]);
    }

    public function test_home_data_requires_auth(): void
    {
        $response = $this->getJson('/api/v1/home');
        $response->assertStatus(401);
    }
}
