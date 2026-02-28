import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/profile/view/profile_screen.dart';

import '../../../main.dart';
import '../store/bottom_nav_store.dart';
import '../utils/colors.dart';
import 'home/view/home_screen.dart';
import 'my_booking/view/my_booking_screen.dart';
import 'serch/view/search_screen.dart';

class PageSlider extends StatelessWidget {
  final BottomNavStore bottomNavStore = BottomNavStore();

  PageSlider({super.key});

  static final List<Widget> _pages = <Widget>[
    HomePage(),
    HotelSearchScreen(),
    BookingsScreen(),
    ProfileScreenState(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: appStore.isDarkModeOn == true ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    );
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn == true ? black : white,
      body: Observer(builder: (_) => _pages[bottomNavStore.selectedIndex]),
      bottomNavigationBar: Observer(
        builder: (_) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: stayNestPrimaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: bottomNavStore.selectedIndex,
          onTap: bottomNavStore.changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_online),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
