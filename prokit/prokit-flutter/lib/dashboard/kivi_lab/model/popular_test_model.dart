

import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';

class HealthPackageModel {
  final String title;
  final String labName;
  final String description;
  final String imagePath;
  final double offerPrice;
  final double originalPrice;
  final String discountLabel;
  final String expiryDate;
  final List<PackageItem> items;

  HealthPackageModel({
    required this.title,
    required this.labName,
    required this.description,
    required this.imagePath,
    required this.offerPrice,
    required this.originalPrice,
    required this.discountLabel,
    required this.expiryDate,
    required this.items,
  });
}

class PackageItem {
  final String name;
  final double price;
  final double originalPrice;

  PackageItem({
    required this.name,
    required this.price,
    required this.originalPrice,
  });
}

final List<HealthPackageModel> healthPackages = [
  HealthPackageModel(
    title: 'Full Body Health Checkup',
    labName: 'Healthcare Laboratory',
    description:
        'A thorough evaluation of your overall health, blood sugar levels, kidney function, & glucose control.',
    imagePath: kiviLabAppImages.category3,
    offerPrice: 600,
    originalPrice: 750,
    discountLabel: '20% Off',
    expiryDate: '12/06/2025',
    items: [
      PackageItem(name: 'Blood Sugar level', price: 230, originalPrice: 250),
      PackageItem(name: 'Kidney Function', price: 120, originalPrice: 250),
      PackageItem(name: 'Glucose Control', price: 80, originalPrice: 250),
    ],
  ),

  HealthPackageModel(
    title: 'Full Body Health Checkup',
    labName: 'Healthcare Laboratory',
    description:
        'A thorough evaluation of your overall health, blood sugar levels, kidney function, & glucose control.',
    imagePath: kiviLabAppImages.category3,
    offerPrice: 600,
    originalPrice: 750,
    discountLabel: '20% Off',
    expiryDate: '12/06/2025',
    items: [
      PackageItem(name: 'Blood Sugar level', price: 230, originalPrice: 250),
      PackageItem(name: 'Kidney Function', price: 120, originalPrice: 250),
      PackageItem(name: 'Glucose Control', price: 80, originalPrice: 250),
    ],
  ),
];
