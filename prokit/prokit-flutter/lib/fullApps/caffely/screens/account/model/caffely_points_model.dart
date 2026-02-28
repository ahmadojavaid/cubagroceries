class PointListsModel {
  String name;
  String price;
  String date;

  PointListsModel( {required this.name,required this.price,required this.date});
}


List<PointListsModel> pointLists() {


  List<PointListsModel> tempPointList = [];

  tempPointList.add(
    PointListsModel(name: "You earn points", price: '+25', date: 'Dec 22,2023 . 09:41:45 AM')
  );
  tempPointList.add(
    PointListsModel(name: 'You use points', price: '-200', date: 'Dec 22,2023 . 09:41:20 AM')
  );
  tempPointList.add(
      PointListsModel(name:  'You earn points', price: '+50', date:'Dec 19,2023 . 19:20:49 PM')
  );
  tempPointList.add(
      PointListsModel(name: 'You earn points', price: '+100', date: 'Dec 18,2023 . 20:46:53 PM')
  );
  tempPointList.add(
      PointListsModel(name: 'You earn points', price: '+50', date: 'Dec 17,2023 . 10:07:38 AM')
  ); tempPointList.add(
      PointListsModel(name: 'You use points', price: '-100', date: 'Dec 14,2023 . 16:44:57 PM')
  ); tempPointList.add(
      PointListsModel(name: 'You earn points', price: '+25', date: 'Dec 13,2023 . 09:41:45 AM')
  );

  return tempPointList;

}


