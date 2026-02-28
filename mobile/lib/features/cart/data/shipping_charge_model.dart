/// Shipping charge model matching API response from GET /api/v1/shipping-charges
class ShippingChargeModel {
  final int id;
  final String title;
  final String amount;
  final double? minOrderAmount;

  const ShippingChargeModel({
    required this.id,
    required this.title,
    required this.amount,
    this.minOrderAmount,
  });

  factory ShippingChargeModel.fromJson(Map<String, dynamic> json) {
    return ShippingChargeModel(
      id: json['id'],
      title: json['title'] ?? '',
      amount: json['amount']?.toString() ?? '0.00',
      minOrderAmount: json['min_order_amount'] != null
          ? double.tryParse(json['min_order_amount'].toString())
          : null,
    );
  }

  /// Parsed numeric amount
  double get amountValue => double.tryParse(amount) ?? 0.0;

  /// Whether this option is available for a given subtotal
  bool isAvailableFor(double subtotal) =>
      minOrderAmount == null || subtotal >= minOrderAmount!;

  /// Formatted display: "Rs 150.00" or "FREE"
  String get displayAmount =>
      amountValue == 0 ? 'FREE' : 'Rs $amount';
}
