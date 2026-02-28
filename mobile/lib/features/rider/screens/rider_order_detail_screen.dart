import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/utils/launcher_utils.dart';
import '../providers/rider_orders_provider.dart';

class RiderOrderDetailScreen extends ConsumerStatefulWidget {
  final String orderNumber;
  const RiderOrderDetailScreen({super.key, required this.orderNumber});

  @override
  ConsumerState<RiderOrderDetailScreen> createState() =>
      _RiderOrderDetailScreenState();
}

class _RiderOrderDetailScreenState
    extends ConsumerState<RiderOrderDetailScreen> {
  bool _isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final orderAsync = ref.watch(riderOrderDetailProvider(widget.orderNumber));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text('#${widget.orderNumber}',
            style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 18)),
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.error),
              const SizedBox(height: 12),
              const Text('Could not load order details'),
              TextButton(
                onPressed: () =>
                    ref.invalidate(riderOrderDetailProvider(widget.orderNumber)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (order) {
          if (order == null) return const Center(child: Text('Order not found'));
          final localOrders = ref.watch(riderOrdersProvider).orders;
          final localOrder =
              localOrders.where((o) => o.orderId == order.orderId).firstOrNull;
          return _buildBody(context, localOrder ?? order);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, RiderOrder order) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            children: [
              _StatusBanner(status: order.status, label: order.statusLabel),
              const SizedBox(height: 16),
              _StatusTimeline(currentStatus: order.status),
              const SizedBox(height: 16),
              _OrderInfoSection(order: order),
              const SizedBox(height: 16),
              if (order.address != null)
                _DeliveryAddressSection(address: order.address!),
              const SizedBox(height: 16),
              if (order.customer != null)
                _CustomerSection(customer: order.customer!),
              const SizedBox(height: 16),
              _OrderItemsSection(items: order.items, total: order.totalAmount),
              const SizedBox(height: 24),
            ],
          ),
        ),
        _BottomActions(
          order: order,
          isUpdating: _isUpdating,
          onUpdateStatus: (s) => _handleStatusUpdate(order, s),
        ),
      ],
    );
  }

  Future<void> _handleStatusUpdate(RiderOrder order, String newStatus) async {
    final label =
        newStatus == 'dispatched' ? 'Start Delivery' : 'Mark Delivered';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('$label?'),
        content: Text(newStatus == 'dispatched'
            ? 'This will notify the customer that their order is on the way.'
            : 'This will mark the order as delivered and notify the customer.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Confirm')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _isUpdating = true);
    HapticFeedback.mediumImpact();

    final success = await ref
        .read(riderOrdersProvider.notifier)
        .updateStatus(order.orderId, newStatus);

    if (mounted) {
      setState(() => _isUpdating = false);
      if (success) {
        ref.invalidate(riderOrderDetailProvider(order.orderId));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(newStatus == 'dispatched'
              ? 'Order dispatched!'
              : 'Order delivered!'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Could not update status. Try again.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ));
      }
    }
  }
}

// ── Status Banner ───────────────────────────────────────────

class _StatusBanner extends StatelessWidget {
  final String status;
  final String label;
  const _StatusBanner({required this.status, required this.label});

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg, IconData icon) = switch (status) {
      'pending' => (const Color(0xFFFFF3E0), const Color(0xFFE65100), Icons.schedule_rounded),
      'confirmed' => (const Color(0xFFE3F2FD), const Color(0xFF1565C0), Icons.thumb_up_alt_rounded),
      'dispatched' => (const Color(0xFFE0F2F1), const Color(0xFF00695C), Icons.local_shipping_rounded),
      'delivered' => (const Color(0xFFE8F5E9), const Color(0xFF1B5E20), Icons.check_circle_rounded),
      'cancelled' => (const Color(0xFFFFEBEE), const Color(0xFFC62828), Icons.cancel_rounded),
      _ => (const Color(0xFFF5F5F5), const Color(0xFF616161), Icons.info_outline),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icon, size: 28, color: fg),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Status',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500,
                      color: fg.withOpacity(0.7), letterSpacing: 0.3)),
              const SizedBox(height: 2),
              Text(label,
                  style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.w800, color: fg)),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Status Timeline ─────────────────────────────────────────

