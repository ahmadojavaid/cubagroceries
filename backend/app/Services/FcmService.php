<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class FcmService
{
    /**
     * Send a push notification to a single device via FCM v1 HTTP API.
     *
     * Requires FIREBASE_PROJECT_ID and FIREBASE_SERVER_KEY in .env.
     * For production, use a service account with OAuth2. For now, uses legacy server key.
     */
    public static function sendToDevice(string $fcmToken, string $title, string $body, array $data = []): bool
    {
        $serverKey = config('services.firebase.server_key');

        if (! $serverKey || ! $fcmToken) {
            return false;
        }

        try {
            $response = Http::withHeaders([
                'Authorization' => "key={$serverKey}",
                'Content-Type' => 'application/json',
            ])->post('https://fcm.googleapis.com/fcm/send', [
                'to' => $fcmToken,
                'notification' => [
                    'title' => $title,
                    'body' => $body,
                    'sound' => 'default',
                ],
                'data' => $data,
            ]);

            return $response->successful();
        } catch (\Throwable $e) {
            Log::warning('FCM send failed: ' . $e->getMessage());
            return false;
        }
    }
}
