import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/onboarding_screen.dart';
import '../../features/categories/screens/category_listing_screen.dart';
import '../../features/home/screens/navigation_shell.dart';
import '../../features/products/screens/product_detail_screen.dart';
import '../../features/products/screens/product_listing_screen.dart';
import '../../features/products/screens/search_screen.dart';
import '../../features/profile/data/address_model.dart';
import '../../features/profile/screens/address_form_screen.dart';
import '../../features/profile/screens/address_list_screen.dart';
import '../../features/profile/screens/settings_screen.dart';

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

      // Category products
      GoRoute(
        path: '/categories/:id/products',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final extra = state.extra as Map<String, dynamic>?;
          final subCategoryId = extra?['sub_category_id'] as int?;
          return ProductListingScreen(
            categoryId: id,
            subCategoryId: subCategoryId,
          );
        },
      ),

      // Product detail
      GoRoute(
        path: '/products/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ProductDetailScreen(productId: id);
        },
      ),

      // Search
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),

      // Addresses
      GoRoute(
        path: '/addresses',
        builder: (context, state) => const AddressListScreen(),
      ),
      GoRoute(
        path: '/addresses/add',
        builder: (context, state) => const AddressFormScreen(),
      ),
      GoRoute(
        path: '/addresses/:id/edit',
        builder: (context, state) {
          final address = state.extra as AddressModel?;
          return AddressFormScreen(address: address);
        },
      ),

      // Settings
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
  );
});


