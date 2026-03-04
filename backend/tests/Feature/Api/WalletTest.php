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
                'data' => ['wallet_amount'],
            ]);
    }

    public function test_wallet_balance_is_numeric(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/wallet');

        $response->assertOk();
        $this->assertIsNumeric($response->json('data.wallet_amount'));
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
