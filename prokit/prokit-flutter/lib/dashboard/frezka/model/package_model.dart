import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';

class OfferModel {
  final String title;
  final String price;
  final bool isHighlighted;

  OfferModel({
    required this.title,
    required this.price,
    this.isHighlighted = false,
  });
}

List<OfferModel> offerList = [
  OfferModel(
    title: 'Radiant Winter Beauty',
    price: '\$1550',
    isHighlighted: true,
  ),
  OfferModel(title: 'Seasonal Serenity', price: '\$1550'),
  OfferModel(title: 'Summer Glow Kit', price: '\$999'),
  OfferModel(title: 'Monsoon Escape', price: '\$1299'),
];

class CategoryModel {
  final String title;
  final String imagePath;

  CategoryModel({required this.title, required this.imagePath});
}

List<CategoryModel> categoryList = [
  CategoryModel(title: "Hair Styling", imagePath: frezkaAppImages.category1),
  CategoryModel(title: "Massage", imagePath: frezkaAppImages.category2),
  CategoryModel(title: "Makeup", imagePath: frezkaAppImages.category3),
  CategoryModel(title: "Nails", imagePath: frezkaAppImages.category4),
  CategoryModel(title: "Bride", imagePath: frezkaAppImages.category5),
  CategoryModel(title: "Spa", imagePath: frezkaAppImages.category6),
];

class ExpertsModel {
  final String name;
  final String imagePath;
  final String proffession;
  final String rating;

  ExpertsModel({
    required this.name,
    required this.imagePath,
    required this.proffession,
    required this.rating,
  });
}

List<ExpertsModel> experts = [
  ExpertsModel(
    name: "Heloise Corkery",
    imagePath: frezkaAppImages.expert1,
    proffession: "Makeup Expert",
    rating: "4.3",
  ),
  ExpertsModel(
    name: "Mrs. Norene Bode",
    imagePath: frezkaAppImages.expert2,
    proffession: "Bride Special",
    rating: "4.3",
  ),
  ExpertsModel(
    name: "Jennifer Towne",
    imagePath: frezkaAppImages.expert3,
    proffession: "Makeup Expert",
    rating: "4.0",
  ),
  ExpertsModel(
    name: "Darion Stamm",
    imagePath: frezkaAppImages.expert4,
    proffession: "Nail Special",
    rating: "4.5",
  ),
];

List<CategoryModel> nailList = [
  CategoryModel(title: "Manicure", imagePath: frezkaAppImages.nail1),
  CategoryModel(title: "Nail Art", imagePath: frezkaAppImages.nail2),
  CategoryModel(title: "Gel Polish", imagePath: frezkaAppImages.nail3),
];

List<CategoryModel> makupList = [
  CategoryModel(title: "3D", imagePath: frezkaAppImages.makup1),
  CategoryModel(title: "Matte", imagePath: frezkaAppImages.makup2),
  CategoryModel(title: "Minimal", imagePath: frezkaAppImages.makup3),
];

class NearByShopsModel {
  String image;
  String address;
  String distance;
  String rating;
  String shopName;

  NearByShopsModel({
    required this.image,
    required this.shopName,
    required this.address,
    required this.distance,
    required this.rating,
  });
}

List<NearByShopsModel> nearShopList = [
  NearByShopsModel(
    image: frezkaAppImages.salon1,
    shopName: "Under the Dryer Salon",
    address: "1138 E High St.Charlottes villa vermont, 22902",
    distance: "5.2 miles from your location",
    rating: "4.3",
  ),
  NearByShopsModel(
    image: frezkaAppImages.salon2,
    shopName: "Under the Dryer Salon",
    address: "1138 E High St.Charlottes villa vermont, 22902",
    distance: "5.2 miles from your location",
    rating: "4.3",
  ),
  NearByShopsModel(
    image: frezkaAppImages.salon3,
    shopName: "Under the Dryer Salon",
    address: "1138 E High St.Charlottes villa vermont, 22902",
    distance: "5.2 miles from your location",
    rating: "4.3",
  ),
];
