<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

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

    /**
     * PUT /api/v1/profile/password
     */
    public function password(Request $request): JsonResponse
    {
        $request->validate([
            'current_password' => 'required|string',
            'password' => 'required|string|min:8|confirmed',
        ]);

        if (!Hash::check($request->current_password, $request->user()->password)) {
            throw ValidationException::withMessages([
                'current_password' => ['The current password is incorrect.'],
            ]);
        }

        $request->user()->update([
            'password' => $request->password,
        ]);

        return $this->success(message: 'Password changed successfully');
    }
}
