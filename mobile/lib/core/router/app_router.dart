import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/categories/screens/category_listing_screen.dart';
import '../../features/home/screens/navigation_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const NavigationShell(),
      ),

      // Category listing (sub-categories)
      GoRoute(
        path: '/categories/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return CategoryListingScreen(categoryId: id);
        },
      ),

      // Category products — placeholder until MP-M5
      GoRoute(
        path: '/categories/:id/products',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final extra = state.extra as Map<String, dynamic>?;
          final subCategoryId = extra?['sub_category_id'] as int?;
          return _ProductsPlaceholder(
            categoryId: id,
            subCategoryId: subCategoryId,
          );
        },
      ),

      // Search — placeholder until MP-M7
      GoRoute(
        path: '/search',
        builder: (context, state) => const _SearchPlaceholder(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
  );
});

/// Temporary placeholder for product listing screen
class _ProductsPlaceholder extends StatelessWidget {
  final int categoryId;
  final int? subCategoryId;

  const _ProductsPlaceholder({
    required this.categoryId,
    this.subCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Center(
        child: Text(
          'Product listing for category $categoryId'
          '${subCategoryId != null ? '\nSub-category: $subCategoryId' : ''}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Temporary placeholder for search screen
class _SearchPlaceholder extends StatelessWidget {
  const _SearchPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: const Center(child: Text('Search coming soon')),
    );
  }
}
