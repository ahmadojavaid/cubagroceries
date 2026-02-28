<?php

namespace Database\Seeders;

use App\Models\Unit;
use Illuminate\Database\Seeder;

class UnitSeeder extends Seeder
{
    public function run(): void
    {
        $units = [
            ['name' => 'Kilogram', 'abbreviation' => 'kg'],
            ['name' => 'Gram', 'abbreviation' => 'g'],
            ['name' => 'Piece', 'abbreviation' => 'pc'],
            ['name' => 'Dozen', 'abbreviation' => 'dz'],
            ['name' => 'Pack', 'abbreviation' => 'pk'],
            ['name' => 'Litre', 'abbreviation' => 'L'],
        ];

        foreach ($units as $unit) {
            Unit::firstOrCreate(
                ['name' => $unit['name']],
                $unit
            );
        }
    }
}
