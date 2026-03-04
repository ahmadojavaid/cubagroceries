<?php

namespace Tests\Feature\Api;

use App\Models\User;
use Tests\TestCase;

class AuthTest extends TestCase
{
    public function test_register_creates_customer_and_returns_token(): void
    {
        $response = $this->postJson('/api/v1/auth/register', [
            'identity' => '03009999999',
            'email' => 'testuser_' . uniqid() . '@test.com',
            'firstname' => 'Test',
            'lastname' => 'User',
            'password' => 'password123',
            'password_confirmation' => 'password123',
            'date_of_birth' => '2000-01-15',
        ]);

        $response->assertStatus(201)
            ->assertJsonStructure([
                'success',
                'data' => ['user', 'token'],
            ])
            ->assertJson(['success' => true]);
    }

    public function test_register_fails_with_missing_fields(): void
    {
        $response = $this->postJson('/api/v1/auth/register', []);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['identity', 'email', 'firstname', 'lastname', 'password']);
    }

    public function test_register_fails_with_duplicate_email(): void
    {
        $existing = User::first();

        $response = $this->postJson('/api/v1/auth/register', [
            'identity' => '03001112222',
            'email' => $existing->email,
            'firstname' => 'Dup',
            'lastname' => 'User',
            'password' => 'password123',
            'password_confirmation' => 'password123',
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email']);
    }

    public function test_login_with_valid_credentials(): void
    {
        $email = 'logintest_' . uniqid() . '@test.com';
        User::create([
            'identity' => '03008888888',
            'email' => $email,
            'firstname' => 'Login',
            'lastname' => 'Test',
            'password' => bcrypt('password123'),
        ]);

        $response = $this->postJson('/api/v1/auth/login', [
            'email' => $email,
            'password' => 'password123',
        ]);

        $response->assertOk()
            ->assertJsonStructure([
                'success',
                'data' => ['user', 'token'],
            ])
            ->assertJson(['success' => true]);
    }

    public function test_login_fails_with_wrong_password(): void
    {
        $user = User::first();

        $response = $this->postJson('/api/v1/auth/login', [
            'email' => $user->email,
            'password' => 'totallyWrongPassword',
        ]);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['email']);
    }

    public function test_logout_revokes_token(): void
    {
        $user = User::first();
        $token = $user->createToken('test')->plainTextToken;

        $response = $this->withHeaders([
            'Authorization' => 'Bearer ' . $token,
        ])->postJson('/api/v1/auth/logout');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_get_authenticated_user(): void
    {
        $user = User::first();

        $response = $this->actingAs($user, 'sanctum')
            ->getJson('/api/v1/auth/user');

        $response->assertOk()
            ->assertJson([
                'success' => true,
                'data' => [
                    'email' => $user->email,
                    'firstname' => $user->firstname,
                ],
            ]);
    }

    public function test_unauthenticated_request_returns_401(): void
    {
        $response = $this->getJson('/api/v1/auth/user');

        $response->assertStatus(401);
    }
}
