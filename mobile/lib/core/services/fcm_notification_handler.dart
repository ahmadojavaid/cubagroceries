// ignore_for_file: use_build_context_synchronously
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../features/orders/widgets/order_review_popup.dart';
import '../theme/app_colors.dart';

/// Top-level handler for background messages.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM Background: ${message.messageId}');
}

/// Handles foreground and tap-based notification events.
class FcmNotificationHandler {
  final GlobalKey<NavigatorState> navigatorKey;
  final void Function(String? orderNumber) onNotificationTap;

  /// Called when any order/complaint status change notification arrives in foreground.
  /// Use this to refresh order lists, badge counts, etc.
  final VoidCallback? onDataChanged;

  static const _channel = MethodChannel('com.asifgroceries.app/alert');

  FcmNotificationHandler({
    required this.navigatorKey,
    required this.onNotificationTap,
    this.onDataChanged,
  });

  void initialize() {
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);
    _checkInitialMessage();
    debugPrint('FCM Handler: Initialized');
  }

  Future<void> _checkInitialMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  // ── Notification tap (background/terminated) ──────────────

  void _handleNotificationTap(RemoteMessage message) {
    final type = message.data['type'] as String?;

    if (type == 'complaint_status_changed') {
      // Navigate to complaints list
      final context = navigatorKey.currentContext;
      if (context != null) {
        GoRouter.of(context).push('/complaints');
      }
      return;
    }

    final orderNumber = message.data['order_number'] as String?;
    // Navigate to the order detail — the screen itself will
    // show the review popup for delivered orders.
    onNotificationTap(orderNumber);
  }

  // ── Foreground messages ───────────────────────────────────

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('FCM Foreground: ${message.data}');

    final type = message.data['type'] as String?;

    // Trigger data refresh for status-change notifications
    if (type == 'order_status_changed' ||
        type == 'complaint_status_changed' ||
        type == 'rider_job_assigned') {
      onDataChanged?.call();
    }

    if (type == 'rider_job_assigned') {
      await _showRiderJobAlert(message);
    } else if (type == 'order_status_changed' &&
        message.data['new_status'] == 'delivered') {
      _showDeliveredDialog(message);
    } else if (type == 'complaint_status_changed') {
      _showComplaintSnackbar(message);
    } else {
      _showNotificationSnackbar(message);
    }
  }

  // ── Delivered: confirmation → review ──────────────────────

  void _showDeliveredDialog(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final title = message.notification?.title ?? '📦 Order Delivered';
    final body = message.notification?.body ?? '';
    final orderNumber = message.data['order_number'] as String?;
    final orderIdStr = message.data['order_id'] as String?;
    final orderId = orderIdStr != null ? int.tryParse(orderIdStr) : null;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: AppColors.success, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(body,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textSecondary, height: 1.4)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.warning.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.star_rounded, size: 20, color: AppColors.warning),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('Would you like to rate your experience?',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary)),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              if (orderId != null && orderNumber != null) {
                _showReviewPopup(orderNumber, orderId);
              }
            },
            icon: const Icon(Icons.star_rounded, size: 18),
            label: const Text('Rate Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  void _showReviewPopup(String orderNumber, int orderId) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => OrderReviewPopup(
        orderId: orderId,
        orderNumber: orderNumber,
        onSubmitted: () => onNotificationTap(orderNumber),
      ),
    );
  }

  // ── Rider job alert ───────────────────────────────────────

  Future<void> _showRiderJobAlert(RemoteMessage message) async {
    try {
      await _channel.invokeMethod('playAlert');
    } catch (e) {
      debugPrint('FCM: Could not play native alert sound: $e');
      // Fallback: system sound
      try {
        await SystemSound.play(SystemSoundType.alert);
        await HapticFeedback.vibrate();
      } catch (_) {}
    }

    // Re-fetch context after async gap
    final ctx = navigatorKey.currentContext;
    if (ctx == null) return;

    final title = message.notification?.title ?? 'New Delivery Job!';
    final body = message.notification?.body ?? '';
    final orderNumber = message.data['order_number'] as String?;

    showDialog(
      context: ctx,
      barrierDismissible: false,
      builder: (dlgCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.delivery_dining,
                  color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(body,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textSecondary, height: 1.4)),
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
                    Text('#$orderNumber',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
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
              Navigator.pop(dlgCtx);
            },
            child: const Text('Dismiss'),
          ),
          ElevatedButton(
            onPressed: () {
              _stopAlert();
              Navigator.pop(dlgCtx);
              if (orderNumber != null) onNotificationTap(orderNumber);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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

  // ── Complaint notification ─────────────────────────────────

  void _showComplaintSnackbar(RemoteMessage message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final title = message.notification?.title ?? '📋 Complaint Updated';
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
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            final nav = navigatorKey.currentContext;
            if (nav != null) {
              GoRouter.of(nav).push('/complaints');
            }
          },
        ),
      ),
    );
  }

  // ── Generic snackbar ──────────────────────────────────────

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
                onPressed: () =>
                    onNotificationTap(message.data['order_number'] as String?),
              )
            : null,
      ),
    );
  }
}
