import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../cart/data/shipping_charge_model.dart';
import '../../cart/providers/cart_provider.dart';
import '../../cart/providers/shipping_provider.dart';
import '../../cart/widgets/free_delivery_milestone.dart';
import '../../profile/data/address_model.dart';
import '../../profile/providers/address_provider.dart';
import '../../cart/widgets/coupon_input_widget.dart';
import '../../profile/providers/profile_provider.dart';
import '../providers/order_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _currentStep = 0;
  int? _selectedAddressId;
  int? _selectedShippingId;
  bool _useWallet = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(addressProvider.notifier).fetchAddresses();
      ref.read(shippingProvider.notifier).fetchCharges();
      ref.read(profileProvider.notifier).fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _onStepContinue,
        onStepCancel: _onStepCancel,
        onStepTapped: (step) {
          if (step < _currentStep) {
            setState(() => _currentStep = step);
          }
        },
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: AppDimens.md),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMd),
                      ),
                      elevation: 0,
                      minimumSize: const Size(64, 52),
                      padding:
                          const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      _currentStep == 2 ? 'Place Order' : 'Next',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: AppDimens.sm),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
                ],
              ],
            ),
          );
        },
        steps: [
          Step(
            title: const Text('Delivery Address'),
            isActive: _currentStep >= 0,
            state: _currentStep > 0
                ? StepState.complete
                : StepState.indexed,
            content: _buildAddressStep(),
          ),
          Step(
            title: const Text('Shipping'),
            isActive: _currentStep >= 1,
            state: _currentStep > 1
                ? StepState.complete
                : StepState.indexed,
            content: _buildShippingStep(),
          ),
          Step(
            title: const Text('Review & Confirm'),
            isActive: _currentStep >= 2,
            state: StepState.indexed,
            content: _buildReviewStep(),
          ),
        ],
      ),
    );
  }

  // ─── Step 1: Address Selection ─────────────────────────────

  Widget _buildAddressStep() {
    final state = ref.watch(addressProvider);

    if (state.isLoading && state.addresses.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppDimens.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.addresses.isEmpty) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.lg),
            child: Text('No saved addresses.',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          OutlinedButton.icon(
            onPressed: () async {
              final result = await context.push('/addresses/add');
              if (result == true) {
                ref.read(addressProvider.notifier).fetchAddresses();
              }
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Address'),
          ),
        ],
      );
    }

    // Pre-select default address
    if (_selectedAddressId == null) {
      final defaultAddr = state.addresses
          .where((a) => a.isDefault)
          .firstOrNull;
      if (defaultAddr != null) {
        _selectedAddressId = defaultAddr.id;
      } else if (state.addresses.isNotEmpty) {
        _selectedAddressId = state.addresses.first.id;
      }
    }

    return Column(
      children: [
        ...state.addresses.map((addr) => _AddressRadioCard(
              address: addr,
              isSelected: _selectedAddressId == addr.id,
              onTap: () =>
                  setState(() => _selectedAddressId = addr.id),
            )),
        const SizedBox(height: AppDimens.sm),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: () async {
              final result = await context.push('/addresses/add');
              if (result == true) {
                ref.read(addressProvider.notifier).fetchAddresses();
              }
            },
            icon: const Icon(Icons.add, size: 16),
            label: const Text('Add New Address',
                style: TextStyle(fontSize: 13)),
          ),
        ),
      ],
    );
  }

  // ─── Step 2: Shipping Selection ────────────────────────────

  Widget _buildShippingStep() {
    final state = ref.watch(shippingProvider);
    final cart = ref.watch(cartProvider);
    final subtotal = cart.subtotal;
    final threshold = ref.watch(freeDeliveryThresholdProvider);
    final freeOption = ref.watch(freeDeliveryOptionProvider);
    final qualifiesForFree = threshold != null && subtotal >= threshold && freeOption != null;

    if (state.isLoading && state.charges.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(AppDimens.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.charges.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.lg),
        child: Text('No shipping options available.',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }

    // Auto-select free delivery when eligible
    if (qualifiesForFree) {
      _selectedShippingId = freeOption!.id;
      return const Column(
        children: [
          FreeDeliveryUnlocked(),
        ],
      );
    }

    // Below threshold — show paid options + milestone
    final paidCharges = state.charges.where((c) => c.amountValue > 0).toList();

    // Pre-select first paid option
    if (_selectedShippingId == null && paidCharges.isNotEmpty) {
      _selectedShippingId = paidCharges.first.id;
    }

    // If current selection is the free option but not eligible, switch
    if (freeOption != null && _selectedShippingId == freeOption.id) {
      _selectedShippingId = paidCharges.isNotEmpty ? paidCharges.first.id : null;
    }

    return Column(
      children: [
        // Milestone bar
        if (threshold != null) ...[
          FreeDeliveryMilestone(subtotal: subtotal, threshold: threshold),
          const SizedBox(height: AppDimens.md),
        ],
        // Paid shipping options only
        ...paidCharges.map((charge) => _ShippingRadioCard(
              charge: charge,
              isSelected: _selectedShippingId == charge.id,
              enabled: true,
              onTap: () => setState(() => _selectedShippingId = charge.id),
            )),
      ],
    );
  }

  // ─── Step 3: Review & Confirm ──────────────────────────────

  Widget _buildReviewStep() {
    final cart = ref.watch(cartProvider);
    final addresses = ref.watch(addressProvider).addresses;
    final shippingCharges = ref.watch(shippingProvider).charges;
    final orderState = ref.watch(orderActionProvider);

    final selectedAddress = addresses
        .where((a) => a.id == _selectedAddressId)
        .firstOrNull;
    final selectedShipping = shippingCharges
        .where((c) => c.id == _selectedShippingId)
        .firstOrNull;

    final coupon = ref.watch(couponProvider);
    final profileState = ref.watch(profileProvider);
    final walletBalance = double.tryParse(profileState.user?.walletAmount ?? '0') ?? 0.0;

    final shippingAmount = selectedShipping?.amountValue ?? 0.0;
    // For free_delivery coupons, discount applies to shipping, not subtotal
    final effectiveShipping = coupon.isFreeDelivery
        ? 0.0
        : shippingAmount;
    final couponItemDiscount = coupon.isFreeDelivery
        ? 0.0
        : coupon.discount;
    final preWalletTotal = cart.subtotal + effectiveShipping - couponItemDiscount;
    final walletDeduction = _useWallet ? (walletBalance > 0 ? walletBalance.clamp(0, preWalletTotal) : 0.0) : 0.0;
    final grandTotal = preWalletTotal - walletDeduction;

    if (orderState.isLoading) {
      return const Padding(
        padding: EdgeInsets.all(AppDimens.xl),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Delivery address
        if (selectedAddress != null) ...[
          const Text('Deliver to',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary)),
          const SizedBox(height: AppDimens.xs),
          Text(selectedAddress.displayName,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600)),
          Text(selectedAddress.address,
              style: const TextStyle(
                  fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: AppDimens.md),
        ],

        // Items summary
        const Text('Items',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary)),
        const SizedBox(height: AppDimens.xs),
        ...cart.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${item.productName} × ${item.quantity} ${item.unitName}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Text(item.displayLineTotal,
                      style: const TextStyle(fontSize: 14)),
                ],
              ),
            )),

        const Divider(height: AppDimens.lg, color: AppColors.divider),

        // Coupon
        CouponInputWidget(
          orderTotal: cart.subtotal,
          shippingAmount: shippingAmount,
        ),
        const SizedBox(height: AppDimens.md),

        // Wallet credit toggle
        if (walletBalance > 0) ...[
          Container(
            padding: const EdgeInsets.all(AppDimens.md),
            decoration: BoxDecoration(
              color: AppColors.primarySurface.withOpacity(0.3),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(
                color: _useWallet ? AppColors.primary : AppColors.border,
                width: _useWallet ? 1.5 : 0.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColors.primary,
                  size: 22,
                ),
                const SizedBox(width: AppDimens.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Use Wallet Credit',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Available: Rs ${walletBalance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _useWallet,
                  onChanged: (v) => setState(() => _useWallet = v),
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.md),
        ],

        // Totals
        _totalRow('Subtotal', 'Rs ${cart.subtotal.toStringAsFixed(2)}'),
        if (selectedShipping != null)
          coupon.isFreeDelivery
              ? _totalRow(
                  selectedShipping.title,
                  'FREE',
                  color: AppColors.success,
                  strikethrough: selectedShipping.displayAmount,
                )
              : _totalRow(selectedShipping.title, selectedShipping.displayAmount),
        if (coupon.isApplied && !coupon.isFreeDelivery && coupon.discount > 0)
          _totalRow('Coupon (${coupon.code})', '- Rs ${coupon.discount.toStringAsFixed(0)}',
              color: AppColors.success),
        if (_useWallet && walletDeduction > 0)
          _totalRow('Wallet Credit', '- Rs ${walletDeduction.toStringAsFixed(2)}',
              color: AppColors.primary),
        const SizedBox(height: AppDimens.xs),
        _totalRow('Total', 'Rs ${grandTotal.toStringAsFixed(2)}',
            bold: true),
      ],
    );
  }

  Widget _totalRow(String label, String value,
      {bool bold = false, Color? color, String? strikethrough}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: bold ? 16 : 14,
                fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
                color: color ?? (bold ? AppColors.textPrimary : AppColors.textSecondary),
              )),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (strikethrough != null) ...[
                Text(strikethrough,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textHint,
                      decoration: TextDecoration.lineThrough,
                    )),
                const SizedBox(width: 6),
              ],
              Text(value,
                  style: TextStyle(
                    fontSize: bold ? 16 : 14,
                    fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
                    color: color ?? AppColors.textPrimary,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  // ─── Navigation ────────────────────────────────────────────

  void _onStepContinue() {
    if (_currentStep == 0) {
      if (_selectedAddressId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a delivery address'),
          backgroundColor: AppColors.warning,
        ));
        return;
      }
      setState(() => _currentStep = 1);
    } else if (_currentStep == 1) {
      setState(() => _currentStep = 2);
    } else if (_currentStep == 2) {
      _placeOrder();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  Future<void> _placeOrder() async {
    final cart = ref.read(cartProvider);

    final items = cart.items
        .map((item) => {
              'product_id': item.productId,
              'unit_id': item.unitId,
              'quantity': item.quantity,
            })
        .toList();

    final coupon = ref.read(couponProvider);
    final order = await ref.read(orderActionProvider.notifier).placeOrder(
          addressId: _selectedAddressId!,
          items: items,
          shippingChargeId: _selectedShippingId,
          couponCode: coupon.code,
          useWallet: _useWallet,
        );

    if (order != null && mounted) {
      // Clear cart and coupon on success
      ref.read(cartProvider.notifier).clearCart();
      ref.read(couponProvider.notifier).clear();

      // Refresh profile to get updated wallet balance
      ref.read(profileProvider.notifier).fetchProfile();

      // Show success and navigate to order detail
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Order ${order.orderId} placed successfully!'),
        backgroundColor: AppColors.success,
      ));

      // Go home first, then push order detail on top
      context.go('/home');
      context.push('/orders/${order.orderId}');
    } else if (mounted) {
      final error = ref.read(orderActionProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error ?? 'Failed to place order'),
        backgroundColor: AppColors.error,
      ));
    }
  }
}

