import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/Home/profile/profileConponents/tab_bar_view_card.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/Home/profile/profileConponents/tab_bar_view_card_completed.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: AppBar(
        backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
        title: Text('My Bookings', style: boldTextStyle(size: 16)),
        leading: GestureDetector(
            onTap: () => finish(context),
            child: Icon(
              Icons.arrow_back,
              color: appStore.isDarkModeOn ? lightColor : darkColor,
            )),
        bottom: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide:
                BorderSide(width: 3, color: primaryBlueColor, strokeAlign: 50),
            insets: EdgeInsets.symmetric(horizontal: 100),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          labelColor: primaryBlueColor,
          unselectedLabelColor: appStore.isDarkModeOn ? lightColor : darkColor,
          dividerColor: Colors.transparent,
          controller: _tabController,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          tabs: [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return TabBarViewActiveCard().paddingSymmetric(
                    horizontal: 16, vertical: index == 0 ? 16 : 8);
              }),
          ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return TabBarViewCardCompleted().paddingSymmetric(
                  horizontal: 16, vertical: index == 0 ? 16 : 8);
            },
          ),
        ],
      ),
    );
  }
}
