<?php

namespace Tests\Feature\Api;

use App\Models\Address;
use App\Models\User;
use Tests\TestCase;

class AddressTest extends TestCase
{
    private function authUser(): User
    {
        return User::first();
    }

    public function test_list_addresses(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->getJson('/api/v1/addresses');

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_create_address(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->postJson('/api/v1/addresses', [
                'label' => 'Test Home',
                'address' => '123 Test Street, Block A',
                'city' => 'Lahore',
                'phone' => '03001234567',
                'latitude' => 31.5204,
                'longitude' => 74.3587,
            ]);

        $response->assertStatus(201)
            ->assertJson(['success' => true]);
    }

    public function test_create_address_validation(): void
    {
        $response = $this->actingAs($this->authUser(), 'sanctum')
            ->postJson('/api/v1/addresses', []);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['address']);
    }

    public function test_update_address(): void
    {
        $user = $this->authUser();

        // Create an address first
        $address = Address::create([
            'user_id' => $user->id,
            'label' => 'Old Label',
            'address' => 'Old Address',
            'city' => 'Lahore',
            'phone' => '03001111111',
        ]);

        $response = $this->actingAs($user, 'sanctum')
            ->putJson("/api/v1/addresses/{$address->id}", [
                'label' => 'Updated Label',
                'address' => 'Updated Address Line',
                'city' => 'Islamabad',
                'phone' => '03002222222',
            ]);

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_delete_address(): void
    {
        $user = $this->authUser();

        $address = Address::create([
            'user_id' => $user->id,
            'label' => 'To Delete',
            'address' => 'Delete me',
            'city' => 'Lahore',
            'phone' => '03003333333',
        ]);

        $response = $this->actingAs($user, 'sanctum')
            ->deleteJson("/api/v1/addresses/{$address->id}");

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_set_default_address(): void
    {
        $user = $this->authUser();

        $address = Address::create([
            'user_id' => $user->id,
            'label' => 'Make Default',
            'address' => 'Default test',
            'city' => 'Lahore',
            'phone' => '03004444444',
            'is_default' => false,
        ]);

        $response = $this->actingAs($user, 'sanctum')
            ->putJson("/api/v1/addresses/{$address->id}/default");

        $response->assertOk()
            ->assertJson(['success' => true]);
    }

    public function test_cannot_access_other_users_address(): void
    {
        $user1 = User::first();
        $user2 = User::where('id', '!=', $user1->id)->first();

        if (!$user2) {
            $this->markTestSkipped('Need at least 2 users');
        }

        $address = Address::create([
            'user_id' => $user2->id,
            'label' => 'Private',
            'address' => 'Other user address',
            'city' => 'Lahore',
            'phone' => '03005555555',
        ]);

        $response = $this->actingAs($user1, 'sanctum')
            ->putJson("/api/v1/addresses/{$address->id}", [
                'address' => 'Hacked!',
            ]);

        // Should be 404 or 403
        $this->assertTrue(in_array($response->status(), [403, 404]));
    }
}
