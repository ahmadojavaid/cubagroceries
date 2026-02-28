<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Banner;
use App\Models\Category;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;

class HomeController extends Controller
{
    use ApiResponse;

    /**
     * GET /api/v1/banners
     * Active banners ordered by sort_order.
     */
    public function banners(): JsonResponse
    {
        $banners = Banner::active()
            ->ordered()
            ->get(['id', 'title', 'image']);

        $banners->transform(fn ($b) => [
            'id' => $b->id,
            'title' => $b->title,
            'image' => $b->image ? asset('storage/' . $b->image) : null,
        ]);

        return $this->success($banners);
    }

    /**
     * GET /api/v1/home
     * Combined home screen data: banners + featured category sections with products.
     */
    public function home(): JsonResponse
    {
        // Banners
        $banners = Banner::active()
            ->ordered()
            ->get(['id', 'title', 'image'])
            ->map(fn ($b) => [
                'id' => $b->id,
                'title' => $b->title,
                'image' => $b->image ? asset('storage/' . $b->image) : null,
            ]);

        // Featured categories with their products (limit 6 per category)
        $featuredCategories = Category::featured()
            ->topLevel()
            ->with(['children:id,parent_id'])
            ->orderBy('title')
            ->get(['id', 'title', 'image']);

        $sections = $featuredCategories->map(function ($category) {
            // Collect this category ID + child IDs
            $categoryIds = collect([$category->id])
                ->merge($category->children->pluck('id'));

            // Get products with prices
            $products = \App\Models\Product::where(function ($q) use ($categoryIds) {
                    $q->whereIn('category_id', $categoryIds)
                      ->orWhereIn('sub_category_id', $categoryIds);
                })
                ->with(['prices.unit:id,name,abbreviation'])
                ->where('stock', '>', 0)
                ->limit(6)
                ->get();

            return [
                'category' => [
                    'id' => $category->id,
                    'title' => $category->title,
                    'image' => $category->image ? asset('storage/' . $category->image) : null,
                ],
                'products' => $products->map(fn ($p) => [
                    'id' => $p->id,
                    'name' => $p->name,
                    'description' => $p->description,
                    'stock' => $p->stock,
                    'prices' => $p->prices->map(fn ($price) => [
                        'id' => $price->id,
                        'price' => $price->price,
                        'unit' => [
                            'id' => $price->unit->id,
                            'name' => $price->unit->name,
                            'abbreviation' => $price->unit->abbreviation,
                        ],
                    ])->values(),
                ])->values(),
            ];
        })->filter(fn ($s) => $s['products']->isNotEmpty())->values();

        return $this->success([
            'banners' => $banners,
            'featured_sections' => $sections,
        ]);
    }
}
