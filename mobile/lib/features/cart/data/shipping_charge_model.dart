/// Shipping charge model matching API response from GET /api/v1/shipping-charges
class ShippingChargeModel {
  final int id;
  final String title;
  final String amount;

  const ShippingChargeModel({
    required this.id,
    required this.title,
    required this.amount,
  });

  factory ShippingChargeModel.fromJson(Map<String, dynamic> json) {
    return ShippingChargeModel(
      id: json['id'],
      title: json['title'] ?? '',
      amount: json['amount']?.toString() ?? '0.00',
    );
  }

  /// Parsed numeric amount
  double get amountValue => double.tryParse(amount) ?? 0.0;

  /// Formatted display: "Rs 150.00"
  String get displayAmount => 'Rs $amount';
}
