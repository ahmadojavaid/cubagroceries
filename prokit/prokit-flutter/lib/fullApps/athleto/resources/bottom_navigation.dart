import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/Home/home.dart';
import '../screens/favourite/favourite_screen.dart';
import '../screens/progrees/progress_screen.dart';
import '../screens/search_screen.dart';
import '../screens/profile_screen.dart';
import '../utils/colors.dart';
import '../utils/image.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation({super.key});

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  int _currentIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(homeIcon),
          color: _currentIndex == 0 ? purpleColor : Colors.grey,
        ),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(progressIcon),
          color: _currentIndex == 1 ? purpleColor : Colors.grey,
        ),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage(favouriteIcon),
          color: _currentIndex == 2 ? purpleColor : Colors.grey,
        ),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(
              mangnifier,
            ),
            color: _currentIndex == 3 ? purpleColor : Colors.grey),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
            AssetImage(
              personIcon,
            ),
            color: _currentIndex == 4 ? purpleColor : Colors.grey),
        label: "",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      body: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (newvalue) {
            setState(() {
              _currentIndex = newvalue;
            });
          },
          children: [
            FitnessDashboardScreen(),
            ProgressScreen(),
            FavouriteScreen(),
            SearchScreen(),
            UserDetailScreen(),
          ],
        ),
        bottomNavigationBar: Blur(
          child: SizedBox(
            height: height * 0.08,
            child: BottomNavigationBar(
              backgroundColor: scaffoldSecondaryDark,
              enableFeedback: true,
              selectedItemColor: purpleColor,
              items: getBottomNavigationBarItems(),
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: (index) {
                FocusScope.of(context).unfocus();
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
