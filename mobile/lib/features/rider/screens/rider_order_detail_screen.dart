import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/utils/launcher_utils.dart';
import '../providers/rider_orders_provider.dart';

class RiderOrderDetailScreen extends ConsumerWidget {
  final String orderNumber;

  const RiderOrderDetailScreen({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(riderOrderDetailProvider(orderNumber));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        title: Text(
          '#$orderNumber',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.scaffoldBg,
        elevation: 0,
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline,
                  size: 48, color: AppColors.error),
              const SizedBox(height: 12),
              const Text('Could not load order details'),
              TextButton(
                onPressed: () =>
                    ref.invalidate(riderOrderDetailProvider(orderNumber)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (order) {
          if (order == null) {
            return const Center(child: Text('Order not found'));
          }
          return _OrderDetailBody(order: order);
        },
      ),
    );
  }
}

class _OrderDetailBody extends StatelessWidget {
  final RiderOrder order;

  const _OrderDetailBody({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(AppDimens.pagePadding),
            children: [
              _OrderInfoSection(order: order),
              const SizedBox(height: 16),
              if (order.address != null)
                _DeliveryAddressSection(address: order.address!),
              const SizedBox(height: 16),
              if (order.customer != null)
                _CustomerSection(customer: order.customer!),
              const SizedBox(height: 16),
              _OrderItemsSection(items: order.items),
            ],
          ),
        ),
        _ActionButtons(order: order),
      ],
    );
  }
}

// ─── Order Info Section ─────────────────────────────────────

class _OrderInfoSection extends StatelessWidget {
  final RiderOrder order;

  const _OrderInfoSection({required this.order});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Order Info'),
          const SizedBox(height: 12),
          _InfoRow('Order #', order.orderId),
          _InfoRow('Status', order.statusLabel),
          _InfoRow('Total', 'PKR ${order.totalAmount}'),
          _InfoRow('Date', _formatDate(order.createdAt)),
        ],
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

// ─── Delivery Address Section ───────────────────────────────

class _DeliveryAddressSection extends StatelessWidget {
  final RiderOrderAddress address;

  const _DeliveryAddressSection({required this.address});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Delivery Address'),
          const SizedBox(height: 12),
          Text(
            address.address,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          if (address.city != null && address.city!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              address.city!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (address.phone != null && address.phone!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone_outlined,
                    size: 15, color: AppColors.textHint),
                const SizedBox(width: 6),
                Text(
                  address.phone!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
          if (address.hasCoordinates) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.gps_fixed,
                    size: 14, color: AppColors.textHint),
                const SizedBox(width: 6),
                Text(
                  '${address.latitude!.toStringAsFixed(5)}, ${address.longitude!.toStringAsFixed(5)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Customer Section ───────────────────────────────────────

class _CustomerSection extends StatelessWidget {
  final RiderOrderCustomer customer;

  const _CustomerSection({required this.customer});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Customer'),
          const SizedBox(height: 12),
          _InfoRow('Name', customer.fullName),
          if (customer.identity != null)
            _InfoRow('Phone', customer.identity!),
        ],
      ),
    );
  }
}

// ─── Order Items Section ────────────────────────────────────

class _OrderItemsSection extends StatelessWidget {
  final List<RiderOrderItem> items;

  const _OrderItemsSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Items (${items.length})'),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.productName,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      '${item.quantity} ${item.unitName}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'PKR ${item.price}',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ─── Action Buttons ─────────────────────────────────────────

class _ActionButtons extends StatelessWidget {
  final RiderOrder order;

  const _ActionButtons({required this.order});

  @override
  Widget build(BuildContext context) {
    final phone = order.customer?.identity ??
        order.address?.phone;

    return Container(
      padding: EdgeInsets.only(
        left: AppDimens.pagePadding,
        right: AppDimens.pagePadding,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Open in Maps
          Expanded(
            child: _ActionButton(
              icon: Icons.map_outlined,
              label: 'Open in Maps',
              color: AppColors.primary,
              onTap: () => LauncherUtils.openGoogleMaps(
                latitude: order.address?.latitude,
                longitude: order.address?.longitude,
                addressFallback: order.address != null
                    ? '${order.address!.address}, ${order.address!.city ?? ''}'
                    : null,
                context: context,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // WhatsApp Customer
          Expanded(
            child: _ActionButton(
              icon: Icons.chat_outlined,
              label: 'WhatsApp',
              color: const Color(0xFF25D366),
              onTap: phone != null && phone.isNotEmpty
                  ? () => LauncherUtils.openWhatsApp(
                        phone: phone,
                        message:
                            'Hi! I am your delivery rider from Cuba Groceries. Your order #${order.orderId} is on the way.',
                        context: context,
                      )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey.shade200 : color,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: isDisabled ? Colors.grey : Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDisabled ? Colors.grey : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shared Widgets ─────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
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
    return Text(
      title,
      style: GoogleFonts.dmSans(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textHint,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
