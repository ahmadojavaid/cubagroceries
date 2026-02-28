import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/images.dart';
import '../fragment/favourite_movie_fragment.dart';
import '../fragment/home_fragment.dart';
import '../fragment/my_ticket_fragment.dart';
import '../fragment/profile_fragment.dart';
import '../fragment/search_movie_fragment.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screenList = [
      HomeFragment(onTabSelected: _onTabSelected),
      const SearchFragment(),
      const FavouriteMovieFragment(),
      const MyTicketFragment(),
      const ProfileFragment(),
    ];

    return Scaffold(
      body: screenList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _onTabSelected,
        currentIndex: currentIndex,
        items: [
          _buildBottomNavigationBarItem(bottomIcon1, 0, 'Home'),
          _buildBottomNavigationBarItem(bottomIcon2, 1, 'Search'),
          _buildBottomNavigationBarItem(bottomIcon3, 2, 'Favourite'),
          _buildBottomNavigationBarItem(bottomIcon4, 3, 'My Ticket'),
          _buildBottomNavigationBarItem(bottomIcon5, 4, 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(String iconPath, int index, String label) {
    bool isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        height: 35,
        width: isSelected ? 90 : 35,
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : Colors.grey,
                BlendMode.srcATop,
              ),
              child: Image(
                image: NetworkImage(iconPath),
                height: 26,
                width: 26,
                fit: BoxFit.cover,
              ),
            ).paddingOnly(left: 5),
            if (isSelected)
              Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          ],
        ),
      ),
      label: '',
    );
  }
}
