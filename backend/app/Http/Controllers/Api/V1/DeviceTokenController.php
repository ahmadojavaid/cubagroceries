<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class DeviceTokenController extends Controller
{
    /**
     * Save or update the FCM device token for the authenticated user.
     */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'token' => 'required|string|max:500',
        ]);

        $request->user()->update([
            'fcm_token' => $request->input('token'),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Device token saved.',
        ]);
    }
}
