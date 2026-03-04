<?php

namespace Tests\Feature\Api;

use App\Models\User;
use Tests\TestCase;

class ShippingTest extends TestCase
{
    public function test_list_shipping_charges(): void
    {
        $response = $this->actingAs(User::first(), 'sanctum')
            ->getJson('/api/v1/shipping-charges');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_shipping_requires_auth(): void
    {
        $response = $this->getJson('/api/v1/shipping-charges');
        $response->assertStatus(401);
    }
}
