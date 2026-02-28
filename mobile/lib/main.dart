import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/router/app_router.dart';
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

  // TODO: Initialize Firebase when google-services.json is configured
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Catch all uncaught errors
  FlutterError.onError = (details) {
    debugPrint('FlutterError: ${details.exception}');
    debugPrint('${details.stack}');
  };

  runZonedGuarded(() {
    runApp(
      const ProviderScope(
        child: CubaGroceriesApp(),
      ),
    );
  }, (error, stack) {
    debugPrint('Uncaught error: $error');
    debugPrint('$stack');
  });
}

/// Accept self-signed certificates in development
class _DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

class CubaGroceriesApp extends ConsumerWidget {
  const CubaGroceriesApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Cuba Groceries',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
