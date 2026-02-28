import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Top-level handler for background messages (must be a top-level function).
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM Background: ${message.notification?.title}');
  // No-op: the system tray will show the notification automatically.
  // Navigation on tap is handled by onMessageOpenedApp in FcmNotificationHandler.
}

/// Handles foreground and tap-based notification events.
class FcmNotificationHandler {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Callback invoked when a notification is tapped (from background or terminated).
  /// Receives the order number (or null) to navigate to.
  final void Function(String? orderNumber) onNotificationTap;

  /// Optional callback for foreground notifications (e.g. show in-app banner).
  final void Function(RemoteMessage message)? onForegroundMessage;

  FcmNotificationHandler({
    required this.onNotificationTap,
    this.onForegroundMessage,
  });

  /// Set up all FCM message listeners.
  void initialize() {
    // 1. Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('FCM Foreground: ${message.notification?.title}');
      onForegroundMessage?.call(message);
    });

    // 2. Notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // 3. Check if app was opened from a terminated state via notification
    _checkInitialMessage();
  }

  Future<void> _checkInitialMessage() async {
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    final data = message.data;
    final orderNumber = data['order_number'] as String?;
    onNotificationTap(orderNumber);
  }
}
