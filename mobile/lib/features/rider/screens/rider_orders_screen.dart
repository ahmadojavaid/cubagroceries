import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/providers/store_status_provider.dart';
import '../providers/rider_orders_provider.dart';

class RiderOrdersScreen extends ConsumerStatefulWidget {
  const RiderOrdersScreen({super.key});

  @override
  ConsumerState<RiderOrdersScreen> createState() => _RiderOrdersScreenState();
}

class _RiderOrdersScreenState extends ConsumerState<RiderOrdersScreen>
    with WidgetsBindingObserver {
  String? _activeFilter; // null = All

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(
      () => ref.read(riderOrdersProvider.notifier).fetchOrders(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Refresh when app resumes (e.g. after tapping a push notification)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(riderOrdersProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ordersState = ref.watch(riderOrdersProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: _buildBody(context, ordersState),
    );
  }

  List<RiderOrder> get _filteredOrders {
    final all = ref.read(riderOrdersProvider).orders;
    if (_activeFilter == null) return all;
    return all.where((o) => o.status == _activeFilter).toList();
  }

  Widget _buildBody(BuildContext context, RiderOrdersState state) {
    if (state.isLoading && state.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.orders.isEmpty) {
      return _ErrorState(
        message: state.error!,
        onRetry: () => ref.read(riderOrdersProvider.notifier).fetchOrders(),
      );
    }

    if (state.orders.isEmpty) {
      return _EmptyState(
        onRefresh: () => ref.read(riderOrdersProvider.notifier).refresh(),
      );
    }

    final filtered = _filteredOrders;

    return RefreshIndicator(
      onRefresh: () => ref.read(riderOrdersProvider.notifier).refresh(),
      color: AppColors.primary,
      child: CustomScrollView(
        slivers: [
          // ── Header ──
          SliverToBoxAdapter(
            child: _buildHeader(context),
          ),

          // ── Store Offline Banner ──
          SliverToBoxAdapter(
            child: _StoreOfflineBanner(),
          ),

          // ── Status Dashboard Cards ──
          SliverToBoxAdapter(
            child: _DashboardGrid(orders: state.orders),
          ),

          // ── Filter Chips ──
          SliverToBoxAdapter(
            child: _buildFilterChips(state.orders),
          ),

          // ── Order Count ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppDimens.pagePadding, 4, AppDimens.pagePadding, 8),
              child: Text(
                '${filtered.length} order${filtered.length == 1 ? '' : 's'}',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textHint,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // ── Orders List ──
          if (filtered.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.filter_list_off_rounded,
                        size: 48, color: AppColors.textHint.withOpacity(0.4)),
                    const SizedBox(height: 12),
                    const Text(
                      'No orders with this status',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 14),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.pagePadding,
                0,
                AppDimens.pagePadding,
                AppDimens.xxl,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final order = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _RiderOrderCard(
                        order: order,
                        onTap: () =>
                            context.push('/rider/orders/${order.orderId}'),
                      ),
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: AppDimens.pagePadding,
        right: AppDimens.pagePadding,
        bottom: 4,
      ),
      child: Text(
        'My Deliveries',
        style: GoogleFonts.dmSans(
          fontWeight: FontWeight.w800,
          fontSize: 24,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildFilterChips(List<RiderOrder> allOrders) {
    // Compute counts per status
    final counts = <String?, int>{};
    counts[null] = allOrders.length; // All
    for (final o in allOrders) {
      counts[o.status] = (counts[o.status] ?? 0) + 1;
    }

    // Only show statuses that have orders
    final statuses = <String?>[null]; // "All" first
    for (final s in ['pending', 'confirmed', 'dispatched', 'delivered', 'cancelled']) {
      if (counts.containsKey(s) && counts[s]! > 0) statuses.add(s);
    }

    return Container(
      height: 48,
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.pagePadding),
        itemCount: statuses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final status = statuses[index];
          final isActive = _activeFilter == status;
          final label = status == null
              ? 'All'
              : _statusLabel(status);
          final count = counts[status] ?? 0;

          return GestureDetector(
            onTap: () => setState(() => _activeFilter = status),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.cardBg,
                borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                border: Border.all(
                  color: isActive ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: isActive ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white.withOpacity(0.25)
                          : AppColors.surfaceBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isActive ? Colors.white : AppColors.textHint,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _statusLabel(String status) {
    return switch (status) {
      'pending' => 'Pending',
      'confirmed' => 'Confirmed',
      'dispatched' => 'Dispatched',
      'delivered' => 'Delivered',
      'cancelled' => 'Cancelled',
      _ => status,
    };
  }
}

// ─── Dashboard Grid ─────────────────────────────────────────

class _DashboardGrid extends StatelessWidget {
  final List<RiderOrder> orders;

  const _DashboardGrid({required this.orders});

  @override
  Widget build(BuildContext context) {
    int awaiting = 0, dispatched = 0, delivered = 0, total = orders.length;
    for (final o in orders) {
      switch (o.status) {
        case 'confirmed':
          awaiting++;
          break;
        case 'dispatched':
          dispatched++;
          break;
        case 'delivered':
          delivered++;
          break;
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppDimens.pagePadding, 16, AppDimens.pagePadding, 0),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.pending_actions_rounded,
              label: 'To Pick Up',
              count: awaiting,
              color: const Color(0xFFE65100),
              bgColor: const Color(0xFFFFF3E0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _StatCard(
              icon: Icons.local_shipping_rounded,
              label: 'In Transit',
              count: dispatched,
              color: const Color(0xFF1565C0),
              bgColor: const Color(0xFFE3F2FD),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _StatCard(
              icon: Icons.check_circle_rounded,
              label: 'Delivered',
              count: delivered,
              color: const Color(0xFF2E7D32),
              bgColor: const Color(0xFFE8F5E9),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _StatCard(
              icon: Icons.inventory_2_rounded,
              label: 'Total',
              count: total,
              color: AppColors.primary,
              bgColor: AppColors.primarySurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final Color color;
  final Color bgColor;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.count,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: GoogleFonts.dmSans(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color.withOpacity(0.8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ─── Order Card ─────────────────────────────────────────────

class _RiderOrderCard extends StatelessWidget {
  final RiderOrder order;
  final VoidCallback onTap;

  const _RiderOrderCard({required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: order ID + status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${order.orderId}',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
                _StatusBadge(status: order.status, label: order.statusLabel),
              ],
            ),
            const SizedBox(height: 12),

            // Customer name
            if (order.customer != null)
              _InfoRow(
                icon: Icons.person_outline,
                text: order.customer!.fullName,
              ),

            if (order.address != null) ...[
              const SizedBox(height: 6),
              _InfoRow(
                icon: Icons.location_on_outlined,
                text: order.address!.shortAddress,
              ),
            ],

            // Items count
            if (order.items.isNotEmpty) ...[
              const SizedBox(height: 6),
              _InfoRow(
                icon: Icons.shopping_bag_outlined,
                text: '${order.items.length} item${order.items.length == 1 ? '' : 's'}',
              ),
            ],

            const SizedBox(height: 12),
            Container(height: 0.5, color: AppColors.divider),
            const SizedBox(height: 10),

            // Bottom row: total + date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs ${order.totalAmount}',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  _formatDate(order.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM d, h:mm a').format(date.toLocal());
    } catch (_) {
      return dateStr;
    }
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textHint),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.textSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ─── Status Badge ───────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;
  final String label;

  const _StatusBadge({required this.status, required this.label});

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (status) {
      'pending' => (
          const Color(0xFFFFF3E0),
          const Color(0xFFE65100),
        ),
      'confirmed' => (
          const Color(0xFFE3F2FD),
          const Color(0xFF1565C0),
        ),
      'dispatched' => (
          const Color(0xFFE8F5E9),
          const Color(0xFF2E7D32),
        ),
      'delivered' => (
          const Color(0xFFE8F5E9),
          const Color(0xFF1B5E20),
        ),
      'cancelled' => (
          const Color(0xFFFFEBEE),
          const Color(0xFFC62828),
        ),
      _ => (
          const Color(0xFFF5F5F5),
          const Color(0xFF616161),
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}

// ─── Empty State ────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final VoidCallback onRefresh;

  const _EmptyState({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      color: AppColors.primary,
      child: ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
          const Icon(
            Icons.delivery_dining,
            size: 64,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 16),
          const Text(
            'No orders assigned yet',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pull down to refresh',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textHint,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error State ────────────────────────────────────────────

// ─── Store Offline Banner ────────────────────────────────

class _StoreOfflineBanner extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeStatus = ref.watch(storeStatusProvider);

    return storeStatus.when(
      data: (holiday) {
        if (holiday == null) return const SizedBox.shrink();
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.pagePadding, 12, AppDimens.pagePadding, 0,
          ),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.error.withOpacity(0.15),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.storefront_outlined,
                    size: 20,
                    color: AppColors.error,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        holiday.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        holiday.message,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.error.withOpacity(0.75),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

// ─── Error State ────────────────────────────────────────────

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
