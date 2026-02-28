<?php

namespace Database\Seeders;

use App\Models\PortalUser;
use Illuminate\Database\Seeder;

class AdminSeeder extends Seeder
{
    public function run(): void
    {
        PortalUser::firstOrCreate(
            ['email' => 'admin@cubagroceries.test'],
            [
                'name' => 'Super Admin',
                'password' => 'password',
                'role' => PortalUser::ROLE_SUPER_ADMIN,
            ]
        );

        PortalUser::firstOrCreate(
            ['email' => 'manager@cubagroceries.test'],
            [
                'name' => 'Rahim Manager',
                'password' => 'password',
                'role' => PortalUser::ROLE_ADMIN,
            ]
        );

        PortalUser::firstOrCreate(
            ['email' => 'staff@cubagroceries.test'],
            [
                'name' => 'Zara Staff',
                'password' => 'password',
                'role' => PortalUser::ROLE_STAFF,
            ]
        );
    }
}
