import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prokit_flutter/dashboard/frezka/components/top_container_component.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/body_container.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/app_color.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/app_images.dart';

FrezkaAppColor frezlaAppColor = FrezkaAppColor();
FrezkaAppImages frezkaAppImages = FrezkaAppImages();

class FrezkaHomeScreen extends StatefulWidget {
  const FrezkaHomeScreen({super.key});

  @override
  State<FrezkaHomeScreen> createState() => _FrezkaHomeScreenState();
}
class _FrezkaHomeScreenState extends State<FrezkaHomeScreen> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  AnnotatedRegion<SystemUiOverlayStyle>(
  value: const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: frezlaAppColor.bgColor,
        bottomNavigationBar: Container(
          height: 60,
          color: frezlaAppColor.white, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.calendar_month, 'Booking', 1),
              _buildNavItem(Icons.notifications_none, 'Notification', 2),
              _buildNavItem(Icons.person, 'Profile', 3),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopContainer(),
              BodyContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? frezlaAppColor.topContainerColor : frezlaAppColor.grey,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: frezlaAppColor.topContainerColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
