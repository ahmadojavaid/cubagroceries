// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../model/booking_model.dart';
import '../../../utils/colors.dart';
import '../component/booking_card_cancel.dart';
import '../component/booking_card_completed.dart';
import '../component/booking_card_ongoing.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  List<Bookings> upcomingBookings = [];
  List<Bookings> pastBookings = [];
  List<Bookings> cansle = [];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    upcomingBookings = List.from(bookingUpcomingData());
    pastBookings = List.from(bookingPostData());
    cansle = List.from(cansledata());

    super.initState();
    afterBuildCreated(() {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
          statusBarBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('My Bookings'),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? white : black,
        ),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: appStore.isDarkModeOn ? const Color.fromARGB(255, 35, 34, 34) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: stayNestPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: appStore.isDarkModeOn ? white : Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.symmetric(horizontal: 12),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(child: Text('Ongoing')),
                Tab(child: Text('Completed')),
                Tab(child: Text('Cancelled')),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: upcomingBookings.length,
                  itemBuilder: (context, index) {
                    return BookingCardOngoing(booking: upcomingBookings[index], isPast: false);
                  },
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: pastBookings.length,
                  itemBuilder: (context, index) {
                    return BookingCardComplited(booking: pastBookings[index], isPast: true);
                  },
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cansle.length,
                  itemBuilder: (context, index) {
                    return BookingCardCansle(booking: cansle[index], isPast: true);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
