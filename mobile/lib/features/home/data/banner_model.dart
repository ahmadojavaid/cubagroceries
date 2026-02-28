/// Banner model matching API response
class BannerModel {
  final int id;
  final String? title;
  final String? image;

  const BannerModel({
    required this.id,
    this.title,
    this.image,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] as int,
      title: json['title'] as String?,
      image: json['image'] as String?,
    );
  }
}
