import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../../core/providers/api_provider.dart';
import '../data/order_model.dart';

/// State for order history list
class OrderListState {
  final List<OrderModel> orders;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final int lastPage;

  const OrderListState({
    this.orders = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.lastPage = 1,
  });

  bool get hasMore => currentPage < lastPage;

  OrderListState copyWith({
    List<OrderModel>? orders,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    int? lastPage,
  }) {
    return OrderListState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}

/// State for placing an order
class PlaceOrderState {
  final bool isLoading;
  final String? error;
  final OrderDetailModel? placedOrder;

  const PlaceOrderState({
    this.isLoading = false,
    this.error,
    this.placedOrder,
  });

  PlaceOrderState copyWith({
    bool? isLoading,
    String? error,
    OrderDetailModel? placedOrder,
  }) {
    return PlaceOrderState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      placedOrder: placedOrder ?? this.placedOrder,
    );
  }
}

/// Order list notifier — fetches paginated order history
class OrderListNotifier extends StateNotifier<OrderListState> {
  final ApiClient _api;

  OrderListNotifier(this._api) : super(const OrderListState());

  /// Fetch first page of orders
  Future<void> fetchOrders({bool forceRefresh = false}) async {
    if (state.isLoading) return;
    if (state.orders.isNotEmpty && !forceRefresh) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/orders', queryParameters: {
        'page': 1,
        'per_page': 20,
      });
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((o) => OrderModel.fromJson(Map<String, dynamic>.from(o)))
            .toList();

        state = OrderListState(
          orders: list,
          currentPage: data['meta']?['current_page'] ?? 1,
          lastPage: data['meta']?['last_page'] ?? 1,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load orders',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load orders. Please try again.',
      );
    }
  }

  /// Load next page
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final response = await _api.get('/orders', queryParameters: {
        'page': nextPage,
        'per_page': 20,
      });
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((o) => OrderModel.fromJson(Map<String, dynamic>.from(o)))
            .toList();

        state = state.copyWith(
          orders: [...state.orders, ...list],
          isLoadingMore: false,
          currentPage: data['meta']?['current_page'] ?? nextPage,
          lastPage: data['meta']?['last_page'] ?? state.lastPage,
        );
      } else {
        state = state.copyWith(isLoadingMore: false);
      }
    } catch (_) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Order detail notifier — fetches single order + places orders
class OrderActionNotifier extends StateNotifier<PlaceOrderState> {
  final ApiClient _api;

  OrderActionNotifier(this._api) : super(const PlaceOrderState());

  /// Place a new order
  Future<OrderDetailModel?> placeOrder({
    required int addressId,
    required List<Map<String, dynamic>> items,
    int? shippingChargeId,
    String? couponCode,
    bool useWallet = false,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.post('/orders', data: {
        'address_id': addressId,
        'items': items,
        if (shippingChargeId != null) 'shipping_charge_id': shippingChargeId,
        if (couponCode != null) 'coupon_code': couponCode,
        'use_wallet': useWallet,
      });
      final data = response.data;

      if (data['success'] == true) {
        final order = OrderDetailModel.fromJson(
            Map<String, dynamic>.from(data['data']));
        state = PlaceOrderState(placedOrder: order);
        return order;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to place order',
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractError(e),
      );
      return null;
    }
  }

  /// Fetch a single order detail
  Future<OrderDetailModel?> fetchOrderDetail(String orderNumber) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/orders/$orderNumber');
      final data = response.data;

      if (data['success'] == true) {
        final order = OrderDetailModel.fromJson(
            Map<String, dynamic>.from(data['data']));
        state = PlaceOrderState(placedOrder: order);
        return order;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Order not found',
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractError(e),
      );
      return null;
    }
  }

  /// Cancel a pending order
  Future<bool> cancelOrder(String orderNumber) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.put('/orders/$orderNumber/cancel');
      final data = response.data;

      if (data['success'] == true) {
        // Re-fetch the order detail to get updated status
        await fetchOrderDetail(orderNumber);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to cancel order',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractError(e),
      );
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const PlaceOrderState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  String _extractError(dynamic e) {
    if (e is Exception) {
      final dioError = e as dynamic;
      if (dioError.error is ApiException) {
        return (dioError.error as ApiException).firstError;
      }
    }
    return 'Something went wrong. Please try again.';
  }
}

/// Order list provider
final orderListProvider =
    StateNotifierProvider<OrderListNotifier, OrderListState>((ref) {
  final api = ref.watch(apiClientProvider);
  return OrderListNotifier(api);
});

/// Order action provider (place order + fetch detail)
final orderActionProvider =
    StateNotifierProvider<OrderActionNotifier, PlaceOrderState>((ref) {
  final api = ref.watch(apiClientProvider);
  return OrderActionNotifier(api);
});
