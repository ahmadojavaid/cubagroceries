<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProfileController extends Controller
{
    use ApiResponse;

    /**
     * GET /api/v1/profile
     */
    public function show(Request $request): JsonResponse
    {
        return $this->success($request->user());
    }

    /**
     * PUT /api/v1/profile
     */
    public function update(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'firstname' => 'required|string|max:255',
            'lastname' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,' . $request->user()->id,
            'date_of_birth' => 'nullable|date',
        ]);

        $request->user()->update($validated);

        return $this->success($request->user()->fresh(), 'Profile updated successfully');
    }
}
