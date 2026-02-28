// ignore_for_file: file_names

import '../utils/images.dart';

class Hotel {
  final int id;
  final String name;
  final String address;
  final double pricePerNight;
  final double rating;
  final String image;

  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.pricePerNight,
    required this.rating,
    required this.image,
  });

  Hotel copyWith({
    int? id,
    String? name,
    String? address,
    double? pricePerNight,
    double? rating,
    String? image,
  }) {
    return Hotel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      rating: rating ?? this.rating,
      image: image ?? this.image,
    );
  }
}

List<Hotel> saveData() {
  List<Hotel> saveData = [];

  saveData.add(
    Hotel(
      id: 1,
      name: "Ocean View Resort",
      address: "123 Beachside Ave, Miami, FL",
      pricePerNight: 250.0,
      rating: 4.5,
      image: roomimage1,
    ),
  );

  saveData.add(
    Hotel(
      id: 2,
      name: "Mountain Retreat",
      address: "456 Mountain Rd, Denver, CO",
      pricePerNight: 180.0,
      rating: 4.7,
      image: roomimage2,
    ),
  );

  saveData.add(
    Hotel(
      id: 3,
      name: "City Central Hotel",
      address: "789 Downtown St, New York, NY",
      pricePerNight: 150.0,
      rating: 4.0,
      image: roomimage3,
    ),
  );

  return saveData;
}
