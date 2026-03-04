import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/cart_item_model.dart';
import '../../home/providers/home_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/shipping_provider.dart';
import '../widgets/free_delivery_milestone.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(shippingProvider.notifier).fetchCharges();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          if (!cart.isEmpty)
            TextButton(
              onPressed: () => _confirmClear(context, ref),
              child: const Text('Clear',
                  style: TextStyle(color: AppColors.error, fontSize: 13)),
            ),
        ],
      ),
      body: cart.isEmpty ? _buildEmpty(context) : _buildCartList(context, ref, cart),
      bottomNavigationBar:
          cart.isEmpty ? null : _buildBottomBar(context, cart),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.surfaceBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shopping_bag_outlined,
                size: 36, color: AppColors.textHint),
          ),
          const SizedBox(height: AppDimens.md),
          const Text('Your cart is empty',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary)),
          const SizedBox(height: AppDimens.xs),
          const Text('Browse products and add items to get started',
              style: TextStyle(fontSize: 13, color: AppColors.textHint)),
        ],
      ),
    );
  }

  Widget _buildCartList(BuildContext context, WidgetRef ref, CartState cart) {
    return ListView(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      children: [
        // Free delivery milestone
        _buildDeliveryMilestone(cart.subtotal),
        const SizedBox(height: AppDimens.md),
        // Cart items
        ...cart.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.sm),
              child: _CartItemCard(item: item),
            )),
      ],
    );
  }

  Widget _buildDeliveryMilestone(double subtotal) {
    final threshold = ref.watch(freeDeliveryThresholdProvider);
    if (threshold == null) return const SizedBox.shrink();

    if (subtotal >= threshold) {
      return const FreeDeliveryUnlocked();
    }
    return FreeDeliveryMilestone(subtotal: subtotal, threshold: threshold);
  }

  Widget _buildBottomBar(BuildContext context, CartState cart) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          AppDimens.pagePadding, AppDimens.md, AppDimens.pagePadding, AppDimens.lg),
      decoration: const BoxDecoration(
        color: AppColors.cardBg,
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Summary row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cart.itemCount} item${cart.itemCount == 1 ? '' : 's'}',
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.textSecondary),
                ),
                Text(
                  cart.displaySubtotal,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.md),

            // Checkout button
            _buildCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final isOffline = homeState.isStoreOffline;
    final allowAdvance = homeState.holiday?.allowAdvanceOrders ?? true;

    // Store offline and advance orders disabled → block checkout
    if (isOffline && !allowAdvance) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.08),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.event_busy_rounded,
                    size: 20, color: AppColors.warning),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    homeState.holiday?.title ?? 'Store is currently closed',
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
              ),
              child: const Text('Checkout Unavailable'),
            ),
          ),
        ],
      );
    }

    // Store offline but advance orders allowed → show "Order for Later"
    final label = isOffline ? 'Order for Later' : 'Proceed to Checkout';
    final icon = isOffline ? Icons.schedule_rounded : null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => context.push('/checkout'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _confirmClear(BuildContext context, WidgetRef ref_) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear Cart'),
        content: const Text('Remove all items from your cart?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ref_.read(cartProvider.notifier).clearCart();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

class _CartItemCard extends ConsumerWidget {
  final CartItemModel item;

  const _CartItemCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.displayPrice,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppDimens.sm),
                Text(
                  item.displayLineTotal,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // Quantity controls + delete
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Delete button
              InkWell(
                onTap: () =>
                    ref.read(cartProvider.notifier).removeItem(item.cartKey),
                borderRadius: BorderRadius.circular(AppDimens.radiusFull),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.close, size: 18, color: AppColors.textHint),
                ),
              ),
              const SizedBox(height: AppDimens.sm),

              // Quantity stepper
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _stepperButton(
                      icon: Icons.remove,
                      onTap: () => ref
                          .read(cartProvider.notifier)
                          .decrementQuantity(item.cartKey),
                    ),
                    Container(
                      constraints: const BoxConstraints(minWidth: 36),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        '${item.quantity}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    _stepperButton(
                      icon: Icons.add,
                      onTap: () => ref
                          .read(cartProvider.notifier)
                          .incrementQuantity(item.cartKey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stepperButton(
      {required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusSm),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}
