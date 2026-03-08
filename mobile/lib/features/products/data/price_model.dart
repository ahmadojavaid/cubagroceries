import 'unit_model.dart';

/// Price variant model matching API response
class PriceModel {
  final int id;
  final String price;
  final UnitModel unit;

  const PriceModel({
    required this.id,
    required this.price,
    required this.unit,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      id: json['id'],
      price: json['price']?.toString() ?? '0.00',
      unit: UnitModel.fromJson(Map<String, dynamic>.from(json['unit'])),
    );
  }

  /// Parsed numeric price
  double get priceValue => double.tryParse(price) ?? 0.0;

  /// Clean price string: strips .00 for whole numbers (250.00 → 250, 99.50 → 99.50)
  String get cleanPrice => formatRs(priceValue);

  /// Formatted display: "Rs 120 / kg"
  String get displayPrice => 'Rs ${cleanPrice} / ${unit.label}';

  /// Format a numeric price: drop .00 for whole numbers
  static String formatRs(double value) {
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(2);
  }
}
