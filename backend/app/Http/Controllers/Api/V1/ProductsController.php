<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\SearchHistory;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProductsController extends Controller
{
    use ApiResponse;

    /**
     * List products (paginated, filterable by category/sub-category).
     * GET /api/v1/products
     */
    public function index(Request $request): JsonResponse
    {
        $query = Product::query()
            ->with([
                'category:id,title',
                'subCategory:id,title',
                'prices.unit:id,name,abbreviation',
            ]);

        if ($request->filled('category_id')) {
            $query->where('category_id', $request->integer('category_id'));
        }

        if ($request->filled('sub_category_id')) {
            $query->where('sub_category_id', $request->integer('sub_category_id'));
        }

        $products = $query->orderBy('name')
            ->paginate($request->integer('per_page', 20));

        $products->getCollection()->transform(function ($product) {
            return $this->formatProduct($product);
        });

        return $this->paginated($products);
    }

    /**
     * Get product detail with prices and units.
     * GET /api/v1/products/{id}
     */
    public function show(int $id): JsonResponse
    {
        $product = Product::with([
            'category:id,title',
            'subCategory:id,title',
            'prices.unit:id,name,abbreviation',
        ])->findOrFail($id);

        return $this->success($this->formatProduct($product));
    }

    /**
     * Search products by name.
     * GET /api/v1/products/search?q=
     */
    public function search(Request $request): JsonResponse
    {
        $request->validate([
            'q' => 'required|string|min:1|max:100',
        ]);

        $query = $request->string('q');

        $products = Product::where('name', 'ilike', "%{$query}%")
            ->with([
                'category:id,title',
                'subCategory:id,title',
                'prices.unit:id,name,abbreviation',
            ])
            ->orderBy('name')
            ->paginate($request->integer('per_page', 20));

        // Log search query
        if ($request->user()) {
            SearchHistory::create([
                'user_id' => $request->user()->id,
                'query' => $query,
                'results_count' => $products->total(),
            ]);
        }

        $products->getCollection()->transform(function ($product) {
            return $this->formatProduct($product);
        });

        return $this->paginated($products);
    }

    /**
     * Format a product for API response.
     */
    private function formatProduct(Product $product): array
    {
        return [
            'id' => $product->id,
            'name' => $product->name,
            'description' => $product->description,
            'image' => $product->image ? asset('storage/' . $product->image) : null,
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
