import '../../../utils/images.dart';

class PopularMenuModel {
  String img;
  String name;
  num price;

  PopularMenuModel({required this.img, required this.name, required this.price});
}

List<PopularMenuModel> popularList() {
  List<PopularMenuModel> tempPopularList = [];

  tempPopularList.add(
    PopularMenuModel(img: Images.img_coffeCup, name: "Classic Brew", price: 3.50),
  );

  tempPopularList.add(
    PopularMenuModel(img: Images.img_coffeCup, name: "Minty Fresh Brew", price: 4.50),
  );

  tempPopularList.add(
    PopularMenuModel(img: Images.img_coffeCup, name: "Sunshine Latte", price: 5.20),
  );

  tempPopularList.add(
    PopularMenuModel(img: Images.img_coffeCup, name: "Raspberry Rose Latte", price: 3.00),
  );

  tempPopularList.add(
    PopularMenuModel(img:Images.img_coffeCup, name: "Smoky Espresso", price: 8.50),
  );

  tempPopularList.add(
    PopularMenuModel(img: Images.img_coffeCup, name: "Blueberry Bliss", price: 5.50),
  );

  tempPopularList.add(
    PopularMenuModel(img:Images.img_coffeCup, name: "Raspberry Rose Latte", price: 1.50),
  );

  tempPopularList.add(
    PopularMenuModel(img:Images.img_coffeCup, name: "Blueberry Bliss", price: 3.00),
  );

  tempPopularList.add(
    PopularMenuModel(img: Images.img_coffeCup, name: "Sunshine Latte", price: 2.50),
  );

  tempPopularList.add(
    PopularMenuModel(img: Images.img_coffeCup, name: "Smoky Espresso", price: 4.50),
  );

  return tempPopularList;
}
