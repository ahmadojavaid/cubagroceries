<?php

namespace Tests\Feature;

use Tests\TestCase;

class ExampleTest extends TestCase
{
    public function test_welcome_page_loads(): void
    {
        $response = $this->get('/');

        $response->assertOk();
    }

    public function test_api_base_returns_json(): void
    {
        $response = $this->getJson('/api/v1/auth/user');

        // Should be 401 unauthenticated, but valid JSON
        $response->assertStatus(401)
            ->assertJsonStructure(['message']);
    }
}
