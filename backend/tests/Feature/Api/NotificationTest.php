<?php

namespace Tests\Feature\Api;

use App\Models\User;
use Tests\TestCase;

class NotificationTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_list_notifications(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/notifications');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_mark_all_read(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->putJson('/api/v1/notifications/read-all');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_notifications_require_auth(): void
    {
        $response = $this->getJson('/api/v1/notifications');
        $response->assertStatus(401);
    }
}
