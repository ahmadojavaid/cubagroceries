import '../../../utils/images.dart';

class ChooseDeliveryModel{
  String name;
  num price;
  String image;

  ChooseDeliveryModel({required this.name,required this.price,required this.image});
}

List<ChooseDeliveryModel> chooseDeliveryList (){
  List<ChooseDeliveryModel> tempChooseDeliveryList = [];

  tempChooseDeliveryList.add(
    ChooseDeliveryModel(name:  "DoorDash Drive", price:  5.99, image: Images.img_doordas)
  );
  tempChooseDeliveryList.add(
      ChooseDeliveryModel(name:  "Chowbus", price:  4.99, image: Images.img_chwbus)
  );
  tempChooseDeliveryList.add(
      ChooseDeliveryModel(name:  "Rapidas", price:  6.99,image:Images.img_rapido)
  );
  tempChooseDeliveryList.add(
      ChooseDeliveryModel(name:  "Roadie", price:  7.99, image:Images.img_roadie)
  );
  tempChooseDeliveryList.add(
      ChooseDeliveryModel(name:  "Zifty",price: 3.99, image:Images.img_zifty,)
  );
  tempChooseDeliveryList.add(
      ChooseDeliveryModel(name:  "Caviar", price:  8.99,image:Images.img_caviar)
  );
  return tempChooseDeliveryList;

}