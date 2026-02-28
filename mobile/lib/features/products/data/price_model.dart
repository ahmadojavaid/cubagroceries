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

  /// Formatted display: "Rs 120.00 / kg"
  String get displayPrice => 'Rs $price / ${unit.label}';
}
