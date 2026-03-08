/// Cart item model for local cart storage (Hive serialization)
class CartItemModel {
  final int productId;
  final String productName;
  final int unitId;
  final String unitName;
  final double price;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.productName,
    required this.unitId,
    required this.unitName,
    required this.price,
    required this.quantity,
  });

  /// Line total: price × quantity
  double get lineTotal => price * quantity;

  /// Unique key for this cart item (product + unit combination)
  String get cartKey => '${productId}_$unitId';

  /// Format a numeric price: drop .00 for whole numbers
  static String _formatRs(double value) {
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(2);
  }

  /// Formatted price display
  String get displayPrice => 'Rs ${_formatRs(price)} / $unitName';

  /// Formatted line total display
  String get displayLineTotal => 'Rs ${_formatRs(lineTotal)}';

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['product_id'] as int,
      productName: json['product_name'] as String,
      unitId: json['unit_id'] as int,
      unitName: json['unit_name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'product_name': productName,
      'unit_id': unitId,
      'unit_name': unitName,
      'price': price,
      'quantity': quantity,
    };
  }

  /// Create a copy with updated quantity
  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      productId: productId,
      productName: productName,
      unitId: unitId,
      unitName: unitName,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}
