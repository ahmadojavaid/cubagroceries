import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../cart/data/shipping_charge_model.dart';
import '../../cart/providers/cart_provider.dart';
import '../../cart/providers/shipping_provider.dart';
import '../../profile/data/address_model.dart';
import '../../profile/providers/address_provider.dart';
import '../../cart/widgets/coupon_input_widget.dart';
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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(addressProvider.notifier).fetchAddresses();
      ref.read(shippingProvider.notifier).fetchCharges();
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

    // Pre-select first option
    if (_selectedShippingId == null && state.charges.isNotEmpty) {
      _selectedShippingId = state.charges.first.id;
    }

    return Column(
      children: state.charges
          .map((charge) => _ShippingRadioCard(
                charge: charge,
                isSelected: _selectedShippingId == charge.id,
                onTap: () =>
                    setState(() => _selectedShippingId = charge.id),
              ))
          .toList(),
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
    final shippingAmount = selectedShipping?.amountValue ?? 0.0;
    final grandTotal = cart.subtotal + shippingAmount - coupon.discount;

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
        CouponInputWidget(orderTotal: cart.subtotal),
        const SizedBox(height: AppDimens.md),

        // Totals
        _totalRow('Subtotal', 'Rs ${cart.subtotal.toStringAsFixed(2)}'),
        if (selectedShipping != null)
          _totalRow(selectedShipping.title, selectedShipping.displayAmount),
        if (coupon.discount > 0)
          _totalRow('Coupon (${coupon.code})', '- Rs ${coupon.discount.toStringAsFixed(0)}',
              color: AppColors.success),
        const SizedBox(height: AppDimens.xs),
        _totalRow('Total', 'Rs ${grandTotal.toStringAsFixed(2)}',
            bold: true),
      ],
    );
  }

  Widget _totalRow(String label, String value, {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: bold ? 16 : 14,
                fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
                color: bold ? AppColors.textPrimary : AppColors.textSecondary,
              )),
          Text(value,
              style: TextStyle(
                fontSize: bold ? 16 : 14,
                fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
                color: AppColors.textPrimary,
              )),
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

    final order = await ref.read(orderActionProvider.notifier).placeOrder(
          addressId: _selectedAddressId!,
          items: items,
          shippingChargeId: _selectedShippingId,
        );

    if (order != null && mounted) {
      // Clear cart on success
      ref.read(cartProvider.notifier).clearCart();

      // Show success and navigate to order detail
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Order ${order.orderId} placed successfully!'),
        backgroundColor: AppColors.success,
      ));

      // Replace checkout with order detail
      context.go('/orders/${order.orderId}');
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
  final VoidCallback onTap;

  const _ShippingRadioCard({
    required this.charge,
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
      ),
    );
  }
}
