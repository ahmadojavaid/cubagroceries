import 'package:flutter/material.dart';

import '../utils/images.dart';

class HotelModel {
  final int id;
  final String name;
  final String address;
  final List<String> images;
  final String description;
  final List<Map<String, dynamic>> facilities;
  final List<Map<String, dynamic>> reviews;
  final double pricePerNight;
  final bool isFavorite;
  final DateTime startDate;
  final DateTime endDate;
  final int aduits;
  final int children;
  final dynamic infants;
  final dynamic reting;

  HotelModel({
    required this.id,
    required this.name,
    required this.address,
    required this.images,
    required this.description,
    required this.facilities,
    required this.reviews,
    required this.pricePerNight,
    this.isFavorite = false,
    required this.startDate,
    required this.endDate,
    required this.aduits,
    required this.children,
    required this.infants,
    required this.reting,
  });

  HotelModel copyWith({
    String? name,
    int? id,
    String? address,
    List<String>? images,
    String? description,
    List<Map<String, dynamic>>? facilities,
    List<Map<String, dynamic>>? reviews,
    double? pricePerNight,
    bool? isFavorite,
    DateTime? startdate,
    DateTime? enddate,
    int? aduits,
    int? children,
    int? infants,
    double? reting,
  }) {
    return HotelModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      images: images ?? this.images,
      description: description ?? this.description,
      facilities: facilities ?? this.facilities,
      reviews: reviews ?? this.reviews,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      isFavorite: isFavorite ?? this.isFavorite,
      startDate: startdate ?? startDate,
      endDate: enddate ?? endDate,
      aduits: aduits ?? this.aduits,
      children: children ?? this.children,
      infants: infants ?? this.infants,
      reting: reting ?? this.reting,
    );
  }
}

