import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';

/// Top-level handler for background messages.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM Background: ${message.messageId}');
}

/// Handles foreground and tap-based notification events.
class FcmNotificationHandler {
  final GlobalKey<NavigatorState> navigatorKey;
  final void Function(String? orderNumber) onNotificationTap;

  /// Platform channel for playing native alert sounds
  static const _channel = MethodChannel('com.asifgroceries.app/alert');

  FcmNotificationHandler({
    required this.navigatorKey,
    required this.onNotificationTap,
  });

  /// Set up all FCM message listeners.
  void initialize() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // User tapped notification while app was in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Check if app was opened from a terminated state via notification
    _checkInitialMessage();

    debugPrint('FCM Handler: Initialized');
  }

  Future<void> _checkInitialMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    final orderNumber = message.data['order_number'] as String?;
    onNotificationTap(orderNumber);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('FCM Foreground: ${message.data}');

    final type = message.data['type'] as String?;

    if (type == 'rider_job_assigned') {
      await _showRiderJobAlert(message);
    } else {
      // Show a subtle snackbar for other notifications
      _showNotificationSnackbar(message);
    }
  }

  /// Play alert sound via native platform channel and show a prominent dialog.
  Future<void> _showRiderJobAlert(RemoteMessage message) async {
    // Play alert sound via platform channel
    try {
      await _channel.invokeMethod('playAlert');
    } catch (e) {
      debugPrint('FCM: Could not play alert sound: $e');
    }

    final context = navigatorKey.currentContext;
    if (context == null) return;

    final title = message.notification?.title ?? 'New Delivery Job!';
    final body = message.notification?.body ?? '';
    final orderNumber = message.data['order_number'] as String?;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delivery_dining,
                color: AppColors.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              body,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            if (orderNumber != null) ...[
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.receipt_long,
                        size: 16, color: AppColors.textHint),
                    const SizedBox(width: 8),
                    Text(
                      '#$orderNumber',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _stopAlert();
              Navigator.pop(ctx);
            },
            child: const Text('Dismiss'),
          ),
          ElevatedButton(
            onPressed: () {
              _stopAlert();
              Navigator.pop(ctx);
              if (orderNumber != null) {
                onNotificationTap(orderNumber);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text('View Order'),
          ),
        ],
      ),
    );
  }

  Future<void> _stopAlert() async {
    try {
      await _channel.invokeMethod('stopAlert');
    } catch (_) {}
  }

  void _showNotificationSnackbar(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final title = message.notification?.title ?? '';
    final body = message.notification?.body ?? '';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            if (body.isNotEmpty)
              Text(body, style: const TextStyle(fontSize: 13)),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: message.data['order_number'] != null
            ? SnackBarAction(
                label: 'View',
                onPressed: () => onNotificationTap(
                    message.data['order_number'] as String?),
              )
            : null,
      ),
    );
  }
}
