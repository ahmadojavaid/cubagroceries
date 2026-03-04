import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../api/api_client.dart';

/// Manages FCM token retrieval, registration with backend, and refresh handling.
class FcmService {
  final ApiClient _api;
  static String? _currentToken;

  FcmService(this._api);

  /// Initialize FCM: request permission, get token, send to backend.
  Future<void> initialize() async {
    try {
      final messaging = FirebaseMessaging.instance;

      // Request permission (iOS requires this, Android auto-grants)
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        debugPrint('FCM: User denied notification permissions');
        return;
      }

      // Get the current token
      final token = await messaging.getToken();
      if (token != null) {
        await _sendTokenToBackend(token);
      }

      // Listen for token refreshes (happens when app reinstalled, token invalidated, etc.)
      messaging.onTokenRefresh.listen((newToken) {
        _sendTokenToBackend(newToken);
      });

      debugPrint('FCM: Initialized successfully');
    } catch (e) {
      debugPrint('FCM: Init error: $e');
    }
  }

  /// Send the FCM token to backend. Skips if same token already sent.
  Future<void> _sendTokenToBackend(String token) async {
    if (token == _currentToken) return;

    try {
      await _api.post('/device-token', data: {'token': token});
      _currentToken = token;
      debugPrint('FCM: Token registered with backend');
    } catch (e) {
      debugPrint('FCM: Failed to send token to backend: $e');
    }
  }

  /// Clear cached token (call on logout).
  static void clearToken() {
    _currentToken = null;
  }
}
