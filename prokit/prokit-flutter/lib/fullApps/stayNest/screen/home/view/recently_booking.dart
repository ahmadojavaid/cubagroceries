import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../main.dart';
import '../../../components/hotel_card_component.dart';
import '../../../store/hoteldata.dart';

class RecentlyBooking extends StatefulWidget {
  const RecentlyBooking({super.key});

  @override
  State<RecentlyBooking> createState() => _RecentlyBookingState();
}

class _RecentlyBookingState extends State<RecentlyBooking> {
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
        statusBarBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
      ),
    );
  }

  final HotelStorecard hotelStore = HotelStorecard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text("Recently Booked"),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? Colors.white : Colors.black,
        ),
        backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [RecentlyBookedList()],
        ),
      ),
    );
  }
}