class _StatusTimeline extends StatelessWidget {
  final String currentStatus;
  const _StatusTimeline({required this.currentStatus});

  static const _steps = [
    ('pending', 'Pending', Icons.schedule_rounded),
    ('confirmed', 'Confirmed', Icons.thumb_up_alt_rounded),
    ('dispatched', 'Dispatched', Icons.local_shipping_rounded),
    ('delivered', 'Delivered', Icons.check_circle_rounded),
  ];

  int get _currentIndex {
    if (currentStatus == 'cancelled') return -1;
    for (int i = 0; i < _steps.length; i++) {
      if (_steps[i].$1 == currentStatus) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (currentStatus == 'cancelled') return const SizedBox.shrink();
    final activeIdx = _currentIndex;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            final stepIdx = i ~/ 2;
            return Expanded(
              child: Container(
                height: 2.5,
                decoration: BoxDecoration(
                  color: stepIdx < activeIdx
                      ? AppColors.primary
                      : AppColors.border.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }
          final stepIdx = i ~/ 2;
          final (_, label, icon) = _steps[stepIdx];
          final isActive = stepIdx <= activeIdx;
          final isCurrent = stepIdx == activeIdx;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  color: isCurrent
                      ? AppColors.primary
                      : isActive
                          ? AppColors.primary.withOpacity(0.15)
                          : AppColors.surfaceBg,
                  shape: BoxShape.circle,
                  border: isCurrent ? null : Border.all(
                    color: isActive ? AppColors.primary : AppColors.border.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: Icon(icon, size: 16,
                    color: isCurrent ? Colors.white : isActive ? AppColors.primary : AppColors.textHint),
              ),
              const SizedBox(height: 6),
              Text(label,
                  style: TextStyle(fontSize: 9.5,
                      fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      color: isActive ? AppColors.textPrimary : AppColors.textHint)),
            ],
          );
        }),
      ),
    );
  }
}

// ── Order Info ───────────────────────────────────────────────

class _OrderInfoSection extends StatelessWidget {
  final RiderOrder order;
  const _OrderInfoSection({required this.order});

  @override
  Widget build(BuildContext context) {
    return _Card(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Order Info'),
        const SizedBox(height: 12),
        _DetailRow('Order #', order.orderId),
        _DetailRow('Total', 'Rs ${order.totalAmount}'),
        _DetailRow('Date', _fmtDate(order.createdAt)),
        _DetailRow('Items', '${order.items.length}'),
      ],
    ));
  }

  String _fmtDate(String d) {
    try { return DateFormat('MMM d, yyyy \u2013 h:mm a').format(DateTime.parse(d).toLocal()); }
    catch (_) { return d; }
  }
}

// ── Delivery Address ────────────────────────────────────────

class _DeliveryAddressSection extends StatelessWidget {
  final RiderOrderAddress address;
  const _DeliveryAddressSection({required this.address});

  @override
  Widget build(BuildContext context) {
    return _Card(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Delivery Address'),
        const SizedBox(height: 12),
        Text(address.address, style: const TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 1.5)),
        if (address.city != null && address.city!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(address.city!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ],
        if (address.phone != null && address.phone!.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(children: [
            const Icon(Icons.phone_outlined, size: 15, color: AppColors.textHint),
            const SizedBox(width: 6),
            Text(address.phone!, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          ]),
        ],
      ],
    ));
  }
}

// ── Customer ────────────────────────────────────────────────

class _CustomerSection extends StatelessWidget {
  final RiderOrderCustomer customer;
  const _CustomerSection({required this.customer});

  @override
  Widget build(BuildContext context) {
    return _Card(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Customer'),
        const SizedBox(height: 12),
        Row(children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(color: AppColors.primarySurface, shape: BoxShape.circle),
            child: Center(child: Text(
              customer.fullName.isNotEmpty ? customer.fullName[0].toUpperCase() : '?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.primary),
            )),
          ),
          const SizedBox(width: 12),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(customer.fullName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
              if (customer.identity != null) ...[
                const SizedBox(height: 2),
                Text(customer.identity!, style: const TextStyle(fontSize: 13, color: AppColors.textHint)),
              ],
            ],
          )),
        ]),
      ],
    ));
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _CircleAction({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }
}

// ── Items ───────────────────────────────────────────────────

