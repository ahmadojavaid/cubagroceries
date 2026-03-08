// ignore_for_file: use_build_context_synchronously
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../../features/notifications/providers/notification_provider.dart';
import '../../features/orders/providers/order_provider.dart';
import '../../features/rider/providers/rider_orders_provider.dart';
import '../providers/api_provider.dart';
import '../services/fcm_service.dart';
import '../services/fcm_notification_handler.dart';
import '../../main.dart' show navigatorKey;

/// Provider for the FCM service. Call initialize() after user logs in.
final fcmServiceProvider = Provider<FcmService>((ref) {
  final api = ref.watch(apiClientProvider);
  return FcmService(api);
});

/// Provider for the notification handler. Initialized once after login.
final fcmNotificationHandlerProvider = Provider<FcmNotificationHandler>((ref) {
  final handler = FcmNotificationHandler(
    navigatorKey: navigatorKey,
    onNotificationTap: (orderNumber) async {
      if (orderNumber == null) return;
      // Check role from secure storage to avoid circular provider dependency
      final storage = const FlutterSecureStorage();
      final role = await storage.read(key: 'user_role');
      final route = role == 'rider'
          ? '/rider/orders/$orderNumber'
          : '/orders/$orderNumber';
      // Re-check context after async gap
      final ctx = navigatorKey.currentContext;
      if (ctx == null) return;
      GoRouter.of(ctx).push(route);
    },
    onDataChanged: () {
      // Refresh order lists and notification count when a status change arrives
      ref.read(orderListProvider.notifier).fetchOrders(forceRefresh: true);
      ref.read(riderOrdersProvider.notifier).refresh();
      ref.read(notificationListProvider.notifier)
          .fetchNotifications(forceRefresh: true);
      // Bump trigger so order detail screen re-fetches if open
      ref.read(orderRefreshTrigger.notifier).state++;
    },
  );
  return handler;
});
