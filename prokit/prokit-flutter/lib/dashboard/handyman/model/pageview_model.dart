import 'package:prokit_flutter/dashboard/handyman/screens/home_screen.dart';

class PageviewModel {
  String imagePath;
  String text1;
  String text2;
  String text3;
  String text4;

  PageviewModel({
    required this.imagePath,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
  });
}

List<PageviewModel> bannerList = [
  PageviewModel(
    imagePath: handymanAppImages.service1,
    text1: "Get 15% OFF on your first booking",
    text2: "Use code:",
    text3: "First5",
    text4: "Expires on May 30th, 2024",
  ),
  PageviewModel(
    imagePath: handymanAppImages.service2,
    text1: "text1",
    text2: "Use code:",
    text3: "text3",
    text4: "Expires on May 30th, 2024",
  ),
  PageviewModel(
    imagePath: handymanAppImages.service3,
    text1: "text1",
    text2: "text2",
    text3: "text3",
    text4: "Expires on May 30th, 2024",
  ),
];

final List<Map<String, dynamic>> serviceCards = [
  {
    'tag': 'SALON',
    'title': 'Hair wash with deep...',
    'image': handymanAppImages.salon,
    'avatar': handymanAppImages.emma,
    'name': 'Emma Davis',
    'price': 120,
    'originalPrice': 150,
  },
  {
    'tag': 'COOKING',
    'title': 'House roof cleaning...',
    'image': handymanAppImages.cooking,
    'avatar': handymanAppImages.lisa,
    'name': 'John Smith',
    'price': 90,
    'originalPrice': 120,
  },
  {
    'tag': 'CLEANING',
    'title': 'House roof cleaning...',
    'image': handymanAppImages.cleaning,
    'avatar': handymanAppImages.lisa,
    'name': 'Lisa Ray',
    'price': 100,
    'originalPrice': 130,
  },
];

final List<Map<String, dynamic>> featuredServiceCards = [
  {
    'title': 'Seasonal cleanup and...',
    'image': handymanAppImages.featured1,
    'avatar': handymanAppImages.john,
    'name': 'John Smith',
    'price': 120,
    'originalPrice': 150,
  },
  {
    'title': 'Mulching and fertilizing',
    'image': handymanAppImages.featured2,
    'avatar': handymanAppImages.john,
    'name': 'John Smith',
    'price': 90,
    'originalPrice': 120,
  },
];
