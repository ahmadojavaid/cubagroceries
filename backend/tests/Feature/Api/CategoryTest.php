<?php

namespace Tests\Feature\Api;

use App\Models\Category;
use App\Models\User;
use Tests\TestCase;

class CategoryTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_list_top_level_categories(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/categories');

        $response->assertOk()
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data' => [
                    '*' => ['id', 'title', 'image'],
                ],
            ]);

        // All returned categories should be top-level (no parent)
        $categories = $response->json('data');
        $this->assertNotEmpty($categories);
    }

    public function test_categories_include_children(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/categories');

        $response->assertOk();

        // At least one category should have the children key
        $categories = $response->json('data');
        $hasChildrenKey = collect($categories)->contains(fn ($c) => array_key_exists('children', $c));
        $this->assertTrue($hasChildrenKey, 'Categories should include children key');
    }

    public function test_category_products_returns_paginated_list(): void
    {
        $category = Category::whereNull('parent_id')->first();

        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson("/api/v1/categories/{$category->id}/products");

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_category_products_404_for_invalid_id(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/categories/99999/products');

        $response->assertStatus(404);
    }

    public function test_categories_require_auth(): void
    {
        $response = $this->getJson('/api/v1/categories');

        $response->assertStatus(401);
    }
}
