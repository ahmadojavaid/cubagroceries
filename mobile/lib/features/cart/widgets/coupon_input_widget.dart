import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';

/// Holds applied coupon state
class CouponState {
  final String? code;
  final double discount;
  final String? description;

  const CouponState({this.code, this.discount = 0, this.description});

  CouponState copyWith({String? code, double? discount, String? description}) {
    return CouponState(
      code: code ?? this.code,
      discount: discount ?? this.discount,
      description: description ?? this.description,
    );
  }
}

class CouponNotifier extends StateNotifier<CouponState> {
  CouponNotifier() : super(const CouponState());

  void apply(String code, double discount, String? description) {
    state = CouponState(code: code, discount: discount, description: description);
  }

  void clear() {
    state = const CouponState();
  }
}

final couponProvider =
    StateNotifierProvider<CouponNotifier, CouponState>((ref) {
  return CouponNotifier();
});

/// Coupon input widget for checkout
class CouponInputWidget extends ConsumerStatefulWidget {
  final double orderTotal;

  const CouponInputWidget({super.key, required this.orderTotal});

  @override
  ConsumerState<CouponInputWidget> createState() => _CouponInputWidgetState();
}

class _CouponInputWidgetState extends ConsumerState<CouponInputWidget> {
  final _controller = TextEditingController();
  bool _isApplying = false;
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _applyCoupon() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _isApplying = true;
      _errorMessage = null;
    });

    try {
      final api = ref.read(apiClientProvider);
      final response = await api.post('/coupons/apply', data: {
        'code': code,
        'order_total': widget.orderTotal,
      });

      if (!mounted) return;

      final data = response.data;
      if (data['success'] == true) {
        final couponData = data['data'];
        ref.read(couponProvider.notifier).apply(
              couponData['code'],
              (couponData['discount'] as num).toDouble(),
              couponData['description'],
            );
        setState(() => _isApplying = false);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isApplying = false;
        // Try to extract error message from API response
        try {
          final dioErr = e as dynamic;
          _errorMessage = dioErr.response?.data?['message'] ?? 'Invalid coupon';
        } catch (_) {
          _errorMessage = 'Failed to apply coupon';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final coupon = ref.watch(couponProvider);

    if (coupon.code != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.success.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppDimens.radiusSm),
          border: Border.all(color: AppColors.success.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coupon ${coupon.code} applied',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: AppColors.success,
                    ),
                  ),
                  Text(
                    'You save Rs ${coupon.discount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.success.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () => ref.read(couponProvider.notifier).clear(),
              icon: const Icon(Icons.close, size: 18),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: 'Enter coupon code',
                  prefixIcon: const Icon(Icons.local_offer_outlined, size: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radiusSm),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  isDense: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _isApplying ? null : _applyCoupon,
              child: _isApplying
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Apply'),
            ),
          ],
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            _errorMessage!,
            style: const TextStyle(color: AppColors.error, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
