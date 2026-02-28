
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';

class CategoryModel {
  String image;
  String title;

  CategoryModel({required this.image, required this.title});
}

List<CategoryModel> categoryList = [
  CategoryModel(image: kiviLabAppImages.category1, title: 'CT Scan'),
  CategoryModel(image: kiviLabAppImages.category2, title: 'Blood Tests'),
  CategoryModel(image: kiviLabAppImages.category3, title: 'urinalysis'),
  CategoryModel(image: kiviLabAppImages.category1, title: 'CT Scan'),
  CategoryModel(image: kiviLabAppImages.category2, title: 'Blood Tests'),
  CategoryModel(image: kiviLabAppImages.category3, title: 'urinalysis'),
];
