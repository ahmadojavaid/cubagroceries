<?php

namespace Database\Seeders;

use App\Models\Banner;
use App\Models\Category;
use App\Models\Product;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class ImageSeeder extends Seeder
{
    /**
     * Seed images for categories, products, and banners.
     * Downloads real images from free sources, falls back to generated placeholders.
     */
    public function run(): void
    {
        // Ensure storage link exists
        if (!file_exists(public_path('storage'))) {
            $this->command->call('storage:link');
        }

        $this->seedCategoryImages();
        $this->command->info('  ✓ Category images seeded');

        $this->seedProductImages();
        $this->command->info('  ✓ Product images seeded');

        $this->seedBanners();
        $this->command->info('  ✓ Banners seeded');

        $this->markFeaturedCategories();
        $this->command->info('  ✓ Featured categories marked');
    }

    // ─── Category Images ────────────────────────────────────────

    private function seedCategoryImages(): void
    {
        $categoryImages = [
            'Fruits'           => 'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=400&h=400&fit=crop',
            'Vegetables'       => 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400&h=400&fit=crop',
            'Dairy'            => 'https://images.unsplash.com/photo-1628088062854-d1870b4553da?w=400&h=400&fit=crop',
            'Beverages'        => 'https://images.unsplash.com/photo-1625772299848-391b6a87d7b3?w=400&h=400&fit=crop',
            'Citrus'           => 'https://images.unsplash.com/photo-1582979512210-99b6a53386f9?w=400&h=400&fit=crop',
            'Tropical'         => 'https://images.unsplash.com/photo-1490885578174-acda8905c2c6?w=400&h=400&fit=crop',
            'Fresh Vegetables' => 'https://images.unsplash.com/photo-1597362925123-77861d3fbac7?w=400&h=400&fit=crop',
            'Root Vegetables'  => 'https://images.unsplash.com/photo-1518977676601-b53f82ber633?w=400&h=400&fit=crop',
            'Milk & Cream'     => 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=400&h=400&fit=crop',
            'Cheese & Butter'  => 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400&h=400&fit=crop',
            'Juices'           => 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=400&h=400&fit=crop',
            'Soft Drinks'      => 'https://images.unsplash.com/photo-1581636625402-29b2a704ef13?w=400&h=400&fit=crop',
        ];

        $fallbackColors = [
            'Fruits' => [255, 165, 0], 'Vegetables' => [76, 175, 80],
            'Dairy' => [100, 181, 246], 'Beverages' => [239, 83, 80],
            'Citrus' => [255, 193, 7], 'Tropical' => [255, 138, 101],
            'Fresh Vegetables' => [102, 187, 106], 'Root Vegetables' => [141, 110, 99],
            'Milk & Cream' => [144, 202, 249], 'Cheese & Butter' => [255, 213, 79],
            'Juices' => [255, 183, 77], 'Soft Drinks' => [229, 57, 53],
        ];

        foreach (Category::all() as $category) {
            if ($category->image) continue;

            $filename = 'categories/' . $category->id . '_' . Str::slug($category->title) . '.jpg';
            $url = $categoryImages[$category->title] ?? null;

            if ($url && $this->downloadImage($url, $filename)) {
                $category->update(['image' => $filename]);
            } else {
                // Fallback to generated
                $bg = $fallbackColors[$category->title] ?? [158, 158, 158];
                $this->generatePlaceholder($filename, 400, 400, $bg, $category->title);
                $category->update(['image' => $filename]);
            }
        }
    }

    // ─── Product Images ─────────────────────────────────────────

    private function seedProductImages(): void
    {
        $productImages = [
            'Fresh Oranges'  => 'https://images.unsplash.com/photo-1547514701-42782101795e?w=600&h=600&fit=crop',
            'Lemons'         => 'https://images.unsplash.com/photo-1590502593747-42a996133562?w=600&h=600&fit=crop',
            'Mangoes'        => 'https://images.unsplash.com/photo-1553279768-865429fa0078?w=600&h=600&fit=crop',
            'Bananas'        => 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=600&h=600&fit=crop',
            'Fresh Tomatoes' => 'https://images.unsplash.com/photo-1546470427-0d4db154ceb8?w=600&h=600&fit=crop',
            'Onions'         => 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=600&h=600&fit=crop',
            'Potatoes'       => 'https://images.unsplash.com/photo-1518977676601-b53f82ber633?w=600&h=600&fit=crop',
            'Carrots'        => 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=600&h=600&fit=crop',
            'Fresh Milk'     => 'https://images.unsplash.com/photo-1563636619-e9143da7973b?w=600&h=600&fit=crop',
            'Yogurt'         => 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=600&h=600&fit=crop',
            'Cheddar Cheese' => 'https://images.unsplash.com/photo-1618164436241-4473940d1f5c?w=600&h=600&fit=crop',
            'Orange Juice'   => 'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=600&h=600&fit=crop',
            'Apple Juice'    => 'https://images.unsplash.com/photo-1576673442511-7e39b6545c87?w=600&h=600&fit=crop',
            'Cola'           => 'https://images.unsplash.com/photo-1581636625402-29b2a704ef13?w=600&h=600&fit=crop',
        ];

        $fallbackColors = [
            'Fresh Oranges' => [255, 152, 0], 'Lemons' => [255, 235, 59],
            'Mangoes' => [255, 167, 38], 'Bananas' => [255, 238, 88],
            'Fresh Tomatoes' => [229, 57, 53], 'Onions' => [188, 170, 164],
            'Potatoes' => [161, 136, 127], 'Carrots' => [255, 112, 67],
            'Fresh Milk' => [227, 242, 253], 'Yogurt' => [232, 234, 246],
            'Cheddar Cheese' => [255, 224, 130], 'Orange Juice' => [255, 183, 77],
            'Apple Juice' => [165, 214, 167], 'Cola' => [78, 52, 46],
        ];

        foreach (Product::all() as $product) {
            if ($product->image) continue;

            $filename = 'products/' . $product->id . '_' . Str::slug($product->name) . '.jpg';
            $url = $productImages[$product->name] ?? null;

            if ($url && $this->downloadImage($url, $filename)) {
                $product->update(['image' => $filename]);
            } else {
                $bg = $fallbackColors[$product->name] ?? [158, 158, 158];
                $this->generatePlaceholder($filename, 600, 600, $bg, $product->name);
                $product->update(['image' => $filename]);
            }
        }
    }

    // ─── Banners ────────────────────────────────────────────────

    private function seedBanners(): void
    {
        if (Banner::count() > 0) return;

        $banners = [
            [
                'title' => 'Fresh Fruits Daily',
                'url' => 'https://images.unsplash.com/photo-1610832958506-aa56368176cf?w=1200&h=675&fit=crop',
                'bg' => [76, 175, 80],
                'subtitle' => 'Farm to your doorstep',
                'sort_order' => 1,
            ],
            [
                'title' => 'Free Delivery',
                'url' => 'https://images.unsplash.com/photo-1543168256-418811576931?w=1200&h=675&fit=crop',
                'bg' => [33, 150, 243],
                'subtitle' => 'On orders above Rs 2,000',
                'sort_order' => 2,
            ],
            [
                'title' => 'Dairy Specials',
                'url' => 'https://images.unsplash.com/photo-1628088062854-d1870b4553da?w=1200&h=675&fit=crop',
                'bg' => [255, 152, 0],
                'subtitle' => 'Fresh milk, yogurt & more',
                'sort_order' => 3,
            ],
        ];

        foreach ($banners as $banner) {
            $filename = 'banners/' . Str::slug($banner['title']) . '.jpg';

            if (!$this->downloadImage($banner['url'], $filename)) {
                // Fallback to generated banner
                $this->generateBannerPlaceholder(
                    $filename, 1200, 675, $banner['bg'],
                    $banner['title'], $banner['subtitle']
                );
            }

            Banner::create([
                'title' => $banner['title'],
                'image' => $filename,
                'sort_order' => $banner['sort_order'],
                'is_active' => true,
            ]);
        }
    }

    // ─── Featured ───────────────────────────────────────────────

    private function markFeaturedCategories(): void
    {
        Category::whereNull('parent_id')->update(['is_featured' => true]);
    }

    // ─── Download Helper ────────────────────────────────────────

    /**
     * Download an image from URL and save to storage.
     */
    private function downloadImage(string $url, string $path): bool
    {
        try {
            $response = Http::timeout(10)
                ->withOptions(['verify' => false])
                ->get($url);

            if ($response->successful()) {
                $fullDir = Storage::disk('public')->path(dirname($path));
                if (!is_dir($fullDir)) {
                    mkdir($fullDir, 0755, true);
                }

                Storage::disk('public')->put($path, $response->body());
                return true;
            }
        } catch (\Exception $e) {
            $this->command?->warn("  ⚠ Failed to download: " . basename($path) . " — using placeholder");
        }

        return false;
    }

    // ─── Fallback Generated Placeholders ────────────────────────

    /**
     * Generate a simple colored placeholder with text.
     */
    private function generatePlaceholder(string $path, int $w, int $h, array $bg, string $label): void
    {
        $img = imagecreatetruecolor($w, $h);
        $bgColor = imagecolorallocate($img, $bg[0], $bg[1], $bg[2]);
        imagefill($img, 0, 0, $bgColor);

        // Light overlay circle
        $lighter = imagecolorallocatealpha($img, 255, 255, 255, 90);
        imagefilledellipse($img, (int)($w / 2), (int)($h / 2) - 20, (int)($w * 0.6), (int)($h * 0.6), $lighter);

        // Text
        $textColor = imagecolorallocate($img, 255, 255, 255);
        $shadowColor = imagecolorallocate($img, 0, 0, 0);
        $fontSize = 4;
        $textWidth = imagefontwidth($fontSize) * strlen($label);
        $textX = (int)(($w - $textWidth) / 2);
        $textY = $h - 50;
        imagestring($img, $fontSize, $textX + 1, $textY + 1, $label, $shadowColor);
        imagestring($img, $fontSize, $textX, $textY, $label, $textColor);

        // Big initials
        $bigFont = 5;
        $initial = strtoupper(substr($label, 0, 2));
        $initialWidth = imagefontwidth($bigFont) * strlen($initial);
        imagestring($img, $bigFont, (int)(($w - $initialWidth) / 2), (int)($h / 2) - 28, $initial, $textColor);

        $fullDir = Storage::disk('public')->path(dirname($path));
        if (!is_dir($fullDir)) mkdir($fullDir, 0755, true);

        imagepng($img, Storage::disk('public')->path($path));
        imagedestroy($img);
    }

    /**
     * Generate a wide banner placeholder.
     */
    private function generateBannerPlaceholder(string $path, int $w, int $h, array $bg, string $title, string $subtitle): void
    {
        $img = imagecreatetruecolor($w, $h);

        // Gradient
        for ($y = 0; $y < $h; $y++) {
            $factor = $y / $h;
            $r = (int)($bg[0] * (1 - $factor * 0.3));
            $g = (int)($bg[1] * (1 - $factor * 0.3));
            $b = (int)($bg[2] * (1 - $factor * 0.3));
            $lineColor = imagecolorallocate($img, max(0, $r), max(0, $g), max(0, $b));
            imageline($img, 0, $y, $w, $y, $lineColor);
        }

        // Decorative circles
        $circleColor = imagecolorallocatealpha($img, 255, 255, 255, 100);
        imagefilledellipse($img, (int)($w * 0.8), (int)($h * 0.3), 300, 300, $circleColor);
        imagefilledellipse($img, (int)($w * 0.9), (int)($h * 0.7), 200, 200, $circleColor);

        $textColor = imagecolorallocate($img, 255, 255, 255);
        $shadowColor = imagecolorallocatealpha($img, 0, 0, 0, 80);

        // Brand
        imagestring($img, 3, 60, (int)($h / 2) - 70, 'CUBA GROCERIES', imagecolorallocatealpha($img, 255, 255, 255, 50));

        // Title
        imagestring($img, 5, 61, (int)($h / 2) - 31, $title, $shadowColor);
        imagestring($img, 5, 60, (int)($h / 2) - 30, $title, $textColor);

        // Subtitle
        imagestring($img, 4, 61, (int)($h / 2) + 1, $subtitle, $shadowColor);
        imagestring($img, 4, 60, (int)($h / 2), $subtitle, $textColor);

        $fullDir = Storage::disk('public')->path(dirname($path));
        if (!is_dir($fullDir)) mkdir($fullDir, 0755, true);

        imagepng($img, Storage::disk('public')->path($path));
        imagedestroy($img);
    }
}
