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
    }
}
