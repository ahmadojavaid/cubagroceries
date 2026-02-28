import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../orders/data/order_model.dart';
import '../../orders/providers/order_provider.dart';
import '../providers/complaint_provider.dart';

class ComplaintFormScreen extends ConsumerStatefulWidget {
  final int? orderId;

  const ComplaintFormScreen({super.key, this.orderId});

  @override
  ConsumerState<ComplaintFormScreen> createState() =>
      _ComplaintFormScreenState();
}

class _ComplaintFormScreenState extends ConsumerState<ComplaintFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  OrderModel? _selectedOrder;
  bool _orderPickerExpanded = false;

  @override
  void initState() {
    super.initState();
    // Fetch orders for the picker
    Future.microtask(() {
      ref.read(orderListProvider.notifier).fetchOrders();
      // If pre-linked to an order, find it after orders load
      if (widget.orderId != null) {
        _preselectOrder();
      }
    });
  }

  void _preselectOrder() {
    // Wait for orders to load, then preselect
    final orders = ref.read(orderListProvider).orders;
    final match = orders.where((o) => o.id == widget.orderId).firstOrNull;
    if (match != null) {
      setState(() => _selectedOrder = match);
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final complaint =
        await ref.read(submitComplaintProvider.notifier).submitComplaint(
              subject: _subjectController.text.trim(),
              message: _messageController.text.trim(),
              orderId: _selectedOrder?.id ?? widget.orderId,
            );

    if (complaint != null && mounted) {
      ref.read(complaintListProvider.notifier).addComplaint(complaint);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Complaint submitted successfully'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(submitComplaintProvider);
    final orderState = ref.watch(orderListProvider);

    // Preselect order when list loads if orderId was passed
    ref.listen<OrderListState>(orderListProvider, (prev, next) {
      if (widget.orderId != null &&
          _selectedOrder == null &&
          next.orders.isNotEmpty) {
        final match =
            next.orders.where((o) => o.id == widget.orderId).firstOrNull;
        if (match != null) setState(() => _selectedOrder = match);
      }
    });

    // Listen for submit errors
    ref.listen<SubmitComplaintState>(submitComplaintProvider, (prev, next) {
      if (next.error != null && prev?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(submitComplaintProvider.notifier).clearError();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('File a Complaint'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Order Picker ──
              _buildSectionLabel('Related Order (Optional)'),
              const SizedBox(height: AppDimens.sm),
              _buildOrderPicker(orderState),

              const SizedBox(height: AppDimens.lg),

              // ── Subject ──
              _buildSectionLabel('Subject'),
              const SizedBox(height: AppDimens.sm),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  hintText: 'Brief description of the issue',
                  prefixIcon: Icon(Icons.subject_rounded, size: 20),
                ),
                maxLength: 255,
                textInputAction: TextInputAction.next,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Subject is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppDimens.md),

              // ── Message ──
              _buildSectionLabel('Description'),
              const SizedBox(height: AppDimens.sm),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Describe your issue in detail...',
                  alignLabelWithHint: true,
                ),
                maxLines: 6,
                maxLength: 5000,
                textInputAction: TextInputAction.done,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppDimens.lg + 4),

              // ── Submit ──
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: submitState.isLoading ? null : _submit,
                  icon: submitState.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.send_rounded, size: 18),
                  label: Text(
                      submitState.isLoading ? 'Submitting...' : 'Submit'),
                ),
              ),

              const SizedBox(height: AppDimens.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.2,
      ),
    );
  }

  /// Order picker — tappable selector card + expandable list
  Widget _buildOrderPicker(OrderListState orderState) {
    return Column(
      children: [
        // Selected order card / placeholder
        Material(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          child: InkWell(
            onTap: orderState.orders.isEmpty
                ? null
                : () =>
                    setState(() => _orderPickerExpanded = !_orderPickerExpanded),
            borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            child: Container(
              padding: const EdgeInsets.all(AppDimens.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                border: Border.all(color: AppColors.border),
              ),
              child: _selectedOrder != null
                  ? _buildSelectedOrderContent(_selectedOrder!)
                  : _buildOrderPlaceholder(orderState),
            ),
          ),
        ),

        // Expandable order list
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: _buildOrderList(orderState),
          crossFadeState: _orderPickerExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }

  Widget _buildSelectedOrderContent(OrderModel order) {
    final dateStr = DateFormat('d MMM, yyyy').format(order.createdAt);
    final (statusColor, _) = _orderStatusColor(order.status);

    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primarySurface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.receipt_long_rounded,
              size: 20, color: AppColors.primary),
        ),
        const SizedBox(width: AppDimens.sm + 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    order.orderId,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: AppDimens.sm),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(AppDimens.radiusFull),
                    ),
                    child: Text(
                      order.displayStatus,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                '$dateStr  •  ${order.displayTotal}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
        // Clear + expand toggle
        GestureDetector(
          onTap: () => setState(() {
            _selectedOrder = null;
            _orderPickerExpanded = false;
          }),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.error.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.close_rounded,
                size: 14, color: AppColors.error),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderPlaceholder(OrderListState state) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.surfaceBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.receipt_long_outlined,
              size: 20, color: AppColors.textHint),
        ),
        const SizedBox(width: AppDimens.sm + 4),
        Expanded(
          child: Text(
            state.isLoading
                ? 'Loading orders...'
                : state.orders.isEmpty
                    ? 'No orders found'
                    : 'Tap to select an order',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textHint,
            ),
          ),
        ),
        if (state.orders.isNotEmpty)
          AnimatedRotation(
            turns: _orderPickerExpanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.keyboard_arrow_down_rounded,
                color: AppColors.textHint, size: 22),
          ),
      ],
    );
  }

  /// Dropdown list of past orders
  Widget _buildOrderList(OrderListState state) {
    if (state.orders.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: AppDimens.xs),
      constraints: const BoxConstraints(maxHeight: 260),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowMedium,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: state.orders.length,
          separatorBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
            child: Container(height: 0.5, color: AppColors.divider),
          ),
          itemBuilder: (context, index) {
            final order = state.orders[index];
            final isSelected = _selectedOrder?.id == order.id;
            return _OrderPickerItem(
              order: order,
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedOrder = order;
                  _orderPickerExpanded = false;
                });
              },
            );
          },
        ),
      ),
    );
  }

  (Color, Color) _orderStatusColor(String status) {
    return switch (status) {
      'pending' => (AppColors.statusPending, AppColors.statusPending.withOpacity(0.1)),
      'confirmed' => (AppColors.statusConfirmed, AppColors.statusConfirmed.withOpacity(0.1)),
      'dispatched' => (AppColors.statusDispatched, AppColors.statusDispatched.withOpacity(0.1)),
      'delivered' => (AppColors.statusDelivered, AppColors.statusDelivered.withOpacity(0.1)),
      'cancelled' => (AppColors.statusCancelled, AppColors.statusCancelled.withOpacity(0.1)),
      _ => (AppColors.textSecondary, AppColors.surfaceBg),
    };
  }
}

