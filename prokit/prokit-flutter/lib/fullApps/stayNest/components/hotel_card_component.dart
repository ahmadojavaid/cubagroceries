// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screen/card_detail/view/card_detail_screen.dart';
import '../screen/home/component/booked_card_component.dart';
import '../utils/constant.dart';

Widget RecentlyBookedList() {
  return Observer(
    builder: (_) {
      final hotels = hotelCard;

      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];

          return HotelCard(
            id: index,
            name: hotel.name,
            address: hotel.address,
            pricePerNight: hotel.pricePerNight,
            rating: hotel.reting,
            image: hotel.images.isNotEmpty ? hotel.images.first : '',
            onTap: () => HotelDetailScreen(hotelId: index).launch(context),
          );
        },
      );
    },
  );
}

Widget HomeRecently() {
  final hotels = hotelCard;

  return Observer(
    builder: (_) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];

          return HotelCard(
            id: index,
            name: hotel.name,
            address: hotel.address,
            pricePerNight: hotel.pricePerNight,
            rating: hotel.reting,
            image: hotel.images.isNotEmpty ? hotel.images.first : '',
            onTap: () => HotelDetailScreen(hotelId: index).launch(context),
          );
        },
      );
    },
  );
}
