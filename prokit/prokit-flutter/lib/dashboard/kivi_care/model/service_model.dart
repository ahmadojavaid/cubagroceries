
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';

class ServiceCardModel {
  final String category;
  final String image;
  final String title;
  final String duration;
  final String price;
  final String originalPrice;
  final String discount;

  ServiceCardModel({
    required this.category,
    required this.image,
    required this.title,
    required this.duration,
    required this.price,
    required this.originalPrice,
    required this.discount,
  });
}


final List<ServiceCardModel> services = [
    ServiceCardModel(
      category:kiviCareAppString.dermatology,
      image: kiviCareAppImages.service1,
      title:kiviCareAppString.laserTreatment,
      duration: kiviCareAppString.duration,
      price: "\$50",
      originalPrice: "\$75",
      discount: "10%",
    ),
    ServiceCardModel(
      category: kiviCareAppString.ophthalmology,
      image: kiviCareAppImages.service2,
      title: kiviCareAppString.laserTreatment,
      duration: kiviCareAppString.duration,
      price: "\$50",
      originalPrice: "\$75",
      discount: "10%",
    ),

  ];