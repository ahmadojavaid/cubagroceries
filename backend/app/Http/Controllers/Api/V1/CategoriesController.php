<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CategoriesController extends Controller
{
    use ApiResponse;

    /**
     * List top-level categories with nested children.
     * GET /api/v1/categories
     */
    public function index(): JsonResponse
    {
        $categories = Category::whereNull('parent_id')
            ->with('children:id,title,image,parent_id')
            ->orderBy('title')
            ->get(['id', 'title', 'image', 'parent_id']);

        $categories->transform(function ($category) {
            return $this->formatCategory($category, true);
        });

        return $this->success($categories);
    }

    /**
     * Get single category with sub-categories.
     * GET /api/v1/categories/{id}
     */
    public function show(int $id): JsonResponse
    {
        $category = Category::with('children:id,title,image,parent_id')
            ->findOrFail($id);

        return $this->success($this->formatCategory($category, true));
    }

    /**
     * List paginated products in a category (includes sub-category products).
     * GET /api/v1/categories/{id}/products
     */
    public function products(Request $request, int $id): JsonResponse
    {
        $category = Category::findOrFail($id);

        // Get products from this category and its sub-categories
        $categoryIds = collect([$category->id]);
        $childIds = Category::where('parent_id', $category->id)->pluck('id');
        $categoryIds = $categoryIds->merge($childIds);

        $products = \App\Models\Product::whereIn('category_id', $categoryIds)
            ->orWhereIn('sub_category_id', $categoryIds)
            ->with([
                'category:id,title',
                'subCategory:id,title',
                'prices.unit:id,name,abbreviation',
            ])
            ->orderBy('name')
            ->paginate($request->integer('per_page', 20));

        $products->getCollection()->transform(function ($product) {
            return $this->formatProduct($product);
        });

        return $this->paginated($products);
    }

    /**
     * Format a category for API response.
     */
    private function formatCategory(Category $category, bool $includeChildren = false): array
    {
        $data = [
            'id' => $category->id,
            'title' => $category->title,
            'image' => $category->image ? asset('storage/' . $category->image) : null,
        ];

        if ($includeChildren && $category->relationLoaded('children')) {
            $data['children'] = $category->children->map(function ($child) {
                return $this->formatCategory($child, false);
            })->values();
        }

        return $data;
    }

    /**
     * Format a product for API response (reused by ProductsController).
     */
    private function formatProduct($product): array
    {
        return [
            'id' => $product->id,
            'name' => $product->name,
            'description' => $product->description,
            'stock' => $product->stock,
            'category' => $product->category ? [
                'id' => $product->category->id,
                'title' => $product->category->title,
            ] : null,
            'sub_category' => $product->subCategory ? [
                'id' => $product->subCategory->id,
                'title' => $product->subCategory->title,
            ] : null,
            'prices' => $product->prices->map(function ($price) {
                return [
                    'id' => $price->id,
                    'price' => $price->price,
                    'unit' => [
                        'id' => $price->unit->id,
                        'name' => $price->unit->name,
                        'abbreviation' => $price->unit->abbreviation,
                    ],
                ];
            })->values(),
        ];
    }
}
