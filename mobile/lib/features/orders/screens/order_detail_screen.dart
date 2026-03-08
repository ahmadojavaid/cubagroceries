import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/order_model.dart';
import '../providers/order_provider.dart';
import '../widgets/delivery_estimate_card.dart';
import '../widgets/order_review_popup.dart';
import '../widgets/order_review_section.dart';
import '../widgets/order_status_timeline.dart';

class OrderDetailScreen extends ConsumerStatefulWidget {
  final String orderNumber;

  const OrderDetailScreen({super.key, required this.orderNumber});

  @override
  ConsumerState<OrderDetailScreen> createState() =>
      _OrderDetailScreenState();
}

class _OrderDetailScreenState extends ConsumerState<OrderDetailScreen>
    with WidgetsBindingObserver {
  bool _reviewPromptShown = false;
  int _lastTrigger = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lastTrigger = ref.read(orderRefreshTrigger);
    Future.microtask(() async {
      final order = await ref
          .read(orderActionProvider.notifier)
          .fetchOrderDetail(widget.orderNumber);

      if (order != null &&
          order.status == 'delivered' &&
          !order.isReviewed &&
          !_reviewPromptShown &&
          mounted) {
        _maybeShowReviewPopup(order);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Re-fetch when app resumes (e.g. from push notification tap)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref
          .read(orderActionProvider.notifier)
          .fetchOrderDetail(widget.orderNumber);
    }
  }

  void _confirmCancel(String orderNumber) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text(
          'Are you sure you want to cancel this order? If you paid with wallet credit, it will be refunded.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Keep Order'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _doCancel(orderNumber);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Cancel Order'),
          ),
        ],
      ),
    );
  }

  Future<void> _doCancel(String orderNumber) async {
    final success = await ref
        .read(orderActionProvider.notifier)
        .cancelOrder(orderNumber);

    if (!mounted) return;

    if (success) {
      // Refresh order list
      ref.read(orderListProvider.notifier).fetchOrders(forceRefresh: true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order cancelled successfully'),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      final error = ref.read(orderActionProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error ?? 'Failed to cancel order'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  /// Check if the user already reviewed this order; if not, show popup.
  Future<void> _maybeShowReviewPopup(OrderDetailModel order) async {
    _reviewPromptShown = true;

    try {
      final api = ref.read(apiClientProvider);
      final response = await api.get('/orders/${order.id}/review');
      final data = response.data;

      // Already reviewed — skip
      if (data['success'] == true && data['data'] != null) return;
    } catch (_) {
      // If the check fails, don't block — just skip the popup
      return;
    }

    if (!mounted) return;

    // Small delay so the screen fully renders first
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => OrderReviewPopup(
        orderId: order.id,
        orderNumber: order.orderId,
        onSubmitted: () {
          // Refresh the review section
          ref.invalidate(orderReviewProvider(order.id));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Re-fetch order detail when FCM bumps the refresh trigger
    ref.listen<int>(orderRefreshTrigger, (prev, next) {
      if (next != _lastTrigger) {
        _lastTrigger = next;
        ref
            .read(orderActionProvider.notifier)
            .fetchOrderDetail(widget.orderNumber);
      }
    });

    final state = ref.watch(orderActionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderNumber),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? _buildError(state.error!)
              : state.placedOrder != null
                  ? _buildDetail(state.placedOrder!)
                  : const SizedBox.shrink(),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline,
              size: 48, color: AppColors.textHint),
          const SizedBox(height: AppDimens.md),
          Text(error,
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: AppDimens.md),
          TextButton(
            onPressed: () => ref
                .read(orderActionProvider.notifier)
                .fetchOrderDetail(widget.orderNumber),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildRiderCard(RiderModel rider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // Rider avatar
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delivery_dining_rounded,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),

          // Name and phone
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Rider',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textHint,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  rider.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (rider.phone != null)
                  Text(
                    rider.phone!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),

          // Call button
          if (rider.phone != null)
            Material(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppDimens.radiusFull),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                onTap: () => _callRider(rider.phone!),
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _callRider(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildDetail(OrderDetailModel order) {
    final dateStr =
        DateFormat('MMM d, yyyy • h:mm a').format(order.createdAt);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order status timeline
          OrderStatusTimeline(currentStatus: order.status),

          const SizedBox(height: AppDimens.md),

          // Delivery estimate countdown (only visible when dispatched)
          DeliveryEstimateCard(order: order),

          if (order.hasDeliveryEstimate &&
              (order.status == 'dispatched' || order.status == 'confirmed'))
            const SizedBox(height: AppDimens.md),

          // Rider details card
          if (order.rider != null &&
              order.status != 'cancelled') ...[
            _buildRiderCard(order.rider!),
            const SizedBox(height: AppDimens.md),
          ],

          // Order info card
          _SectionCard(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(order.orderId,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(dateStr,
                          style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary)),
                    ],
                  ),
                  _StatusBadge(status: order.status),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppDimens.md),

          // Delivery address
          if (order.address != null) ...[
            _SectionCard(
              title: 'Delivery Address',
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 18, color: AppColors.primary),
                    const SizedBox(width: AppDimens.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.address!.address,
                              style: const TextStyle(
                                  fontSize: 14, height: 1.4)),
                          if (order.address!.city != null)
                            Text(order.address!.city!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary)),
                          if (order.address!.phone != null)
                            Text(order.address!.phone!,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textHint)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppDimens.md),
          ],

          // Order items
          _SectionCard(
            title: 'Items (${order.items.length})',
            children: [
              ...order.items.map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: AppDimens.sm),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(item.productName,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              Text(
                                '${item.quantity} × ${item.displayPrice} / ${item.unitName}',
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                        Text(item.displayLineTotal,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )),
            ],
          ),

          const SizedBox(height: AppDimens.md),

          // Total
          _SectionCard(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700)),
                  Text(order.displayTotal,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                ],
              ),
            ],
          ),

          // Reviews section (only for delivered orders)
          OrderReviewSection(
            orderId: order.id,
            orderStatus: order.status,
            isReviewed: order.isReviewed,
            reviewRating: order.orderReview?.rating,
            reviewComment: order.orderReview?.comment,
          ),

          const SizedBox(height: AppDimens.lg),

          // Cancel order button (only for pending orders)
          if (order.status == 'pending') ...[            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _confirmCancel(order.orderId),
                icon: const Icon(Icons.cancel_outlined, size: 18),
                label: const Text('Cancel Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  ),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: AppDimens.sm),
          ],

          // File complaint button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => context.push(
                '/complaints/new?orderId=${order.id}',
              ),
              icon: const Icon(Icons.report_problem_outlined, size: 18),
              label: const Text('File a Complaint'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared widgets ─────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const _SectionCard({this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title!,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary)),
            const SizedBox(height: AppDimens.sm),
          ],
          ...children,
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w600, color: color),
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
