import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/order_model.dart';
import '../providers/order_provider.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() =>
      _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen>
    with WidgetsBindingObserver {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.microtask(
      () => ref.read(orderListProvider.notifier).fetchOrders(forceRefresh: true),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  /// Refresh when app resumes (e.g. user tapped a push notification, came back)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(orderListProvider.notifier).fetchOrders(forceRefresh: true);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(orderListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: state.isLoading && state.orders.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.error != null && state.orders.isEmpty
              ? ErrorStateWidget(
                  message: state.error!,
                  onRetry: () => ref
                      .read(orderListProvider.notifier)
                      .fetchOrders(forceRefresh: true),
                )
              : state.orders.isEmpty
                  ? const EmptyStateWidget(
                      icon: Icons.receipt_long_outlined,
                      message: 'No orders yet\nYour order history will appear here',
                    )
                  : RefreshIndicator(
                  color: AppColors.primary,
                  onRefresh: () => ref
                      .read(orderListProvider.notifier)
                      .fetchOrders(forceRefresh: true),
                  child: ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppDimens.pagePadding),
                    itemCount:
                        state.orders.length + (state.hasMore ? 1 : 0),
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: AppDimens.sm),
                    itemBuilder: (context, index) {
                      if (index >= state.orders.length) {
                        return const Padding(
                          padding: EdgeInsets.all(AppDimens.md),
                          child: Center(
                              child: CircularProgressIndicator(
                                  strokeWidth: 2)),
                        );
                      }
                      return _OrderCard(
                        order: state.orders[index],
                        onTap: () async {
                          await context
                              .push('/orders/${state.orders[index].orderId}');
                          // Refresh list when returning from detail
                          if (mounted) {
                            ref.read(orderListProvider.notifier)
                                .fetchOrders(forceRefresh: true);
                          }
                        },
                      );
                    },
                  ),
                ),
    );
  }

}

class _OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const _OrderCard({required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('MMM d, yyyy • h:mm a').format(order.createdAt);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.md),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: order ID + status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.orderId,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                _StatusBadge(status: order.status),
              ],
            ),
            const SizedBox(height: AppDimens.sm),

            // Info row
            Row(
              children: [
                const Icon(Icons.inventory_2_outlined,
                    size: 14, color: AppColors.textHint),
                const SizedBox(width: 4),
                Text(
                  '${order.productsCount} item${order.productsCount == 1 ? '' : 's'}',
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(width: AppDimens.md),
                const Icon(Icons.access_time,
                    size: 14, color: AppColors.textHint),
                const SizedBox(width: 4),
                Text(dateStr,
                    style: const TextStyle(
                        fontSize: 13, color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: AppDimens.sm),

            // Total + arrow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.displayTotal,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const Icon(Icons.chevron_right,
                    color: AppColors.textHint, size: 22),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, bgColor) = _statusColors(status);
    final label = status[0].toUpperCase() + status.substring(1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  (Color, Color) _statusColors(String status) {
    return switch (status) {
      'pending' => (AppColors.statusPending, AppColors.statusPending.withValues(alpha: 0.12)),
      'confirmed' => (AppColors.statusConfirmed, AppColors.statusConfirmed.withValues(alpha: 0.12)),
      'dispatched' => (AppColors.statusDispatched, AppColors.statusDispatched.withValues(alpha: 0.12)),
      'delivered' => (AppColors.statusDelivered, AppColors.statusDelivered.withValues(alpha: 0.12)),
      'cancelled' => (AppColors.statusCancelled, AppColors.statusCancelled.withValues(alpha: 0.12)),
      _ => (AppColors.textSecondary, AppColors.surfaceBg),
    };
  }
}
