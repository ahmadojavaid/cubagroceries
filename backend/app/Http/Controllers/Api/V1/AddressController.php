<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\Address;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AddressController extends Controller
{
    use ApiResponse;

    /**
     * GET /api/v1/addresses
     */
    public function index(Request $request): JsonResponse
    {
        $addresses = $request->user()
            ->addresses()
            ->orderByDesc('is_default')
            ->orderByDesc('created_at')
            ->get();

        return $this->success($addresses);
    }

    /**
     * POST /api/v1/addresses
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'label' => 'nullable|string|max:100',
            'address' => 'required|string',
            'city' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:50',
            'latitude' => 'nullable|numeric|between:-90,90',
            'longitude' => 'nullable|numeric|between:-180,180',
        ]);

        // Auto-set default if this is the user's first address
        $isFirst = $request->user()->addresses()->count() === 0;
        $validated['is_default'] = $isFirst;

        $address = $request->user()->addresses()->create($validated);

        return $this->success($address, 'Address added successfully', 201);
    }

    /**
     * PUT /api/v1/addresses/{id}
     */
    public function update(Request $request, int $id): JsonResponse
    {
        $address = $request->user()->addresses()->findOrFail($id);

        $validated = $request->validate([
            'label' => 'nullable|string|max:100',
            'address' => 'required|string',
            'city' => 'nullable|string|max:255',
            'phone' => 'nullable|string|max:50',
            'latitude' => 'nullable|numeric|between:-90,90',
            'longitude' => 'nullable|numeric|between:-180,180',
        ]);

        $address->update($validated);

        return $this->success($address->fresh(), 'Address updated successfully');
    }

    /**
     * DELETE /api/v1/addresses/{id}
     */
    public function destroy(Request $request, int $id): JsonResponse
    {
        $address = $request->user()->addresses()->findOrFail($id);

        $wasDefault = $address->is_default;
        $address->delete();

        // If deleted address was default, reassign to most recent remaining
        if ($wasDefault) {
            $nextDefault = $request->user()->addresses()->latest()->first();
            if ($nextDefault) {
                $nextDefault->update(['is_default' => true]);
            }
        }

        return $this->success(message: 'Address deleted successfully');
    }

    /**
     * PUT /api/v1/addresses/{id}/default
     */
    public function setDefault(Request $request, int $id): JsonResponse
    {
        $address = $request->user()->addresses()->findOrFail($id);

        // Unset all defaults for this user, then set the chosen one
        $request->user()->addresses()->update(['is_default' => false]);
        $address->update(['is_default' => true]);

        return $this->success($address->fresh(), 'Default address updated');
    }
}
