import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../api/api_client.dart';

/// Handles Firebase Cloud Messaging initialization, permissions, and token management.
class FcmService {
  final ApiClient _api;

  FcmService(this._api);

  /// Initialize FCM: request permission, get token, send to backend.
  Future<void> initialize() async {
    try {
      // Request notification permission
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        criticalAlert: false,
        provisional: false,
      );

      debugPrint('FCM: Permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        debugPrint('FCM: Permission denied');
        return;
      }

      // Get FCM token
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        debugPrint('FCM: Token obtained');
        await _sendTokenToBackend(token);
      }

      // Listen for token refresh
      FirebaseMessaging.instance.onTokenRefresh.listen(_sendTokenToBackend);
    } catch (e) {
      debugPrint('FCM: Initialization failed: $e');
    }
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
}