List<HotelModel> getHotleList() {
  List<HotelModel> hotelCard = [
    // Existing 4 hotels...
    HotelModel(
      id: 0,
      name: 'Royale President Hotel',
      address: '79 Place de la Madeleine, Paris, France',
      images: [roomimage2, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'Nestled in the heart of downtown, the Royale President Hotel blends historic charm with modern luxury.',
      facilities: [
        {'icon': Icons.pool, 'label': 'Swimming Pool'},
        {'icon': Icons.wifi, 'label': 'WiFi'},
        {'icon': Icons.restaurant, 'label': 'Restaurant'},
        {'icon': Icons.local_parking, 'label': 'Parking'},
      ],
      reviews: [
        {
          'name': 'Alice Smith',
          'avatar': userImage,
          'comment': 'Amazing stay! Staff were super friendly and helpful.',
          'rating': 4.8,
          'date': 'April 15, 2025',
        },
        {
          'name': 'John Doe',
          'avatar': userImage,
          'comment': 'The location is fantastic. Would definitely come again!',
          'rating': 4.5,
          'date': 'April 12, 2025',
        },
      ],
      reting: 4.5,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 2,
      children: 3,
      infants: 2,
      pricePerNight: 29,
    ),

    HotelModel(
      id: 4,
      name: 'Urban Oasis Hotel',
      address: '45 Downtown Ave, New York, USA',
      images: [roomimage5, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'A sleek, modern hotel in the heart of NYC with rooftop dining and skyline views.',
      facilities: [
        {'icon': Icons.pool, 'label': 'Swimming Pool'},
        {'icon': Icons.wifi, 'label': 'WiFi'},
        {'icon': Icons.restaurant, 'label': 'Restaurant'},
        {'icon': Icons.local_parking, 'label': 'Parking'},
      ],
      reviews: [
        {
          'name': 'Sarah Kent',
          'avatar': userImage,
          'comment': 'Loved the rooftop views!',
          'rating': 4.9,
          'date': 'May 1, 2025',
        },
      ],
      reting: 4.9,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 3,
      children: 2,
      infants: 4,
      pricePerNight: 150,
    ),

    HotelModel(
      id: 5,
      name: 'Mountainview Lodge',
      address: '221 Alpine Rd, Aspen, USA',
      images: [roomimage1, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'Ski-in/ski-out lodge nestled in the snowy mountains of Aspen.',
      facilities: [
        {'icon': Icons.ac_unit, 'label': 'Heated Rooms'},
        {'icon': Icons.local_fire_department, 'label': 'Fireplace'},
      ],
      reviews: [
        {
          'name': 'Mike Henry',
          'avatar': userImage,
          'comment': 'Perfect for ski season!',
          'rating': 4.3,
          'date': 'Jan 25, 2025',
        },
      ],
      reting: 4.3,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 2,
      children: 1,
      infants: 0,
      pricePerNight: 200,
    ),

    HotelModel(
      id: 6,
      name: 'Palm Beach Resort',
      address: '101 Palm Beach, Goa, India',
      images: [roomimage3, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'Tropical getaway just steps away from golden beaches.',
      facilities: [
        {'icon': Icons.beach_access, 'label': 'Private Beach'},
        {'icon': Icons.restaurant, 'label': 'Buffet'},
      ],
      reviews: [
        {
          'name': 'Ravi Sharma',
          'avatar': userImage,
          'comment': 'Beachside fun for the family!',
          'rating': 4.6,
          'date': 'Mar 15, 2025',
        },
      ],
      reting: 4.6,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 2,
      children: 2,
      infants: 1,
      pricePerNight: 95,
    ),

    HotelModel(
      id: 7,
      name: 'Luxe Marina Hotel',
      address: '8 Seaview Drive, Dubai, UAE',
      images: [roomimage2, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'Luxury experience at the Dubai Marina with world-class service.',
      facilities: [
        {'icon': Icons.spa, 'label': 'Spa'},
        {'icon': Icons.pool, 'label': 'Infinity Pool'},
      ],
      reviews: [
        {
          'name': 'Fatima Noor',
          'avatar': userImage,
          'comment': 'Felt like royalty!',
          'rating': 5.0,
          'date': 'Feb 14, 2025',
        },
      ],
      reting: 5.0,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 2,
      children: 0,
      infants: 0,
      pricePerNight: 320,
    ),

    HotelModel(
      id: 8,
      name: 'Countryside Inn',
      address: '77 Greenfield Road, Tuscany, Italy',
      images: [roomimage5, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'Rustic charm meets comfort in the Italian countryside.',
      facilities: [
        {'icon': Icons.local_florist, 'label': 'Garden'},
        {'icon': Icons.kitchen, 'label': 'Farm-to-table Dining'},
      ],
      reviews: [
        {
          'name': 'Marco Rossi',
          'avatar': userImage,
          'comment': 'Very peaceful and natural.',
          'rating': 4.2,
          'date': 'May 4, 2025',
        },
      ],
      reting: 4.2,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 2,
      children: 1,
      infants: 0,
      pricePerNight: 70,
    ),

    HotelModel(
      id: 9,
      name: 'Skyline View Hotel',
      address: '17 Tower Street, Tokyo, Japan',
      images: [roomimage1, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'Modern high-rise hotel with breathtaking city views.',
      facilities: [
        {'icon': Icons.wifi, 'label': 'WiFi'},
        {'icon': Icons.tv, 'label': 'Smart TV'},
      ],
      reviews: [
        {
          'name': 'Yuki Tanaka',
          'avatar': userImage,
          'comment': 'Best city views ever!',
          'rating': 4.7,
          'date': 'April 30, 2025',
        },
      ],
      reting: 4.7,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 1,
      children: 0,
      infants: 0,
      pricePerNight: 180,
    ),

    HotelModel(
      id: 10,
      name: 'Desert Mirage Camp',
      address: 'Sahara Desert, Morocco',
      images: [roomimage2, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'Stay in luxury tents under the desert stars.',
      facilities: [
        {'icon': Icons.nightlight_round, 'label': 'Stargazing'},
        {'icon': Icons.local_fire_department, 'label': 'Campfire'},
      ],
      reviews: [
        {
          'name': 'Ahmed Benali',
          'avatar': userImage,
          'comment': 'Unforgettable desert adventure.',
          'rating': 4.4,
          'date': 'Mar 5, 2025',
        },
      ],
      reting: 4.4,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 2,
      children: 0,
      infants: 0,
      pricePerNight: 110,
    ),

    HotelModel(
      id: 11,
      name: 'Nordic Ice Hotel',
      address: 'Frozen Lake, Lapland, Finland',
      images: [roomimage1, roomimage1, roomimage5, roomimage6, roomimage7],
      description: 'Unique experience in an ice hotel with aurora views.',
      facilities: [
        {'icon': Icons.ac_unit, 'label': 'Ice Rooms'},
        {'icon': Icons.snowshoeing, 'label': 'Snow Tours'},
      ],
      reviews: [
        {
          'name': 'Anna Kallio',
          'avatar': userImage,
          'comment': 'Cold but magical!',
          'rating': 4.8,
          'date': 'Dec 25, 2024',
        },
      ],
      reting: 4.8,
      startDate: DateTime(2025),
      endDate: DateTime(2028),
      aduits: 2,
      children: 1,
      infants: 0,
      pricePerNight: 210,
    ),
  ];

  return hotelCard;
}
