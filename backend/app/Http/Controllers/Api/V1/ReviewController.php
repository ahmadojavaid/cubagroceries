<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\OrderReview;
use App\Models\Orderproduct;
use App\Models\Review;
use Illuminate\Http\Request;

class ReviewController extends Controller
{
    // ─── Product Reviews ─────────────────────────────────────

    /**
     * Get approved reviews for a product.
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
     * Submit a product review (must have purchased in a delivered order).
     */
    public function store(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:product,id',
            'order_id' => 'required|exists:orderdetails,id',
            'rating' => 'required|integer|min:1|max:5',
            'comment' => 'nullable|string|max:1000',
        ]);

        $userId = $request->user()->id;

        // Verify the order belongs to this user and is delivered
        $order = Order::where('id', $request->order_id)
            ->where('user_id', $userId)
            ->first();

        if (!$order) {
            return response()->json([
                'success' => false,
                'message' => 'Order not found.',
            ], 404);
        }

        if ($order->status->value !== 'delivered') {
            return response()->json([
                'success' => false,
                'message' => 'You can only review products from delivered orders.',
            ], 422);
        }

        // Verify this product was in the order
        $inOrder = Orderproduct::where('order_id', $request->order_id)
            ->where('product_id', $request->product_id)
            ->exists();

        if (!$inOrder) {
            return response()->json([
                'success' => false,
                'message' => 'This product was not part of the specified order.',
            ], 422);
        }

        // Check for existing review (same user + product + order)
        $existing = Review::where('user_id', $userId)
            ->where('product_id', $request->product_id)
            ->where('order_id', $request->order_id)
            ->first();

        if ($existing) {
            return response()->json([
                'success' => false,
                'message' => 'You have already reviewed this product for this order.',
            ], 422);
        }

        $review = Review::create([
            'user_id' => $userId,
            'product_id' => $request->product_id,
            'order_id' => $request->order_id,
            'rating' => $request->rating,
            'comment' => $request->comment,
            'status' => 'approved',
        ]);

        return response()->json([
            'success' => true,
            'data' => $review,
            'message' => 'Review submitted. Thank you!',
        ], 201);
    }

    /**
     * Check which products the user can review for a given order.
     * Returns products in the order with their review status.
     */
    public function reviewableProducts(Request $request, int $orderId)
    {
        $userId = $request->user()->id;

        $order = Order::where('id', $orderId)
            ->where('user_id', $userId)
            ->first();

        if (!$order) {
            return response()->json(['success' => false, 'message' => 'Order not found.'], 404);
        }

        $orderProducts = Orderproduct::where('order_id', $orderId)
            ->with('product:id,name')
            ->get();

        $existingReviews = Review::where('user_id', $userId)
            ->where('order_id', $orderId)
            ->pluck('product_id')
            ->toArray();

        $items = $orderProducts->map(fn ($op) => [
            'product_id' => $op->product_id,
            'product_name' => $op->product?->name ?? 'Unknown',
            'reviewed' => in_array($op->product_id, $existingReviews),
        ]);

        return response()->json([
            'success' => true,
            'data' => $items,
            'can_review' => $order->status->value === 'delivered',
        ]);
    }

    // ─── Order Reviews ───────────────────────────────────────

    /**
     * Submit an order review (overall experience).
     */
    public function storeOrderReview(Request $request)
    {
        $request->validate([
            'order_id' => 'required|exists:orderdetails,id',
            'rating' => 'required|integer|min:1|max:5',
            'comment' => 'nullable|string|max:1000',
        ]);

        $userId = $request->user()->id;

        $order = Order::where('id', $request->order_id)
            ->where('user_id', $userId)
            ->first();

        if (!$order) {
            return response()->json(['success' => false, 'message' => 'Order not found.'], 404);
        }

        if ($order->status->value !== 'delivered') {
            return response()->json([
                'success' => false,
                'message' => 'You can only review delivered orders.',
            ], 422);
        }

        $existing = OrderReview::where('user_id', $userId)
            ->where('order_id', $request->order_id)
            ->first();

        if ($existing) {
            return response()->json([
                'success' => false,
                'message' => 'You have already reviewed this order.',
            ], 422);
        }

        $review = OrderReview::create([
            'user_id' => $userId,
            'order_id' => $request->order_id,
            'rating' => $request->rating,
            'comment' => $request->comment,
        ]);

        return response()->json([
            'success' => true,
            'data' => $review,
            'message' => 'Order review submitted. Thank you!',
        ], 201);
    }

    /**
     * Get the order review for a specific order (if exists).
     */
    public function orderReview(Request $request, int $orderId)
    {
        $review = OrderReview::where('order_id', $orderId)
            ->where('user_id', $request->user()->id)
            ->first();

        return response()->json([
            'success' => true,
            'data' => $review ? [
                'id' => $review->id,
                'rating' => $review->rating,
                'comment' => $review->comment,
                'created_at' => $review->created_at->toIso8601String(),
            ] : null,
        ]);
    }
}
