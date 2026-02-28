import 'package:flutter/foundation.dart';
import '../api/api_client.dart';

/// Handles Firebase Cloud Messaging initialization, permissions, and token management.
/// Currently a no-op until Firebase is configured (google-services.json added).
class FcmService {
  final ApiClient _api;

  FcmService(this._api);

  /// Initialize FCM: request permission, get token, send to backend.
  /// No-op until Firebase is configured.
  Future<void> initialize() async {
    // TODO: Uncomment when Firebase is configured
    // final settings = await FirebaseMessaging.instance.requestPermission(...);
    // final token = await FirebaseMessaging.instance.getToken();
    // if (token != null) await _sendTokenToBackend(token);
    // FirebaseMessaging.instance.onTokenRefresh.listen(_sendTokenToBackend);
    debugPrint('FCM: Skipped — Firebase not configured yet');
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
