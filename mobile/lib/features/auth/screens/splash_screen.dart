import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../providers/auth_provider.dart';
import '../../../core/theme/app_colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoScale;
  late Animation<double> _logoFade;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeOut)),
    );

    _logoController.forward();
    _initialize();
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    bool isLoggedIn = false;
    try {
      await ref
          .read(authProvider.notifier)
          .checkAuth()
          .timeout(const Duration(seconds: 5));
      isLoggedIn = ref.read(authProvider).isAuthenticated;
    } catch (_) {}

    if (!mounted) return;
    if (isLoggedIn) {
      final isRider = ref.read(authProvider).isRider;
      context.go(isRider ? '/rider-home' : '/home');
    } else {
      final box = await Hive.openBox('app_prefs');
      final hasSeenOnboarding =
          box.get('hasSeenOnboarding', defaultValue: false);
      if (!mounted) return;
      if (hasSeenOnboarding) {
        // Guest browsing — go straight to home (Apple Guideline 5.1.1(v))
        context.go('/home');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Full logo — no container clipping, just the image
            FadeTransition(
              opacity: _logoFade,
              child: ScaleTransition(
                scale: _logoScale,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Image.asset(
                    'assets/images/ag-logo.png',
                    width: 440,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.storefront_rounded,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Loading spinner
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white.withValues(alpha: 0.5),
                strokeWidth: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
