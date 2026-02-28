import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../api/api_client.dart';

/// Handles Firebase Cloud Messaging initialization, permissions, and token management.
class FcmService {
  final ApiClient _api;
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  FcmService(this._api);

  /// Initialize FCM: request permission, get token, send to backend.
  Future<void> initialize() async {
    // Request permission (iOS + Android 13+)
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      debugPrint('FCM: User denied notification permission');
      return;
    }

    // Get FCM token and send to backend
    final token = await _messaging.getToken();
    if (token != null) {
      await _sendTokenToBackend(token);
    }

    // Listen for token refreshes
    _messaging.onTokenRefresh.listen(_sendTokenToBackend);
  }

  /// Send the FCM device token to the backend.
  Future<void> _sendTokenToBackend(String token) async {
    try {
      await _api.post('/device-token', data: {'token': token});
      debugPrint('FCM: Token sent to backend');
    } catch (e) {
      debugPrint('FCM: Failed to send token: $e');
    }
  }

  /// Get the current FCM token (useful for debugging).
  Future<String?> getToken() => _messaging.getToken();
}
