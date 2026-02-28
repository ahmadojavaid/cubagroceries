// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../villaVerse/screens/Home/home_screen.dart';
import '../../../../../villaVerse/screens/Home/profile/profile_screen.dart';
import '../../../../utils/colors.dart';
import '../../explore/explore.dart';
import '../../favoriteRealEstates/favorite.dart';
import '../../message/messages_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;

  DateTime? _lastPressed;

  Future<bool> _onWillPop() {
    final now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > Duration(seconds: 2)) {
      _lastPressed = now;
      toast('Press back again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: [HomeScreen(), Explore(), Favorite(), MessageScreen(), ProfileScreen()][selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: primaryBlueColor,
          unselectedItemColor: hintTextColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: "Message"),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_sharp), label: "Profile"),
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
        ),
      ),
    );
  }
}
