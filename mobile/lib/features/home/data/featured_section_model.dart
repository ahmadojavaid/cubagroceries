import '../../../core/api/image_url_helper.dart';
import '../../products/data/product_model.dart';

/// A featured category section with its products for the home screen
class FeaturedSection {
  final FeaturedCategory category;
  final List<ProductModel> products;

  const FeaturedSection({
    required this.category,
    required this.products,
  });

  factory FeaturedSection.fromJson(Map<String, dynamic> json) {
    return FeaturedSection(
      category: FeaturedCategory.fromJson(
          Map<String, dynamic>.from(json['category'])),
      products: (json['products'] as List)
          .map((p) => ProductModel.fromJson(Map<String, dynamic>.from(p)))
          .toList(),
    );
  }
}

/// Lightweight category ref in featured sections
class FeaturedCategory {
  final int id;
  final String title;
  final String? image;

  const FeaturedCategory({
    required this.id,
    required this.title,
    this.image,
  });

  factory FeaturedCategory.fromJson(Map<String, dynamic> json) {
    return FeaturedCategory(
      id: json['id'] as int,
      title: json['title'] ?? '',
      image: ImageUrlHelper.rewrite(json['image'] as String?),
    );
  }
}
