<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Complaint;
use App\Models\Order;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ComplaintController extends Controller
{
    use ApiResponse;

    /**
     * List customer's complaints (paginated, newest first).
     */
    public function index(Request $request): JsonResponse
    {
        $complaints = Complaint::where('user_id', $request->user()->id)
            ->with('order:id,order_id,status')
            ->orderByDesc('created_at')
            ->paginate($request->input('per_page', 20));

        return $this->paginated($complaints);
    }

    /**
     * Submit a new complaint.
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'subject' => 'required|string|max:255',
            'message' => 'required|string|max:5000',
            'order_id' => 'nullable|integer',
        ]);

        $user = $request->user();

        // If order_id provided, verify it belongs to this user
        if (!empty($validated['order_id'])) {
            $order = Order::where('id', $validated['order_id'])
                ->where('user_id', $user->id)
                ->first();

            if (!$order) {
                return $this->error('Order not found', 404);
            }
        }

        $complaint = Complaint::create([
            'user_id' => $user->id,
            'order_id' => $validated['order_id'] ?? null,
            'subject' => $validated['subject'],
            'message' => $validated['message'],
            'status' => 'pending',
        ]);

        $complaint->load('order:id,order_id,status');

        return $this->success($complaint, 'Complaint submitted successfully', 201);
    }
}
