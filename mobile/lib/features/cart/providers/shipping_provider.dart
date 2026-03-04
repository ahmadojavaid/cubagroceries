import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/api_provider.dart';
import '../data/shipping_charge_model.dart';

/// State for shipping charges
class ShippingState {
  final List<ShippingChargeModel> charges;
  final bool isLoading;
  final String? error;

  const ShippingState({
    this.charges = const [],
    this.isLoading = false,
    this.error,
  });

  ShippingState copyWith({
    List<ShippingChargeModel>? charges,
    bool? isLoading,
    String? error,
  }) {
    return ShippingState(
      charges: charges ?? this.charges,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Shipping notifier — fetches available shipping options
class ShippingNotifier extends StateNotifier<ShippingState> {
  final ApiClient _api;

  ShippingNotifier(this._api) : super(const ShippingState());

  /// Fetch all shipping charges
  Future<void> fetchCharges({bool forceRefresh = false}) async {
    if (state.charges.isNotEmpty && !forceRefresh) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/shipping-charges');
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((c) =>
                ShippingChargeModel.fromJson(Map<String, dynamic>.from(c)))
            .toList();

        state = ShippingState(charges: list);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load shipping options',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load shipping options. Please try again.',
      );
    }
  }
}

/// Shipping provider
final shippingProvider =
    StateNotifierProvider<ShippingNotifier, ShippingState>((ref) {
  final api = ref.watch(apiClientProvider);
  return ShippingNotifier(api);
});

/// Free delivery threshold — derived from the free (amount=0) shipping option's min_order_amount.
/// Returns null if no free delivery option exists.
final freeDeliveryThresholdProvider = Provider<double?>((ref) {
  final charges = ref.watch(shippingProvider).charges;
  final freeOption = charges.where((c) => c.amountValue == 0).firstOrNull;
  return freeOption?.minOrderAmount;
});

/// The free delivery shipping charge model (if any)
final freeDeliveryOptionProvider = Provider<ShippingChargeModel?>((ref) {
  final charges = ref.watch(shippingProvider).charges;
  return charges.where((c) => c.amountValue == 0).firstOrNull;
});
