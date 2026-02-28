import 'package:flutter/foundation.dart';

/// Top-level handler for background messages.
/// No-op until Firebase is configured.
Future<void> firebaseMessagingBackgroundHandler(dynamic message) async {
  debugPrint('FCM Background: message received');
}

/// Handles foreground and tap-based notification events.
/// No-op until Firebase is configured.
class FcmNotificationHandler {
  final void Function(String? orderNumber) onNotificationTap;
  final void Function(dynamic message)? onForegroundMessage;

  FcmNotificationHandler({
    required this.onNotificationTap,
    this.onForegroundMessage,
  });

  /// Set up all FCM message listeners.
  /// No-op until Firebase is configured.
  void initialize() {
    // TODO: Uncomment when Firebase is configured
    // FirebaseMessaging.onMessage.listen(...)
    // FirebaseMessaging.onMessageOpenedApp.listen(...)
    debugPrint('FCM Handler: Skipped — Firebase not configured yet');
  }
}
