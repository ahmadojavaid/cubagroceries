import '../../../utils/images.dart';

class NearbyShopListModel{
  String image;
  String text;
  String text2;
  String rating;

  NearbyShopListModel({required this.image, required this.text,required this.text2,required this.rating});
}

List<NearbyShopListModel> nearbyShopList (){
  List<NearbyShopListModel> tempNearbyShopList  = [];
  
  tempNearbyShopList.add(
    NearbyShopListModel(image: Images.img_cafe11, text: "Caffely Astroia Aromas", text2: "1.2km", rating: "4")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe2, text: "Caffely West Village Wake-up", text2: "4.2", rating: "4.2")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe3, text:"Caffely East Expresso", text2: "1.5km", rating: "4.3")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe4, text: "Caffely Manhattan Morning", text2: "2.0km", rating: "4.0")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe5, text: "Caffely Upper East Expresso", text2: "2.0km", rating: "4.4")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe6, text: "Caffely Manhattan Morning", text2: "1.2km", rating: "4")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe7, text: "Caffely Wall Street", text2: "3.2km", rating: "4.2")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe8, text: "Caffely Astroia Aromas", text2: "1.2km", rating: "4")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe9, text: "Caffely Manhattan Morning", text2: "1.2km", rating: "4.0")
  );
  tempNearbyShopList.add(
      NearbyShopListModel(image: Images.img_cafe10, text: "Caffely Manhattan Morning", text2: "1.2km", rating: "4.0")
 );
  return tempNearbyShopList;
}