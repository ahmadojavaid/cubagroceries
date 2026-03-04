<?php

namespace Tests\Feature\Api;

use App\Models\User;
use Tests\TestCase;

class ComplaintTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_submit_complaint(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->postJson('/api/v1/complaints', [
                'subject' => 'Test Complaint',
                'message' => 'This is a test complaint for automated testing.',
            ]);

        $response->assertStatus(201)
            ->assertJson(['success' => true]);
    }

    public function test_submit_complaint_validation(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->postJson('/api/v1/complaints', []);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['subject', 'message']);
    }

    public function test_list_complaints(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/complaints');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_complaints_require_auth(): void
    {
        $response = $this->getJson('/api/v1/complaints');
        $response->assertStatus(401);
    }
}
