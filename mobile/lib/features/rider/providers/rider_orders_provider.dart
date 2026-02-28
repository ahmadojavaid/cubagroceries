import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/api/api_client.dart';

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
      id: json['id'] as int,
      orderId: json['order_id'] as String,
      status: json['status'] as String? ?? 'pending',
      totalAmount: json['total_amount']?.toString() ?? '0.00',
      createdAt: json['created_at'] as String? ?? '',
      address: json['address'] != null
          ? RiderOrderAddress.fromJson(json['address'])
          : null,
      customer: json['user'] != null
          ? RiderOrderCustomer.fromJson(json['user'])
          : null,
      items: (json['products'] as List<dynamic>?)
              ?.map((e) => RiderOrderItem.fromJson(e))
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
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
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
      id: json['id'] as int,
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
    return RiderOrderItem(
      productName:
          (json['product'] as Map<String, dynamic>?)?['name'] as String? ?? '',
      unitName:
          (json['unit'] as Map<String, dynamic>?)?['name'] as String? ?? '',
      quantity: json['quantity'] as int? ?? 0,
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
            .toList();
        state = RiderOrdersState(orders: list);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load orders',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Could not load orders. Pull to refresh.',
      );
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
