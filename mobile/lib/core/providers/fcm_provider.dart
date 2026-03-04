import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    onNotificationTap: (orderNumber) {
      if (orderNumber == null) return;
      final context = navigatorKey.currentContext;
      if (context == null) return;
      // Navigate to order detail — works for both customer and rider
      GoRouter.of(context).push('/orders/$orderNumber');
    },
  );
  return handler;
});
