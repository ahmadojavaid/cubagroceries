import '../../../core/api/image_url_helper.dart';

/// Category model matching API response from GET /api/v1/categories
class CategoryModel {
  final int id;
  final String title;
  final String? image;
  final List<CategoryModel> children;

  const CategoryModel({
    required this.id,
    required this.title,
    this.image,
    this.children = const [],
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'] ?? '',
      image: ImageUrlHelper.rewrite(json['image'] as String?),
      children: json['children'] != null
          ? (json['children'] as List)
              .map((c) => CategoryModel.fromJson(Map<String, dynamic>.from(c)))
              .toList()
          : [],
    );
  }

  /// Whether this is a top-level category (has children)
  bool get hasChildren => children.isNotEmpty;
}
