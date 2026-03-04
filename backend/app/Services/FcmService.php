<?php

namespace App\Services;

use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class FcmService
{
    /**
     * Send a push notification via Firebase Cloud Messaging V1 API.
     *
     * Uses service account credentials with OAuth2 for authentication.
     */
    public static function sendToDevice(string $fcmToken, string $title, string $body, array $data = [], ?string $channelId = null): bool
    {
        $projectId = config('services.firebase.project_id');
        $credentialsPath = config('services.firebase.credentials_path');

        if (! $projectId || ! $fcmToken) {
            return false;
        }

        try {
            $accessToken = self::getAccessToken($credentialsPath);

            if (! $accessToken) {
                Log::warning('FCM: Failed to obtain access token');
                return false;
            }

            $message = [
                'message' => [
                    'token' => $fcmToken,
                    'notification' => [
                        'title' => $title,
                        'body' => $body,
                    ],
                    'data' => collect($data)->map(fn ($v) => (string) $v)->toArray(),
                    'android' => [
                        'priority' => 'high',
                        'notification' => [
                            'sound' => 'default',
                            'channel_id' => $channelId ?? 'default',
                        ],
                    ],
                ],
            ];

            $url = "https://fcm.googleapis.com/v1/projects/{$projectId}/messages:send";

            $response = Http::withHeaders([
                'Authorization' => "Bearer {$accessToken}",
                'Content-Type' => 'application/json',
            ])->post($url, $message);

            if ($response->successful()) {
                return true;
            }

            Log::warning('FCM send failed', [
                'status' => $response->status(),
                'body' => $response->body(),
            ]);

            return false;
        } catch (\Throwable $e) {
            Log::warning('FCM send exception: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Get an OAuth2 access token for the FCM V1 API.
     * Cached for 55 minutes (tokens last 60 min).
     */
    private static function getAccessToken(?string $credentialsPath): ?string
    {
        return Cache::remember('fcm_access_token', 3300, function () use ($credentialsPath) {
            $fullPath = base_path($credentialsPath);

            if (! file_exists($fullPath)) {
                Log::warning("FCM: Service account file not found at {$fullPath}");
                return null;
            }

            $credentials = json_decode(file_get_contents($fullPath), true);

            // Build JWT
            $now = time();
            $header = self::base64UrlEncode(json_encode([
                'alg' => 'RS256',
                'typ' => 'JWT',
            ]));

            $payload = self::base64UrlEncode(json_encode([
                'iss' => $credentials['client_email'],
                'scope' => 'https://www.googleapis.com/auth/firebase.messaging',
                'aud' => $credentials['token_uri'],
                'iat' => $now,
                'exp' => $now + 3600,
            ]));

            $signingInput = "{$header}.{$payload}";

            $privateKey = openssl_pkey_get_private($credentials['private_key']);
            openssl_sign($signingInput, $signature, $privateKey, OPENSSL_ALGO_SHA256);

            $jwt = $signingInput . '.' . self::base64UrlEncode($signature);

            // Exchange JWT for access token
            $response = Http::asForm()->post($credentials['token_uri'], [
                'grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer',
                'assertion' => $jwt,
            ]);

            if ($response->successful()) {
                return $response->json('access_token');
            }

            Log::warning('FCM: Token exchange failed', ['body' => $response->body()]);
            return null;
        });
    }

    private static function base64UrlEncode(string $data): string
    {
        return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
    }
}
