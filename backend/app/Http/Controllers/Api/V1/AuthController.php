<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    use ApiResponse;

    public function register(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'identity' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'firstname' => 'required|string|max:255',
            'lastname' => 'required|string|max:255',
            'password' => 'required|string|min:8|confirmed',
            'date_of_birth' => 'nullable|date',
        ]);

        $validated['role'] = 'customer';
        $user = User::create($validated);

        $token = $user->createToken('mobile-app')->plainTextToken;

        return $this->success([
            'user' => $user,
            'token' => $token,
        ], 'Registration successful', 201);
    }

    public function login(Request $request): JsonResponse
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        $token = $user->createToken('mobile-app')->plainTextToken;

        return $this->success([
            'user' => $user,
            'token' => $token,
        ], 'Login successful');
    }

    /**
     * Google Sign-In: verify Google ID token, find or create user, return Sanctum token.
     */
    public function google(Request $request): JsonResponse
    {
        $request->validate([
            'id_token' => 'required|string',
        ]);

        // Verify the ID token with Google
        $response = Http::get('https://oauth2.googleapis.com/tokeninfo', [
            'id_token' => $request->id_token,
        ]);

        if ($response->failed()) {
            return $this->error('Invalid Google token.', 401);
        }

        $payload = $response->json();
        $email = $payload['email'] ?? null;
        $name = $payload['name'] ?? '';

        if (!$email) {
            return $this->error('Could not retrieve email from Google.', 422);
        }

        // Find existing user or create new one
        $user = User::where('email', $email)->first();

        if (!$user) {
            $nameParts = explode(' ', $name, 2);
            $user = User::create([
                'email' => $email,
                'firstname' => $nameParts[0] ?? 'User',
                'lastname' => $nameParts[1] ?? '',
                'identity' => '',
                'password' => Hash::make(Str::random(32)),
                'role' => 'customer',
            ]);
        }

        $token = $user->createToken('mobile-app')->plainTextToken;

        return $this->success([
            'user' => $user,
            'token' => $token,
        ], 'Google sign-in successful');
    }

    /**
     * Firebase Phone OTP: verify Firebase ID token from phone auth, find or create user.
     */
    public function phoneVerify(Request $request): JsonResponse
    {
        $request->validate([
            'id_token' => 'required|string',
            'phone' => 'required|string',
        ]);

        // Verify the Firebase ID token via Identity Toolkit
        $tokenResponse = Http::post('https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=' . config('services.firebase.api_key'), [
            'idToken' => $request->id_token,
        ]);

        if ($tokenResponse->failed()) {
            return $this->error('Invalid phone verification token.', 401);
        }

        $users = $tokenResponse->json('users', []);
        if (empty($users)) {
            return $this->error('Could not verify phone number.', 422);
        }

        $firebaseUser = $users[0];
        $phoneNumber = $firebaseUser['phoneNumber'] ?? $request->phone;

        // Normalize phone: remove +92 prefix, ensure 0 prefix
        $normalizedPhone = $phoneNumber;
        if (str_starts_with($normalizedPhone, '+92')) {
            $normalizedPhone = '0' . substr($normalizedPhone, 3);
        } elseif (str_starts_with($normalizedPhone, '92')) {
            $normalizedPhone = '0' . substr($normalizedPhone, 2);
        }

        // Find existing user by phone (identity field) or create new one
        $user = User::where('identity', $normalizedPhone)->first();

        if (!$user) {
            $user = User::create([
                'identity' => $normalizedPhone,
                'email' => null,
                'firstname' => 'User',
                'lastname' => '',
                'password' => Hash::make(Str::random(32)),
                'role' => 'customer',
            ]);
        }

        $token = $user->createToken('mobile-app')->plainTextToken;

        return $this->success([
            'user' => $user,
            'token' => $token,
        ], 'Phone verification successful');
    }

    public function logout(Request $request): JsonResponse
    {
        $request->user()->update(['fcm_token' => null]);
        $request->user()->currentAccessToken()->delete();

        return $this->success(message: 'Logged out successfully');
    }

    public function user(Request $request): JsonResponse
    {
        return $this->success($request->user());
    }
}
