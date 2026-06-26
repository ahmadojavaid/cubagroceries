import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/auth_gate.dart';
import '../../../core/widgets/app_network_image.dart';
import '../data/product_model.dart';
import '../../cart/data/cart_item_model.dart';
import '../../cart/providers/cart_provider.dart';

class ProductCard extends ConsumerWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final price = product.firstPrice;
    final cartKey = price != null ? '${product.id}_${price.unit.id}' : null;
    final qtyInCart = price != null
        ? ref.watch(cartProvider.select(
            (s) => s.items
                .where((e) => e.cartKey == cartKey)
                .firstOrNull
                ?.quantity ?? 0,
          ))
        : 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Image ───
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: AppNetworkImage(
                      imageUrl: product.image,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Out of stock overlay
                  if (!product.inStock)
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.4),
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Sold Out',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.error,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ─── Info ───
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  // Unit hint
                  if (price != null)
                    Text(
                      'per ${price.unit.name}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textHint,
                      ),
                    ),
                  const SizedBox(height: 8),
                  // Price + quantity counter or add button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: price != null
                            ? Text(
                                'Rs ${price.cleanPrice}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                      if (product.inStock && price != null)
                        qtyInCart > 0
                            ? _QuantityCounter(
                                quantity: qtyInCart,
                                onIncrement: () {
                                  HapticFeedback.lightImpact();
                                  ref
                                      .read(cartProvider.notifier)
                                      .incrementQuantity(cartKey!);
                                },
                                onDecrement: () {
                                  HapticFeedback.lightImpact();
                                  ref
                                      .read(cartProvider.notifier)
                                      .decrementQuantity(cartKey!);
                                },
                              )
                            : _AddButton(
                                onTap: () {
                                  if (!requireAuth(context, ref)) return;
                                  HapticFeedback.mediumImpact();
                                  ref.read(cartProvider.notifier).addItem(
                                        CartItemModel(
                                          productId: product.id,
                                          productName: product.name,
                                          unitId: price.unit.id,
                                          unitName: price.unit.name,
                                          price: price.priceValue,
                                          quantity: 1,
                                        ),
                                      );
                                  ScaffoldMessenger.of(context)
                                    ..clearSnackBars()
                                    ..showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            '${product.name} added to cart'),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        duration: const Duration(
                                            seconds: 2),
                                        dismissDirection: DismissDirection.down,
                                        action: SnackBarAction(
                                          label: 'VIEW CART',
                                          textColor: Colors.white,
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            context.push('/cart');
                                          },
                                        ),
                                      ),
                                    );
                                },
                              ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact quantity counter: [ - ] qty [ + ]
class _QuantityCounter extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantityCounter({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Minus button
          _counterButton(
            icon: quantity == 1
                ? Icons.delete_outline_rounded
                : Icons.remove_rounded,
            onTap: onDecrement,
          ),
          // Quantity
          Container(
            constraints: const BoxConstraints(minWidth: 28),
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          // Plus button
          _counterButton(
            icon: Icons.add_rounded,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }

  Widget _counterButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}

/// Simple add button (shown when item is not in cart)
class _AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: const Padding(
          padding: EdgeInsets.all(7),
          child: Icon(Icons.add_rounded, size: 18, color: Colors.white),
        ),
      ),
    );
  }
}
