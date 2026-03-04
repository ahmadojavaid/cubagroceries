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
import '../../features/products/screens/product_reviews_screen.dart';
import '../../features/products/screens/search_screen.dart';
import '../../features/orders/screens/checkout_screen.dart';
import '../../features/orders/screens/order_detail_screen.dart';
import '../../features/profile/data/address_model.dart';
import '../../features/profile/screens/address_form_screen.dart';
import '../../features/profile/screens/address_list_screen.dart';
import '../../features/profile/screens/settings_screen.dart';
import '../../features/cart/screens/cart_screen.dart';
import '../../features/complaints/screens/complaint_detail_screen.dart';
import '../../features/complaints/screens/complaint_form_screen.dart';
import '../../features/complaints/screens/complaints_history_screen.dart';
import '../../features/complaints/data/complaint_model.dart';
import '../../features/notifications/screens/notification_inbox_screen.dart';
import '../../features/surveys/screens/survey_screen.dart';
import '../../features/settings/screens/faq_screen.dart';
import '../../features/settings/screens/store_hours_screen.dart';
import '../../features/settings/screens/legal_page_screen.dart';
import '../../features/rider/screens/rider_navigation_shell.dart';
import '../../features/rider/screens/rider_order_detail_screen.dart';
import '../../main.dart' show navigatorKey;

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
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

      // Rider shell
      GoRoute(
        path: '/rider-home',
        builder: (context, state) => const RiderNavigationShell(),
      ),

      // Rider order detail
      GoRoute(
        path: '/rider/orders/:orderNumber',
        builder: (context, state) {
          final orderNumber = state.pathParameters['orderNumber']!;
          return RiderOrderDetailScreen(orderNumber: orderNumber);
        },
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
        routes: [
          GoRoute(
            path: 'reviews',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              final extra = state.extra as Map<String, dynamic>?;
              final name = extra?['product_name'] as String? ?? 'Reviews';
              return ProductReviewsScreen(
                productId: id,
                productName: name,
              );
            },
          ),
        ],
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

      // Cart (standalone, accessible from product detail etc.)
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),

      // Checkout
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),

      // Order detail
      GoRoute(
        path: '/orders/:orderNumber',
        builder: (context, state) {
          final orderNumber = state.pathParameters['orderNumber']!;
          return OrderDetailScreen(orderNumber: orderNumber);
        },
      ),

      // Settings
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Surveys
      GoRoute(
        path: '/surveys/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return SurveyScreen(surveyId: id);
        },
      ),

      // Notifications
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationInboxScreen(),
      ),

      // FAQs
      GoRoute(
        path: '/faqs',
        builder: (context, state) => const FaqScreen(),
      ),

      // Store hours
      GoRoute(
        path: '/store-hours',
        builder: (context, state) => const StoreHoursScreen(),
      ),

      // Legal pages
      GoRoute(
        path: '/about',
        builder: (context, state) => const LegalPageScreen(
          title: 'About Us',
          settingsKey: 'about_us',
        ),
      ),
      GoRoute(
        path: '/terms',
        builder: (context, state) => const LegalPageScreen(
          title: 'Terms & Conditions',
          settingsKey: 'terms_and_conditions',
        ),
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) => const LegalPageScreen(
          title: 'Privacy Policy',
          settingsKey: 'privacy_policy',
        ),
      ),

      // Complaints
      GoRoute(
        path: '/complaints',
        builder: (context, state) => const ComplaintsHistoryScreen(),
        routes: [
          GoRoute(
            path: 'detail',
            builder: (context, state) {
              final complaint = state.extra as ComplaintModel;
              return ComplaintDetailScreen(complaint: complaint);
            },
          ),
          GoRoute(
            path: 'new',
            builder: (context, state) {
              final orderIdStr = state.uri.queryParameters['orderId'];
              final orderId =
                  orderIdStr != null ? int.tryParse(orderIdStr) : null;
              return ComplaintFormScreen(orderId: orderId);
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.matchedLocation}'),
      ),
    ),
  );
});


