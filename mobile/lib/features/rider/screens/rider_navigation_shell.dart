import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/offline_banner.dart';
import '../../profile/screens/profile_screen.dart';
import 'rider_orders_screen.dart';

class RiderNavigationShell extends ConsumerStatefulWidget {
  const RiderNavigationShell({super.key});

  @override
  ConsumerState<RiderNavigationShell> createState() =>
      _RiderNavigationShellState();
}

class _RiderNavigationShellState extends ConsumerState<RiderNavigationShell> {
  int _currentIndex = 0;

  List<Widget> get _screens => const [
        RiderOrdersScreen(),
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        // If not on Orders tab, go back to Orders first
        if (_currentIndex != 0) {
          setState(() => _currentIndex = 0);
          return;
        }

        // On Orders tab: double-back to exit
        final now = DateTime.now();
        if (_lastBackPress != null &&
            now.difference(_lastBackPress!) < const Duration(seconds: 2)) {
          Navigator.of(context).pop();
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
        bottomNavigationBar: _RiderNavBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
      ),
    );
  }
}

// ─── Rider Nav Bar ──────────────────────────────────────────

class _RiderNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _RiderNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItemData(
        Icons.delivery_dining_outlined, Icons.delivery_dining, 'Orders'),
    _NavItemData(
        Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
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
            return Expanded(
              child: _NavBarItem(
                data: _items[i],
                isSelected: currentIndex == i,
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
  final VoidCallback onTap;

  const _NavBarItem({
    required this.data,
    required this.isSelected,
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
            child: Icon(
              isSelected ? data.activeIcon : data.icon,
              size: 23,
              color: isSelected ? AppColors.primary : AppColors.textHint,
            ),
          ),
          const SizedBox(height: 4),
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
}
