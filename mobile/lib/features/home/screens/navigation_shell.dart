import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/offline_banner.dart';
import '../../cart/screens/cart_screen.dart';
import '../../cart/providers/cart_provider.dart';
import '../../categories/screens/categories_tab_screen.dart';
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

  List<Widget> get _screens => const [
        HomeScreen(),
        CategoriesTabScreen(),
        CartScreen(),
        OrderHistoryScreen(),
        ProfileScreen(),
      ];

  void _onTap(int index) {
    if (index == _currentIndex) return;
    HapticFeedback.lightImpact();
    setState(() => _currentIndex = index);
  }

  DateTime? _lastBackPress;

  @override
  Widget build(BuildContext context) {
    final cartItemCount = ref.watch(cartProvider).items.length;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        // If not on Home tab, go back to Home first
        if (_currentIndex != 0) {
          setState(() => _currentIndex = 0);
          return;
        }

        // On Home tab: double-back to exit
        final now = DateTime.now();
        if (_lastBackPress != null &&
            now.difference(_lastBackPress!) < const Duration(seconds: 2)) {
          // Second press within 2s — exit the app
          SystemNavigator.pop();
          return;
        }

        _lastBackPress = now;
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
      },
      child: Scaffold(
        body: Column(
          children: [
            const OfflineBanner(),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: _screens,
              ),
            ),
          ],
        ),
        bottomNavigationBar: _ModernNavBar(
          currentIndex: _currentIndex,
          cartCount: cartItemCount,
          onTap: _onTap,
        ),
      ),
    );
  }
}

// ─── Modern Nav Bar ─────────────────────────────────────────

class _ModernNavBar extends StatelessWidget {
  final int currentIndex;
  final int cartCount;
  final ValueChanged<int> onTap;

  const _ModernNavBar({
    required this.currentIndex,
    required this.cartCount,
    required this.onTap,
  });

  static const _items = [
    _NavItemData(Icons.home_outlined, Icons.home_rounded, 'Home'),
    _NavItemData(Icons.grid_view_outlined, Icons.grid_view_rounded, 'Categories'),
    _NavItemData(Icons.shopping_bag_outlined, Icons.shopping_bag_rounded, 'Cart'),
    _NavItemData(Icons.receipt_long_outlined, Icons.receipt_long_rounded, 'Orders'),
    _NavItemData(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.only(bottom: bottomPadding > 0 ? bottomPadding : 8),
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: List.generate(_items.length, (i) {
            final isCart = i == 2;
            return Expanded(
              child: _NavBarItem(
                data: _items[i],
                isSelected: currentIndex == i,
                badge: isCart ? cartCount : 0,
                onTap: () => onTap(i),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItemData(this.icon, this.activeIcon, this.label);
}

class _NavBarItem extends StatelessWidget {
  final _NavItemData data;
  final bool isSelected;
  final int badge;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.data,
    required this.isSelected,
    this.badge = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon container with animated background pill
          AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.symmetric(
              horizontal: isSelected ? 20 : 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(24),
            ),
            child: _buildIcon(),
          ),
          const SizedBox(height: 4),
          // Label
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              color: isSelected ? AppColors.primary : AppColors.textHint,
              letterSpacing: isSelected ? 0.1 : 0,
            ),
            child: Text(data.label),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    final icon = Icon(
      isSelected ? data.activeIcon : data.icon,
      size: 23,
      color: isSelected ? AppColors.primary : AppColors.textHint,
    );

    if (badge > 0) {
      return Badge(
        label: Text(
          badge > 99 ? '99+' : '$badge',
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        offset: const Offset(10, -6),
        child: icon,
      );
    }

    return icon;
  }
}
