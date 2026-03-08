import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/config/app_config.dart';
import 'core/router/app_router.dart';
import 'core/services/fcm_notification_handler.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Accept self-signed certificates (Herd .test domains)
  HttpOverrides.global = _DevHttpOverrides();

  try {
    await Hive.initFlutter();
  } catch (e) {
    debugPrint('Hive init failed: $e');
  }

  // Initialize Firebase
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    debugPrint('Firebase: Initialized');
  } catch (e) {
    debugPrint('Firebase init failed: $e');
  }

  // Initialize Sentry / GlitchTip
  await SentryFlutter.init(
    (options) {
      options.dsn = AppConfig.glitchtipDsn;
      options.environment = AppConfig.environment;
      options.tracesSampleRate = 0.3;
      options.sendDefaultPii = false;
    },
    appRunner: () {
      runApp(
        const ProviderScope(
          child: AsifGroceriesApp(),
        ),
      );
    },
  );
}

/// Accept self-signed certificates in development
class _DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

/// Global navigator key for showing dialogs from FCM handler
final navigatorKey = GlobalKey<NavigatorState>();

class AsifGroceriesApp extends ConsumerWidget {
  const AsifGroceriesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Asif Groceries',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
