<?php

namespace Tests\Feature\Api;

use App\Models\Address;
use App\Models\Order;
use App\Models\Price;
use App\Models\Product;
use App\Models\User;
use Tests\TestCase;

class OrderTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    private function createAddress(User $user): Address
    {
        return Address::create([
            'user_id' => $user->id,
            'label' => 'Test',
            'address' => 'Test Address for Order',
            'city' => 'Lahore',
            'phone' => '03001234567',
        ]);
    }

    public function test_place_order_successfully(): void
    {
        $user = $this->authUser();
        $address = $this->createAddress($user);

        // Get a product with price
        $price = Price::with('product')->whereHas('product', fn ($q) => $q->where('stock', '>', 5))->first();
        $this->assertNotNull($price, 'Need a product with stock and price');

        $response = $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/orders', [
                'address_id' => $address->id,
                'items' => [
                    [
                        'product_id' => $price->product_id,
                        'unit_id' => $price->unit_id,
                        'quantity' => 1,
                    ],
                ],
            ]);

        $response->assertStatus(201)
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data' => ['id', 'order_id', 'status', 'total_amount'],
            ]);

        // Verify order ID format: CUBA + 8 digits
        $orderId = $response->json('data.order_id');
        $this->assertMatchesRegularExpression('/^CUBA\d{8}$/', $orderId);
    }

    public function test_place_order_fails_without_items(): void
    {
        $user = $this->authUser();
        $address = $this->createAddress($user);

        $response = $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/orders', [
                'address_id' => $address->id,
                'items' => [],
            ]);

        $response->assertStatus(422);
    }

    public function test_place_order_fails_with_invalid_address(): void
    {
        $user = $this->authUser();

        $response = $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/orders', [
                'address_id' => 99999,
                'items' => [
                    ['product_id' => 1, 'unit_id' => 7, 'quantity' => 1],
                ],
            ]);

        $response->assertStatus(422);
    }

    public function test_place_order_deducts_stock(): void
    {
        $user = $this->authUser();
        $address = $this->createAddress($user);

        $price = Price::with('product')->whereHas('product', fn ($q) => $q->where('stock', '>', 10))->first();
        $this->assertNotNull($price);

        $stockBefore = $price->product->stock;

        $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/orders', [
                'address_id' => $address->id,
                'items' => [
                    [
                        'product_id' => $price->product_id,
                        'unit_id' => $price->unit_id,
                        'quantity' => 2,
                    ],
                ],
            ])
            ->assertStatus(201);

        $stockAfter = Product::find($price->product_id)->stock;
        $this->assertEquals($stockBefore - 2, $stockAfter);
    }

    public function test_order_history_paginated(): void
    {
        $user = $this->authUser();

        $response = $this->actingAs($user, 'sanctum')
            ->getJson('/api/v1/orders');

        $response->assertOk()
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data',
                'meta' => ['current_page', 'last_page'],
            ]);
    }

    public function test_order_detail_by_order_number(): void
    {
        $user = $this->authUser();
        $order = Order::where('user_id', $user->id)->first();

        if (!$order) {
            $this->markTestSkipped('No orders for this user');
        }

        $response = $this->actingAs($user, 'sanctum')
            ->getJson("/api/v1/orders/{$order->order_id}");

        $response->assertOk()
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data' => [
                    'id', 'order_id', 'status', 'total_amount',
                    'address', 'products',
                ],
            ]);
    }

    public function test_order_detail_includes_rider_when_assigned(): void
    {
        $order = Order::whereNotNull('delivery_boy_id')->first();

        if (!$order) {
            $this->markTestSkipped('No orders with assigned riders');
        }

        $user = User::find($order->user_id);

        $response = $this->actingAs($user, 'sanctum')
            ->getJson("/api/v1/orders/{$order->order_id}");

        $response->assertOk()
            ->assertJsonStructure([
                'data' => [
                    'delivery_boy' => ['id', 'name', 'phone'],
                ],
            ]);
    }

    public function test_order_detail_404_for_other_users_order(): void
    {
        $user1 = User::first();
        $order = Order::where('user_id', '!=', $user1->id)->first();

        if (!$order) {
            $this->markTestSkipped('Need orders from different users');
        }

        $response = $this->actingAs($user1, 'sanctum')
            ->getJson("/api/v1/orders/{$order->order_id}");

        $response->assertStatus(404);
    }

    public function test_cancel_pending_order(): void
    {
        $user = $this->authUser();
        $address = $this->createAddress($user);

        // Place a fresh order
        $price = Price::with('product')->whereHas('product', fn ($q) => $q->where('stock', '>', 5))->first();

        $orderResponse = $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/orders', [
                'address_id' => $address->id,
                'items' => [
                    [
                        'product_id' => $price->product_id,
                        'unit_id' => $price->unit_id,
                        'quantity' => 1,
                    ],
                ],
            ]);

        $orderId = $orderResponse->json('data.order_id');

        // Cancel it
        $response = $this->actingAs($user, 'sanctum')
            ->putJson("/api/v1/orders/{$orderId}/cancel");

        $response->assertOk()
            ->assertJson([
                'success' => true,
                'data' => ['status' => 'cancelled'],
            ]);
    }

    public function test_cancel_non_pending_order_fails(): void
    {
        $order = Order::where('status', '!=', 'pending')->first();

        if (!$order) {
            $this->markTestSkipped('No non-pending orders');
        }

        $user = User::find($order->user_id);

        $response = $this->actingAs($user, 'sanctum')
            ->putJson("/api/v1/orders/{$order->order_id}/cancel");

        $response->assertStatus(422);
    }

    public function test_cancel_restores_stock(): void
    {
        $user = $this->authUser();
        $address = $this->createAddress($user);

        $price = Price::with('product')->whereHas('product', fn ($q) => $q->where('stock', '>', 10))->first();

        $stockBefore = $price->product->stock;

        $orderResponse = $this->actingAs($user, 'sanctum')
            ->postJson('/api/v1/orders', [
                'address_id' => $address->id,
                'items' => [
                    [
                        'product_id' => $price->product_id,
                        'unit_id' => $price->unit_id,
                        'quantity' => 3,
                    ],
                ],
            ]);

        $orderId = $orderResponse->json('data.order_id');

        // Stock should be reduced
        $this->assertEquals($stockBefore - 3, Product::find($price->product_id)->stock);

        // Cancel
        $this->actingAs($user, 'sanctum')
            ->putJson("/api/v1/orders/{$orderId}/cancel")
            ->assertOk();

        // Stock should be restored
        $this->assertEquals($stockBefore, Product::find($price->product_id)->stock);
    }

    public function test_orders_require_auth(): void
    {
        $response = $this->getJson('/api/v1/orders');
        $response->assertStatus(401);
    }
}
