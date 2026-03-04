<?php

namespace Tests\Feature\Api;

use App\Models\User;
use Tests\TestCase;

class ProfileTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_get_profile(): void
    {
        $user = $this->authUser();

        $response = $this->actingAs($user, 'sanctum')
            ->getJson('/api/v1/profile');

        $response->assertOk()
            ->assertJson([
                'success' => true,
                'data' => [
                    'email' => $user->email,
                    'firstname' => $user->firstname,
                    'lastname' => $user->lastname,
                ],
            ]);
    }

    public function test_update_profile(): void
    {
        $user = $this->authUser();

        $response = $this->actingAs($user, 'sanctum')
            ->putJson('/api/v1/profile', [
                'firstname' => 'Updated',
                'lastname' => 'Name',
                'email' => $user->email,
            ]);

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_update_profile_validation(): void
    {
        $user = $this->authUser();

        $response = $this->actingAs($user, 'sanctum')
            ->putJson('/api/v1/profile', [
                'firstname' => '',
                'lastname' => '',
            ]);

        $response->assertStatus(422);
    }

    public function test_change_password(): void
    {
        // Create a dedicated user for this test
        $user = User::create([
            'identity' => '03005550000',
            'email' => 'pwtest_' . uniqid() . '@test.com',
            'firstname' => 'Pw',
            'lastname' => 'Test',
            'password' => bcrypt('oldpassword'),
        ]);

        $response = $this->actingAs($user, 'sanctum')
            ->putJson('/api/v1/profile/password', [
                'current_password' => 'oldpassword',
                'password' => 'newpassword123',
                'password_confirmation' => 'newpassword123',
            ]);

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_change_password_fails_with_wrong_current(): void
    {
        $user = $this->authUser();

        $response = $this->actingAs($user, 'sanctum')
            ->putJson('/api/v1/profile/password', [
                'current_password' => 'definitelyWrongPassword',
                'password' => 'newpassword123',
                'password_confirmation' => 'newpassword123',
            ]);

        $response->assertStatus(422);
    }

    public function test_profile_requires_auth(): void
    {
        $response = $this->getJson('/api/v1/profile');

        $response->assertStatus(401);
    }
}
