import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../cart/screens/cart_screen.dart';
import '../../categories/screens/categories_tab_screen.dart';
import '../../notifications/providers/notification_provider.dart';
import '../../notifications/screens/notification_inbox_screen.dart';
import '../../orders/screens/order_history_screen.dart';
import '../../profile/screens/profile_screen.dart';
import 'home_screen.dart';

class NavigationShell extends ConsumerStatefulWidget {
  const NavigationShell({super.key});

  @override
  ConsumerState<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends ConsumerState<NavigationShell> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    CategoriesTabScreen(),
    CartScreen(),
    OrderHistoryScreen(),
    NotificationInboxScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Fetch notifications on app start to populate unread count
    Future.microtask(
      () => ref
          .read(notificationListProvider.notifier)
          .fetchNotifications(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.divider, width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined),
                activeIcon: Icon(Icons.grid_view_rounded),
                label: 'Categories'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                activeIcon: Icon(Icons.shopping_bag_rounded),
                label: 'Cart'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined),
                activeIcon: Icon(Icons.receipt_long_rounded),
                label: 'Orders'),
            BottomNavigationBarItem(
                icon: _buildNotificationIcon(false, unreadCount),
                activeIcon: _buildNotificationIcon(true, unreadCount),
                label: 'Alerts'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(bool active, int unreadCount) {
    final icon = active
        ? const Icon(Icons.notifications_rounded)
        : const Icon(Icons.notifications_outlined);

    if (unreadCount == 0) return icon;

    return Badge(
      label: Text(
        unreadCount > 99 ? '99+' : '$unreadCount',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.error,
      child: icon,
    );
  }
}
