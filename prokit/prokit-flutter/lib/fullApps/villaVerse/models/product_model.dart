import '../utils/image.dart';

class ProductModel {
  String imagePath;
  String titleText;
  String address;
  String price;
  String rating;
  bool isFavorite;

  ProductModel({
    required this.imagePath,
    required this.titleText,
    required this.address,
    required this.price,
    required this.rating,
    this.isFavorite = false,
  });
}

List<ProductModel> getFeaturedList() {
  List<ProductModel> propertys = [];

  propertys.add(
    ProductModel(
      imagePath: welcomeImage1,
      titleText: "Modernica Apartment",
      address: "New York,US",
      price: "\$30/ night",
      rating: '4.7',
    ),
  );
  propertys.add(
    ProductModel(
      imagePath: welcomeImage2,
      titleText: "Lucky Lake, Farm Home",
      address: "New York,US",
      price: "\$45/ night",
      rating: '3.7',
    ),
  );
  propertys.add(
    ProductModel(
      imagePath: welcomeImage3,
      titleText: "Tranquil Tavern, Apartment",
      address: "New York,US",
      price: "\$25/ night",
      rating: '4.5',
    ),
  );
  propertys.add(
    ProductModel(
      imagePath: interior3,
      titleText: "Modernica Apartment",
      address: "New York,US",
      price: "\$25/ night",
      rating: '4.3',
    ),
  );
  propertys.add(
    ProductModel(
      imagePath: interior1,
      titleText: "Lucky Lake, Farm Hom",
      address: "New Delhi,India",
      price: "\$25/ night",
      rating: '4.4',
    ),
  );
  propertys.add(
    ProductModel(
      imagePath: interior2,
      titleText: "Tranquil Tavern, Apartment",
      address: "Mumbai,India",
      price: "\$25/ night",
      rating: '4.4',
    ),
  );
  propertys.add(
    ProductModel(
      imagePath: interior5,
      titleText: "Modernica Apartment",
      address: "Jaipur,India",
      price: "\$25/ night",
      rating: '4.1',
    ),
  );

  return propertys;
}

List<ProductModel> getFavoriteProductList() {
  List<ProductModel> products = [];
  products.add(
    ProductModel(
      imagePath: welcomeImage1,
      titleText: "Modernica Apartment",
      address: "New York,US",
      price: "\$30/ night",
      rating: '4.7',
      isFavorite: true,
    ),
  );
  products.add(
    ProductModel(
      imagePath: welcomeImage2,
      titleText: "Lucky Lake, Farm Hom",
      address: "New York,US",
      price: "\$45/ night",
      rating: '3.7',
      isFavorite: true,
    ),
  );
  products.add(
    ProductModel(
      imagePath: welcomeImage3,
      titleText: "Tranquil Tavern, Apartment",
      address: "New York,US",
      price: "\$25/ night",
      rating: '4.5',
      isFavorite: true,
    ),
  );

  return products;
}
