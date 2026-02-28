import '../utils/images.dart';

class SelectCategory {
  String? image;
  String? name;

  SelectCategory({this.image, this.name});
}

List<SelectCategory> getRomanceList() {
  List<SelectCategory> tempBranchList = [];

  tempBranchList.add(
    SelectCategory(
      image: catMovie1,
      name: "Romance ",
    ),
  );
  tempBranchList.add(
    SelectCategory(
      image: catMovie2,
      name: " Comedy",
    ),
  );

  tempBranchList.add(
    SelectCategory(
      image: catMovie3,
      name: "Horror",
    ),
  );

  tempBranchList.add(
    SelectCategory(
      image: catMovie2,
      name: "Drama",
    ),
  );

  tempBranchList.add(
    SelectCategory(
      image: catMovie3,
      name: "Western",
    ),
  );
  tempBranchList.add(
    SelectCategory(
      image: catMovie1,
      name: "Action",
    ),
  );
  tempBranchList.add(
    SelectCategory(
      image: catMovie2,
      name: "Crime film",
    ),
  );
  tempBranchList.add(
    SelectCategory(
      image: catMovie3,
      name: "Thriller",
    ),
  );
  tempBranchList.add(
    SelectCategory(
      image: catMovie1,
      name: "Documentary",
    ),
  );
  tempBranchList.add(
    SelectCategory(
      image: catMovie3,
      name: "Action",
    ),
  );

  return tempBranchList;
}
