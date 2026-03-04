<?php

namespace Tests\Feature\Api;

use App\Models\Product;
use App\Models\Category;
use App\Models\User;
use Tests\TestCase;

class ProductTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_list_products_paginated(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/products');

        $response->assertOk()
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data' => [
                    '*' => ['id', 'name'],
                ],
                'meta' => ['current_page', 'last_page', 'per_page', 'total'],
            ]);
    }

    public function test_list_products_filter_by_category(): void
    {
        $category = Category::whereNull('parent_id')->first();

        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson("/api/v1/products?category_id={$category->id}");

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_product_detail_with_prices_and_units(): void
    {
        $product = Product::has('prices')->first();

        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson("/api/v1/products/{$product->id}");

        $response->assertOk()
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data' => [
                    'id',
                    'name',
                    'prices' => [
                        '*' => ['id', 'price', 'unit'],
                    ],
                ],
            ]);
    }

    public function test_product_detail_404_for_invalid_id(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/products/99999');

        $response->assertStatus(404);
    }

    public function test_search_products(): void
    {
        $product = Product::first();
        $query = substr($product->name, 0, 4);

        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson("/api/v1/products/search?q={$query}");

        $response->assertOk()
            ->assertJson(['success' => true]);

        $results = $response->json('data');
        $this->assertNotEmpty($results, "Search for '{$query}' should return results");
    }

    public function test_search_with_no_results(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/products/search?q=xyznonexistent99');

        $response->assertOk();

        $results = $response->json('data');
        $this->assertEmpty($results);
    }

    public function test_products_require_auth(): void
    {
        $response = $this->getJson('/api/v1/products');

        $response->assertStatus(401);
    }
}
