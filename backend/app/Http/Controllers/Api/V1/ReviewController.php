<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Review;
use Illuminate\Http\Request;

class ReviewController extends Controller
{
    /**
     * Get reviews for a product (only approved ones).
     */
    public function forProduct(int $productId)
    {
        $reviews = Review::where('product_id', $productId)
            ->approved()
            ->with('user:id,firstname,lastname')
            ->latest()
            ->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $reviews->through(fn ($review) => [
                'id' => $review->id,
                'rating' => $review->rating,
                'comment' => $review->comment,
                'customer' => $review->user->firstname . ' ' . substr($review->user->lastname, 0, 1) . '.',
                'created_at' => $review->created_at->toIso8601String(),
            ]),
            'meta' => [
                'current_page' => $reviews->currentPage(),
                'last_page' => $reviews->lastPage(),
                'per_page' => $reviews->perPage(),
                'total' => $reviews->total(),
            ],
        ]);
    }

    /**
     * Submit a review for a product.
     */
    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:product,id',
            'order_id' => 'nullable|exists:orderdetails,id',
            'rating' => 'required|integer|min:1|max:5',
            'comment' => 'nullable|string|max:1000',
        ]);

        // Check if user already reviewed this product
        $existing = Review::where('user_id', $request->user()->id)
            ->where('product_id', $request->product_id)
            ->first();

        if ($existing) {
            return response()->json([
                'success' => false,
                'message' => 'You have already reviewed this product.',
            ], 422);
        }

        $review = Review::create([
            'user_id' => $request->user()->id,
            'product_id' => $request->product_id,
            'order_id' => $request->order_id,
            'rating' => $request->rating,
            'comment' => $request->comment,
            'status' => 'pending',
        ]);

        return response()->json([
            'success' => true,
            'data' => $review,
            'message' => 'Review submitted. It will appear after approval.',
        ], 201);
    }
}
