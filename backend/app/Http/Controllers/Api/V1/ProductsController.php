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
     * Get user's recent search history (unique queries, latest first).
     * GET /api/v1/search-history
     */
    public function searchHistory(Request $request): JsonResponse
    {
        $history = SearchHistory::where('user_id', $request->user()->id)
            ->select('id', 'query', 'results_count', 'created_at')
            ->latest()
            ->take(15)
            ->get()
            ->unique('query')
            ->take(10)
            ->values();

        return $this->success($history);
    }

    /**
     * Clear all search history.
     * DELETE /api/v1/search-history
     */
    public function clearSearchHistory(Request $request): JsonResponse
    {
        SearchHistory::where('user_id', $request->user()->id)->delete();

        return $this->success(null, 'Search history cleared.');
    }

    /**
     * Delete a single search history item.
     * DELETE /api/v1/search-history/{id}
     */
    public function deleteSearchHistoryItem(Request $request, int $id): JsonResponse
    {
        SearchHistory::where('id', $id)
            ->where('user_id', $request->user()->id)
            ->delete();

        return $this->success(null, 'Search entry removed.');
    }

    /**
     * Get related products (same category, excluding current product).
     * GET /api/v1/products/{id}/related
     */
    public function related(int $id): JsonResponse
    {
        $product = Product::findOrFail($id);

        $related = Product::where('id', '!=', $product->id)
            ->where(function ($q) use ($product) {
                $q->where('category_id', $product->category_id);
                if ($product->sub_category_id) {
                    $q->orWhere('sub_category_id', $product->sub_category_id);
                }
            })
            ->where('stock', '>', 0)
            ->with([
                'category:id,title',
                'subCategory:id,title',
                'prices.unit:id,name,abbreviation',
            ])
            ->inRandomOrder()
            ->limit(8)
            ->get();

        $formatted = $related->map(function ($p) {
            return $this->formatProduct($p);
        })->values();

        return $this->success($formatted);
    }

    /**
     * Suggestions based on cart items (same categories, excluding given product IDs).
     * GET /api/v1/products/suggestions?ids=1,2,3
     */
    public function suggestions(Request $request): JsonResponse
    {
        $request->validate([
            'ids' => 'required|string',
        ]);

        $productIds = collect(explode(',', $request->string('ids')))
            ->map(fn ($id) => (int) trim($id))
            ->filter(fn ($id) => $id > 0)
            ->unique()
            ->values();

        if ($productIds->isEmpty()) {
            return $this->success([]);
        }

        // Get categories of cart products
        $cartProducts = Product::whereIn('id', $productIds)->get(['id', 'category_id', 'sub_category_id']);
        $categoryIds = $cartProducts->pluck('category_id')->unique()->filter();
        $subCategoryIds = $cartProducts->pluck('sub_category_id')->unique()->filter();

        $suggestions = Product::whereNotIn('id', $productIds)
            ->where('stock', '>', 0)
            ->where(function ($q) use ($categoryIds, $subCategoryIds) {
                $q->whereIn('category_id', $categoryIds);
                if ($subCategoryIds->isNotEmpty()) {
                    $q->orWhereIn('sub_category_id', $subCategoryIds);
                }
            })
            ->with([
                'category:id,title',
                'subCategory:id,title',
                'prices.unit:id,name,abbreviation',
            ])
            ->inRandomOrder()
            ->limit(10)
            ->get();

        $formatted = $suggestions->map(fn ($p) => $this->formatProduct($p))->values();

        return $this->success($formatted);
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
