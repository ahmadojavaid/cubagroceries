<?php

namespace Tests\Feature\Api;

use App\Models\User;
use Tests\TestCase;

class WalletTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_get_wallet_balance(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/wallet');

        $response->assertOk()
            ->assertJson(['success' => true])
            ->assertJsonStructure([
                'data' => ['balance'],
            ]);
    }

    public function test_get_wallet_transactions(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/wallet/transactions');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_wallet_requires_auth(): void
    {
        $response = $this->getJson('/api/v1/wallet');
        $response->assertStatus(401);
    }
}
