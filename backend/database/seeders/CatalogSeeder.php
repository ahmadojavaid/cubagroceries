<?php

namespace Database\Seeders;

use App\Models\Category;
use App\Models\Price;
use App\Models\Product;
use App\Models\Unit;
use Illuminate\Database\Seeder;

class CatalogSeeder extends Seeder
{
    public function run(): void
    {
        // Use proper units from UnitSeeder (capitalized names)
        $kg = Unit::where('abbreviation', 'kg')->first() ?? Unit::firstOrCreate(['name' => 'Kilogram'], ['abbreviation' => 'kg']);
        $piece = Unit::where('name', 'Piece')->first() ?? Unit::firstOrCreate(['name' => 'Piece'], ['abbreviation' => 'pc']);
        $dozen = Unit::where('name', 'Dozen')->first() ?? Unit::firstOrCreate(['name' => 'Dozen'], ['abbreviation' => 'dz']);
        $litre = Unit::where('name', 'Litre')->first() ?? Unit::firstOrCreate(['name' => 'Litre'], ['abbreviation' => 'L']);
        $pack = Unit::where('name', 'Pack')->first() ?? Unit::firstOrCreate(['name' => 'Pack'], ['abbreviation' => 'pk']);

        // --- Fruits ---
        $fruits = Category::firstOrCreate(['title' => 'Fruits', 'parent_id' => null]);
        $citrus = Category::firstOrCreate(['title' => 'Citrus', 'parent_id' => $fruits->id]);
        $tropical = Category::firstOrCreate(['title' => 'Tropical', 'parent_id' => $fruits->id]);

        $this->createProduct('Fresh Oranges', 'Sweet and juicy oranges, handpicked from the best orchards', $fruits, $citrus, 150, [
            [$kg, 180], [$dozen, 250],
        ]);
        $this->createProduct('Lemons', 'Sour lemons perfect for cooking, drinks and garnishing', $fruits, $citrus, 200, [
            [$kg, 120], [$piece, 15],
        ]);
        $this->createProduct('Mangoes', 'Premium seasonal Sindhri mangoes — the king of fruits', $fruits, $tropical, 80, [
            [$kg, 350], [$dozen, 500],
        ]);
        $this->createProduct('Bananas', 'Ripe yellow bananas, naturally sweet and energy-packed', $fruits, $tropical, 120, [
            [$dozen, 100], [$piece, 10],
        ]);

        // --- Vegetables ---
        $vegetables = Category::firstOrCreate(['title' => 'Vegetables', 'parent_id' => null]);
        $fresh = Category::firstOrCreate(['title' => 'Fresh Vegetables', 'parent_id' => $vegetables->id]);
        $root = Category::firstOrCreate(['title' => 'Root Vegetables', 'parent_id' => $vegetables->id]);

        $this->createProduct('Fresh Tomatoes', 'Farm fresh red tomatoes, great for salads and cooking', $vegetables, $fresh, 100, [
            [$kg, 120], [$piece, 25],
        ]);
        $this->createProduct('Onions', 'White onions — a kitchen essential for every Pakistani household', $vegetables, $fresh, 200, [
            [$kg, 80],
        ]);
        $this->createProduct('Potatoes', 'Clean washed potatoes ready for your next biryani or aloo gosht', $vegetables, $root, 300, [
            [$kg, 60],
        ]);
        $this->createProduct('Carrots', 'Fresh orange carrots, sweet and crunchy', $vegetables, $root, 90, [
            [$kg, 100], [$piece, 15],
        ]);

        // --- Dairy ---
        $dairy = Category::firstOrCreate(['title' => 'Dairy', 'parent_id' => null]);
        $milk = Category::firstOrCreate(['title' => 'Milk & Cream', 'parent_id' => $dairy->id]);
        $cheese = Category::firstOrCreate(['title' => 'Cheese & Butter', 'parent_id' => $dairy->id]);

        $this->createProduct('Fresh Milk', 'Pasteurized full cream milk, delivered fresh daily', $dairy, $milk, 50, [
            [$litre, 180], [$pack, 90],
        ]);
        $this->createProduct('Yogurt', 'Plain natural yogurt — thick, creamy dahi', $dairy, $milk, 60, [
            [$kg, 160],
        ]);
        $this->createProduct('Cheddar Cheese', 'Aged cheddar block, rich and flavourful', $dairy, $cheese, 30, [
            [$pack, 350],
        ]);

        // --- Beverages ---
        $beverages = Category::firstOrCreate(['title' => 'Beverages', 'parent_id' => null]);
        $juices = Category::firstOrCreate(['title' => 'Juices', 'parent_id' => $beverages->id]);
        $softDrinks = Category::firstOrCreate(['title' => 'Soft Drinks', 'parent_id' => $beverages->id]);

        $this->createProduct('Orange Juice', 'Fresh squeezed orange juice with no added sugar', $beverages, $juices, 40, [
            [$litre, 220], [$pack, 120],
        ]);
        $this->createProduct('Apple Juice', '100% pure apple juice, naturally refreshing', $beverages, $juices, 35, [
            [$litre, 250],
        ]);
        $this->createProduct('Cola', 'Classic carbonated cola drink, perfectly chilled', $beverages, $softDrinks, 100, [
            [$litre, 100], [$pack, 60],
        ]);
    }

    private function createProduct(
        string $name,
        string $description,
        Category $category,
        Category $subCategory,
        int $stock,
        array $prices
    ): void {
        $product = Product::firstOrCreate(
            ['name' => $name],
            [
                'description' => $description,
                'category_id' => $category->id,
                'sub_category_id' => $subCategory->id,
                'stock' => $stock,
            ]
        );

        foreach ($prices as [$unit, $price]) {
            Price::firstOrCreate(
                ['product_id' => $product->id, 'unit_id' => $unit->id],
                ['price' => $price]
            );
        }
    }
}