/// Individual order item in the picker dropdown
class _OrderPickerItem extends StatelessWidget {
  final OrderModel order;
  final bool isSelected;
  final VoidCallback onTap;

  const _OrderPickerItem({
    required this.order,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('d MMM, yyyy').format(order.createdAt);
    final (statusColor, _) = _statusColor(order.status);

    return Material(
      color: isSelected
          ? AppColors.primarySurface.withOpacity(0.3)
          : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.md,
            vertical: 12,
          ),
          child: Row(
            children: [
              // Order info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          order.orderId,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                isSelected ? FontWeight.w700 : FontWeight.w600,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: AppDimens.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(AppDimens.radiusFull),
                          ),
                          child: Text(
                            order.displayStatus,
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$dateStr  •  ${order.displayTotal}  •  ${order.productsCount} items',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              // Selected check
              if (isSelected)
                const Icon(Icons.check_circle_rounded,
                    size: 20, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }

  (Color, Color) _statusColor(String status) {
    return switch (status) {
      'pending' => (AppColors.statusPending, AppColors.statusPending.withOpacity(0.1)),
      'confirmed' => (AppColors.statusConfirmed, AppColors.statusConfirmed.withOpacity(0.1)),
      'dispatched' => (AppColors.statusDispatched, AppColors.statusDispatched.withOpacity(0.1)),
      'delivered' => (AppColors.statusDelivered, AppColors.statusDelivered.withOpacity(0.1)),
      'cancelled' => (AppColors.statusCancelled, AppColors.statusCancelled.withOpacity(0.1)),
      _ => (AppColors.textSecondary, AppColors.surfaceBg),
    };
  }
}
