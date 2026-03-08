<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call([
            AdminSeeder::class,
            UnitSeeder::class,
            CatalogSeeder::class,
            ImageSeeder::class,
            SampleDataSeeder::class,
            SurveySeeder::class,
            TestCredentialsSeeder::class,
        ]);
    }
}
