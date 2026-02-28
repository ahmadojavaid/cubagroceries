import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';

/// Model for a rider's assigned order (list item)
class RiderOrder {
  final int id;
  final String orderId;
  final String status;
  final String totalAmount;
  final String createdAt;
  final RiderOrderAddress? address;
  final RiderOrderCustomer? customer;
  final List<RiderOrderItem> items;

  const RiderOrder({
    required this.id,
    required this.orderId,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    this.address,
    this.customer,
    this.items = const [],
  });

  factory RiderOrder.fromJson(Map<String, dynamic> json) {
    return RiderOrder(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      orderId: json['order_id'] as String,
      status: json['status']?.toString() ?? 'pending',
      totalAmount: json['total_amount']?.toString() ?? '0.00',
      createdAt: json['created_at'] as String? ?? '',
      address: json['address'] != null
          ? RiderOrderAddress.fromJson(Map<String, dynamic>.from(json['address']))
          : null,
      customer: json['user'] != null
          ? RiderOrderCustomer.fromJson(Map<String, dynamic>.from(json['user']))
          : null,
      items: (json['products'] as List<dynamic>?)
              ?.map((e) => RiderOrderItem.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
    );
  }

  String get statusLabel {
    switch (status) {
      case 'pending':
        return 'Pending';
      case 'confirmed':
        return 'Confirmed';
      case 'dispatched':
        return 'Dispatched';
      case 'delivered':
        return 'Delivered';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }
}

class RiderOrderAddress {
  final String address;
  final String? city;
  final String? phone;
  final double? latitude;
  final double? longitude;

  const RiderOrderAddress({
    required this.address,
    this.city,
    this.phone,
    this.latitude,
    this.longitude,
  });

  factory RiderOrderAddress.fromJson(Map<String, dynamic> json) {
    return RiderOrderAddress(
      address: json['address'] as String? ?? '',
      city: json['city'] as String?,
      phone: json['phone'] as String?,
      latitude: json['latitude'] != null ? double.tryParse(json['latitude'].toString()) : null,
      longitude: json['longitude'] != null ? double.tryParse(json['longitude'].toString()) : null,
    );
  }

  bool get hasCoordinates => latitude != null && longitude != null;

  String get shortAddress {
    if (city != null && city!.isNotEmpty) {
      final firstLine = address.split('\n').first;
      return firstLine.length > 40
          ? '${firstLine.substring(0, 40)}…, $city'
          : '$firstLine, $city';
    }
    return address.split('\n').first;
  }
}

class RiderOrderCustomer {
  final int id;
  final String firstname;
  final String lastname;
  final String? identity; // phone number

  const RiderOrderCustomer({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.identity,
  });

  factory RiderOrderCustomer.fromJson(Map<String, dynamic> json) {
    return RiderOrderCustomer(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      firstname: json['firstname'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      identity: json['identity'] as String?,
    );
  }

  String get fullName => '$firstname $lastname'.trim();
}

class RiderOrderItem {
  final String productName;
  final String unitName;
  final int quantity;
  final String price;

  const RiderOrderItem({
    required this.productName,
    required this.unitName,
    required this.quantity,
    required this.price,
  });

  factory RiderOrderItem.fromJson(Map<String, dynamic> json) {
    final product = json['product'] != null ? Map<String, dynamic>.from(json['product']) : null;
    final unit = json['unit'] != null ? Map<String, dynamic>.from(json['unit']) : null;
    return RiderOrderItem(
      productName: product?['name'] as String? ?? '',
      unitName: unit?['name'] as String? ?? '',
      quantity: json['quantity'] is int ? json['quantity'] : int.tryParse(json['quantity'].toString()) ?? 0,
      price: json['price']?.toString() ?? '0.00',
    );
  }
}

// ─── State ──────────────────────────────────────────────────

class RiderOrdersState {
  final List<RiderOrder> orders;
  final bool isLoading;
  final bool isRefreshing;
  final String? error;

  const RiderOrdersState({
    this.orders = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.error,
  });

  RiderOrdersState copyWith({
    List<RiderOrder>? orders,
    bool? isLoading,
    bool? isRefreshing,
    String? error,
  }) {
    return RiderOrdersState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      error: error,
    );
  }
}

// ─── Notifier ───────────────────────────────────────────────

class RiderOrdersNotifier extends StateNotifier<RiderOrdersState> {
  final ApiClient _api;

  RiderOrdersNotifier(this._api) : super(const RiderOrdersState()) {
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.get('/rider/orders');
      final data = response.data;
      if (data['success'] == true) {
        final list = (data['data'] as List<dynamic>)
            .map((e) => RiderOrder.fromJson(e as Map<String, dynamic>))
            .where((o) => o.status != 'pending') // Riders can't act on pending orders
            .toList();
        state = RiderOrdersState(orders: list);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load orders',
        );
      }
    } catch (e) {
      String msg = 'Could not load orders. Pull to refresh.';
      try {
        if (e is DioException) {
          final apiErr = e.error;
          if (apiErr is ApiException) {
            msg = apiErr.message;
          } else {
            msg = 'Dio: ${e.type.name} — ${e.message ?? e.error}';
          }
        } else {
          msg = 'Error: ${e.runtimeType}: $e';
        }
      } catch (_) {}
      state = state.copyWith(
        isLoading: false,
        error: msg,
      );
    }
  }

  /// Update an order's status (dispatched or delivered)
  Future<bool> updateStatus(String orderNumber, String newStatus) async {
    try {
      final response = await _api.put(
        '/rider/orders/$orderNumber/status',
        data: {'status': newStatus},
      );
      final data = response.data;
      if (data['success'] == true) {
        // Update local state
        final updated = state.orders.map((o) {
          if (o.orderId == orderNumber) {
            return RiderOrder(
              id: o.id,
              orderId: o.orderId,
              status: newStatus,
              totalAmount: o.totalAmount,
              createdAt: o.createdAt,
              address: o.address,
              customer: o.customer,
              items: o.items,
            );
          }
          return o;
        }).toList();
        state = state.copyWith(orders: updated);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    try {
      final response = await _api.get('/rider/orders');
      final data = response.data;
      if (data['success'] == true) {
        final list = (data['data'] as List<dynamic>)
            .map((e) => RiderOrder.fromJson(e as Map<String, dynamic>))
            .where((o) => o.status != 'pending')
            .toList();
        state = RiderOrdersState(orders: list);
      }
    } catch (_) {}
    state = state.copyWith(isRefreshing: false);
  }
}

// ─── Providers ──────────────────────────────────────────────

final riderOrdersProvider =
    StateNotifierProvider<RiderOrdersNotifier, RiderOrdersState>((ref) {
  final api = ref.watch(apiClientProvider);
  return RiderOrdersNotifier(api);
});

/// Family provider for fetching a single order detail by order number.
final riderOrderDetailProvider =
    FutureProvider.family<RiderOrder?, String>((ref, orderNumber) async {
  final api = ref.watch(apiClientProvider);
  try {
    final response = await _fetchOrderDetail(api, orderNumber);
    return response;
  } catch (_) {
    return null;
  }
});

Future<RiderOrder?> _fetchOrderDetail(
    ApiClient api, String orderNumber) async {
  final response = await api.get('/rider/orders/$orderNumber');
  final data = response.data;
  if (data['success'] == true) {
    return RiderOrder.fromJson(data['data'] as Map<String, dynamic>);
  }
  return null;
}