class _OrderItemsSection extends StatelessWidget {
  final List<RiderOrderItem> items;
  final String total;
  const _OrderItemsSection({required this.items, required this.total});

  @override
  Widget build(BuildContext context) {
    return _Card(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle('Items (${items.length})'),
        const SizedBox(height: 12),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(children: [
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(color: AppColors.surfaceBg, borderRadius: BorderRadius.circular(6)),
              child: Center(child: Text('${item.quantity}',
                  style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.textSecondary))),
            ),
            const SizedBox(width: 10),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
                Text('${item.quantity} x ${item.unitName}', style: const TextStyle(fontSize: 12, color: AppColors.textHint)),
              ],
            )),
            Text('Rs ${item.price}', style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          ]),
        )),
        const Divider(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total', style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          Text('Rs $total', style: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.primary)),
        ]),
      ],
    ));
  }
}

// ── Bottom Actions ──────────────────────────────────────────

class _BottomActions extends StatelessWidget {
  final RiderOrder order;
  final bool isUpdating;
  final Function(String) onUpdateStatus;

  const _BottomActions({required this.order, required this.isUpdating, required this.onUpdateStatus});

  @override
  Widget build(BuildContext context) {
    final (String? actionLabel, String? nextStatus, IconData? actionIcon, Color? actionColor) = switch (order.status) {
      'confirmed' => ('Start Delivery', 'dispatched', Icons.local_shipping_rounded, const Color(0xFF1565C0)),
      'dispatched' => ('Mark Delivered', 'delivered', Icons.check_circle_rounded, const Color(0xFF2E7D32)),
      _ => (null, null, null, null),
    };

    final phone = order.customer?.identity ?? order.address?.phone;

    return Container(
      padding: EdgeInsets.only(
        left: AppDimens.pagePadding, right: AppDimens.pagePadding,
        top: 12, bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        border: const Border(top: BorderSide(color: AppColors.border, width: 0.5)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (actionLabel != null && nextStatus != null) ...[
            SizedBox(
              width: double.infinity, height: 50,
              child: FilledButton.icon(
                onPressed: isUpdating ? null : () => onUpdateStatus(nextStatus),
                icon: isUpdating
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Icon(actionIcon, size: 20),
                label: Text(isUpdating ? 'Updating...' : actionLabel,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                style: FilledButton.styleFrom(
                  backgroundColor: actionColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
          Row(children: [
            if (order.address != null && order.address!.hasCoordinates)
              Expanded(child: _SecondaryBtn(icon: Icons.map_rounded, label: 'Maps',
                  onTap: () => LauncherUtils.openGoogleMaps(
                    latitude: order.address?.latitude, longitude: order.address?.longitude,
                    addressFallback: order.address != null ? '${order.address!.address}, ${order.address!.city ?? ''}' : null,
                    context: context))),
            if (order.address != null && order.address!.hasCoordinates && phone != null && phone.isNotEmpty)
              const SizedBox(width: 10),
            if (phone != null && phone.isNotEmpty)
              Expanded(child: _SecondaryBtn(icon: Icons.chat_rounded, label: 'WhatsApp', color: const Color(0xFF25D366),
                  onTap: () => LauncherUtils.openWhatsApp(phone: phone,
                      message: 'Hi! I am your delivery rider from Cuba Groceries. Your order #${order.orderId} is on the way.',
                      context: context))),
            if (phone != null && phone.isNotEmpty) ...[
              const SizedBox(width: 10),
              Expanded(child: _SecondaryBtn(icon: Icons.phone_rounded, label: 'Call', color: AppColors.primary,
                  onTap: () => LauncherUtils.call(phone: phone, context: context))),
            ],
          ]),
        ],
      ),
    );
  }
}

class _SecondaryBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;
  const _SecondaryBtn({required this.icon, required this.label, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.textSecondary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(10),
          border: Border.all(color: c.withOpacity(0.15)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 18, color: c),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: c)),
        ]),
      ),
    );
  }
}

// ── Shared ──────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg, borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: GoogleFonts.dmSans(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textPrimary));
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textHint)),
        Flexible(child: Text(value, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: AppColors.textPrimary), textAlign: TextAlign.end)),
      ]),
    );
  }
}