// ─── Sub-widgets ───────────────────────────────────────────────

class _AddressRadioCard extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final VoidCallback onTap;

  const _AddressRadioCard({
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppDimens.sm),
        padding: const EdgeInsets.all(AppDimens.md),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primarySurface.withValues(alpha: 0.5)
              : AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected ? AppColors.primary : AppColors.textHint,
              size: 22,
            ),
            const SizedBox(width: AppDimens.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        address.displayName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (address.isDefault) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius:
                                BorderRadius.circular(AppDimens.radiusFull),
                          ),
                          child: const Text('Default',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(address.address,
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.textSecondary)),
                  if (address.phone != null)
                    Text(address.phone!,
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.textHint)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShippingRadioCard extends StatelessWidget {
  final ShippingChargeModel charge;
  final bool isSelected;
  final bool enabled;
  final VoidCallback? onTap;

  const _ShippingRadioCard({
    required this.charge,
    required this.isSelected,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dimmed = !enabled;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: dimmed ? 0.45 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: AppDimens.sm),
          padding: const EdgeInsets.all(AppDimens.md),
          decoration: BoxDecoration(
            color: isSelected && enabled
                ? AppColors.primarySurface.withValues(alpha: 0.5)
                : AppColors.cardBg,
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            border: Border.all(
              color: isSelected && enabled ? AppColors.primary : AppColors.border,
              width: isSelected && enabled ? 1.5 : 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    isSelected && enabled
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected && enabled ? AppColors.primary : AppColors.textHint,
                    size: 22,
                  ),
                  const SizedBox(width: AppDimens.sm),
                  Expanded(
                    child: Text(charge.title,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                  Text(charge.displayAmount,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary)),
                ],
              ),
              if (dimmed && charge.minOrderAmount != null) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 34, top: 4),
                  child: Text(
                    'Min. order Rs ${charge.minOrderAmount!.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textHint,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
