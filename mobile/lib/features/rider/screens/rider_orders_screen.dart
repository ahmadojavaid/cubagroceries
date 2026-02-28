import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../providers/rider_orders_provider.dart';

class RiderOrdersScreen extends ConsumerWidget {
  const RiderOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(riderOrdersProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text(
          'My Deliveries',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
      ),
      body: _buildBody(context, ref, ordersState),
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, RiderOrdersState state) {
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

    return RefreshIndicator(
      onRefresh: () => ref.read(riderOrdersProvider.notifier).refresh(),
      color: AppColors.primary,
      child: ListView.separated(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        itemCount: state.orders.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = state.orders[index];
          return _RiderOrderCard(
            order: order,
            onTap: () => context.push('/rider/orders/${order.orderId}'),
          );
        },
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
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: AppColors.border, width: 0.5),
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
              Row(
                children: [
                  const Icon(Icons.person_outline,
                      size: 16, color: AppColors.textHint),
                  const SizedBox(width: 6),
                  Text(
                    order.customer!.fullName,
                    style: const TextStyle(
                      fontSize: 13.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

            if (order.address != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 16, color: AppColors.textHint),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      order.address!.shortAddress,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textHint,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 12),
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: 10),

            // Bottom row: total + date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PKR ${order.totalAmount}',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
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
      return DateFormat('MMM d, yyyy – h:mm a').format(date.toLocal());
    } catch (_) {
      return dateStr;
    }
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
