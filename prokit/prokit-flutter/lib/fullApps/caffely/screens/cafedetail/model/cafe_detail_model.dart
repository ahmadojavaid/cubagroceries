import '../../../utils/images.dart';

class CafeDetailModel{
  String image;
  String name;
  num price;

  CafeDetailModel({required this.image,required this.name,required this.price});
}

List<CafeDetailModel> cafeProductList () {
  List<CafeDetailModel> tempCafeProductList = [];

  tempCafeProductList.add(
    CafeDetailModel(image:  Images.img_coffeCup, name: "Classic Brew", price: 3.50)
  );
  tempCafeProductList.add(
      CafeDetailModel(image:  Images.img_coffeCup, name: "Minty Fresh Brew", price: 4.50)
  );
  tempCafeProductList.add(
      CafeDetailModel(image:  Images.img_coffeCup, name: "Sunshine Latte", price: 5.50)
  );
  tempCafeProductList.add(
      CafeDetailModel(image:  Images.img_coffeCup, name: "Blueberry Bliss", price: 5.50)
  );
  tempCafeProductList.add(
      CafeDetailModel(image:  Images.img_coffeCup, name: "Smoky Espresso", price: 4.00)
  );
  tempCafeProductList.add(
      CafeDetailModel(image:  Images.img_coffeCup, name: "Raspberry Rose", price: 4.00)
  );
  return tempCafeProductList;
}