/// Order model for list view (GET /api/v1/orders)
class OrderModel {
  final int id;
  final String orderId;
  final String status;
  final String totalAmount;
  final int productsCount;
  final DateTime createdAt;

  const OrderModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.totalAmount,
    required this.productsCount,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      orderId: json['order_id'] ?? '',
      status: json['status'] ?? 'pending',
      totalAmount: json['total_amount']?.toString() ?? '0.00',
      productsCount: json['products_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  double get totalAmountValue => double.tryParse(totalAmount) ?? 0.0;

  String get displayTotal => 'Rs $totalAmount';

  String get displayStatus =>
      status[0].toUpperCase() + status.substring(1);
}

/// Full order detail model (GET /api/v1/orders/{order_number})
class OrderDetailModel {
  final int id;
  final String orderId;
  final String status;
  final String totalAmount;
  final OrderAddressModel? address;
  final List<OrderItemModel> items;
  final DateTime createdAt;

  const OrderDetailModel({
    required this.id,
    required this.orderId,
    required this.status,
    required this.totalAmount,
    this.address,
    this.items = const [],
    required this.createdAt,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      id: json['id'],
      orderId: json['order_id'] ?? '',
      status: json['status'] ?? 'pending',
      totalAmount: json['total_amount']?.toString() ?? '0.00',
      address: json['address'] != null
          ? OrderAddressModel.fromJson(
              Map<String, dynamic>.from(json['address']))
          : null,
      items: json['products'] != null
          ? (json['products'] as List)
              .map((p) =>
                  OrderItemModel.fromJson(Map<String, dynamic>.from(p)))
              .toList()
          : [],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  double get totalAmountValue => double.tryParse(totalAmount) ?? 0.0;

  String get displayTotal => 'Rs $totalAmount';

  String get displayStatus =>
      status[0].toUpperCase() + status.substring(1);
}

/// Order address snapshot
class OrderAddressModel {
  final String address;
  final String? city;
  final String? phone;

  const OrderAddressModel({
    required this.address,
    this.city,
    this.phone,
  });

  factory OrderAddressModel.fromJson(Map<String, dynamic> json) {
    return OrderAddressModel(
      address: json['address'] ?? '',
      city: json['city'] as String?,
      phone: json['phone'] as String?,
    );
  }

  /// Full address display
  String get displayFull =>
      [address, city].where((s) => s != null && s.isNotEmpty).join(', ');
}

/// Order line item
class OrderItemModel {
  final int productId;
  final String productName;
  final String unitName;
  final int quantity;
  final String price;

  const OrderItemModel({
    required this.productId,
    required this.productName,
    required this.unitName,
    required this.quantity,
    required this.price,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['product']?['id'] ?? json['product_id'] ?? 0,
      productName: json['product']?['name'] ?? 'Unknown',
      unitName: json['unit']?['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price']?.toString() ?? '0.00',
    );
  }

  double get priceValue => double.tryParse(price) ?? 0.0;

  double get lineTotal => priceValue * quantity;

  String get displayPrice => 'Rs $price';

  String get displayLineTotal => 'Rs ${lineTotal.toStringAsFixed(2)}';
}
