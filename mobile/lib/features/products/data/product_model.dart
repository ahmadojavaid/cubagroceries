import 'price_model.dart';

/// Product model matching API response from GET /api/v1/products
class ProductModel {
  final int id;
  final String name;
  final String? description;
  final int stock;
  final CategoryRef? category;
  final CategoryRef? subCategory;
  final List<PriceModel> prices;

  const ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.stock,
    this.category,
    this.subCategory,
    this.prices = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'],
      stock: json['stock'] ?? 0,
      category: json['category'] != null
          ? CategoryRef.fromJson(Map<String, dynamic>.from(json['category']))
          : null,
      subCategory: json['sub_category'] != null
          ? CategoryRef.fromJson(
              Map<String, dynamic>.from(json['sub_category']))
          : null,
      prices: json['prices'] != null
          ? (json['prices'] as List)
              .map((p) => PriceModel.fromJson(Map<String, dynamic>.from(p)))
              .toList()
          : [],
    );
  }

  /// Whether the product is in stock
  bool get inStock => stock > 0;

  /// First/cheapest price for display in lists
  PriceModel? get firstPrice => prices.isNotEmpty ? prices.first : null;
}

/// Lightweight category reference embedded in product response
class CategoryRef {
  final int id;
  final String title;

  const CategoryRef({required this.id, required this.title});

  factory CategoryRef.fromJson(Map<String, dynamic> json) {
    return CategoryRef(
      id: json['id'],
      title: json['title'] ?? '',
    );
  }
}
