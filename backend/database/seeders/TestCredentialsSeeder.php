<?php

namespace Database\Seeders;

use App\Models\DeliveryBoy;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Schema;

class TestCredentialsSeeder extends Seeder
{
    public function run(): void
    {
        if (! Schema::hasTable('users')) {
            $this->command->warn('Users table not found — skipping TestCredentialsSeeder.');
            return;
        }

        // ── Test Customer ────────────────────────────────────────────────────
        User::firstOrCreate(
            ['email' => 'customer@test.com'],
            [
                'identity'      => '03001234567',
                'firstname'     => 'Test',
                'lastname'      => 'Customer',
                'password'      => 'password123',
                'role'          => 'customer',
                'wallet_amount' => 500.00,
                'date_of_birth' => '1995-06-15',
            ]
        );

        // ── Test Rider ───────────────────────────────────────────────────────
        $riderUser = User::firstOrCreate(
            ['email' => 'rider@test.com'],
            [
                'identity'      => '03009876543',
                'firstname'     => 'Test',
                'lastname'      => 'Rider',
                'password'      => 'password123',
                'role'          => 'rider',
                'wallet_amount' => 0.00,
                'date_of_birth' => '1993-03-20',
            ]
        );

        // Link a DeliveryBoy record to the rider user (if table exists)
        if (Schema::hasTable('deliveryboy') && Schema::hasColumn('deliveryboy', 'user_id')) {
            DeliveryBoy::firstOrCreate(
                ['user_id' => $riderUser->id],
                [
                    'name'    => 'Test Rider',
                    'phone'   => '03009876543',
                    'payment' => 0.00,
                ]
            );
        }

        $this->command->info('Test credentials seeded:');
        $this->command->info('  Customer → customer@test.com / password123');
        $this->command->info('  Rider    → rider@test.com    / password123');
    }
}
