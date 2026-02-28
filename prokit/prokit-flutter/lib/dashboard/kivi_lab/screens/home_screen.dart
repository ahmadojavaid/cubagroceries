import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/appointment_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/categoty_slider_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/near_labs_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/popular_package_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/slider_page_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/test_card_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/top_container_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/app_colors.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/app_images.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/app_strings.dart';


KiviLabAppImages kiviLabAppImages = KiviLabAppImages();
KiviLabAppColors kiviLabAppColors = KiviLabAppColors();
KiviLabAppStrings kiviLabAppStrings = KiviLabAppStrings();

class KiviLabHomeScreen extends StatefulWidget {
  const KiviLabHomeScreen({super.key});

  @override
  State<KiviLabHomeScreen> createState() => _KiviLabHomeScreenState();
}

class _KiviLabHomeScreenState extends State<KiviLabHomeScreen> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today_outlined),
      label: 'Appointments',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science_outlined),
      label: 'Package',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
  ];

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TopContainer(),
          const SizedBox(height: 32),
          Appointment(),
          const SizedBox(height: 44),
          SliderPage(),
          const SizedBox(height: 32),
          NearLabs(),
          const SizedBox(height: 32),
          CategotySlider(),
          const SizedBox(height: 32),
          TestCard(),
          const SizedBox(height: 32),
          HealthPackageList(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
  value: const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
  ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kiviLabAppColors.white,
        body: _buildHomeContent(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          selectedItemColor: kiviLabAppColors.blue700,
          unselectedItemColor: kiviLabAppColors.black,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: _navItems,
        ),
      ),
    );
  }
}
