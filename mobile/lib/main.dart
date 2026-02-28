import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/router/app_router.dart';
import 'core/services/fcm_notification_handler.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
    const ProviderScope(
      child: CubaGroceriesApp(),
    ),
  );
}

class CubaGroceriesApp extends ConsumerStatefulWidget {
  const CubaGroceriesApp({super.key});

  @override
  ConsumerState<CubaGroceriesApp> createState() => _CubaGroceriesAppState();
}

class _CubaGroceriesAppState extends ConsumerState<CubaGroceriesApp> {
  @override
  void initState() {
    super.initState();
    _setupFcmHandler();
  }

  void _setupFcmHandler() {
    final handler = FcmNotificationHandler(
      onNotificationTap: (orderNumber) {
        if (orderNumber != null) {
          // Navigate to order detail when notification is tapped
          final router = ref.read(routerProvider);
          router.push('/orders/$orderNumber');
        }
      },
      onForegroundMessage: (message) {
        // Show an in-app SnackBar for foreground notifications
        final title = message.notification?.title ?? 'Notification';
        final body = message.notification?.body ?? '';
        final context = ref.read(routerProvider).routerDelegate
            .navigatorKey.currentContext;
        if (context != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  if (body.isNotEmpty)
                    Text(body, style: const TextStyle(fontSize: 12)),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
              action: message.data['order_number'] != null
                  ? SnackBarAction(
                      label: 'View',
                      onPressed: () {
                        ref.read(routerProvider).push(
                            '/orders/${message.data['order_number']}');
                      },
                    )
                  : null,
            ),
          );
        }
      },
    );
    handler.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Cuba Groceries',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
