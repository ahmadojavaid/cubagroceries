import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prokit_flutter/dashboard/handyman/component/category_component.dart';
import 'package:prokit_flutter/dashboard/handyman/component/featured_service_component.dart';
import 'package:prokit_flutter/dashboard/handyman/component/head_banner_component.dart';
import 'package:prokit_flutter/dashboard/handyman/component/offer_card_component.dart';
import 'package:prokit_flutter/dashboard/handyman/component/request_card_component.dart';
import 'package:prokit_flutter/dashboard/handyman/component/service_sreeen_component.dart';
import 'package:prokit_flutter/dashboard/handyman/component/upcoming_booking_component.dart';
import 'package:prokit_flutter/dashboard/handyman/utils/app_color.dart';
import 'package:prokit_flutter/dashboard/handyman/utils/app_images.dart';
import 'package:prokit_flutter/dashboard/handyman/utils/app_string.dart';

HandymanAppColor handymanAppColor = HandymanAppColor();
HandymanAppImages handymanAppImages = HandymanAppImages();
HandymanAppString handymanAppString = HandymanAppString();

class HandyManDashBoard extends StatefulWidget {
  const HandyManDashBoard({super.key});

  @override
  State<HandyManDashBoard> createState() => _HandyManDashBoardState();
}

class _HandyManDashBoardState extends State<HandyManDashBoard> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          HomeScreen(),
          SizedBox(height: 20),
          CategoryScreen(),
          SizedBox(height: 20),
          UpcomingBooking(),
          SizedBox(height: 20),
          OfferCard(),
          SizedBox(height: 20),
          ServiceCardList(),
          SizedBox(height: 32),
          FeaturedService(),
          SizedBox(height: 32),
          RequestCard(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  final List<Map<String, String>> navItems = [
    {"icon": handymanAppImages.home, "label": "Home"},
    {"icon": handymanAppImages.booking, "label": "Booking"},
    {"icon": handymanAppImages.category, "label": "Category"},
    {"icon": handymanAppImages.chat, "label": "Chat"},
    {"icon": handymanAppImages.profile, "label": "Profile"},
  ];

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
        backgroundColor: handymanAppColor.bgColor,
        body: _buildHomeContent(),
        bottomNavigationBar: Container(
          height: 64,
          color: handymanAppColor.whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isSelected = _selectedIndex == index;
              return GestureDetector(
                onTap: () => _onTabTapped(index),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      item['icon']!,
                      height: 24,
                      width: 24,
                      color: isSelected
                          ? handymanAppColor.blueCustom
                          : handymanAppColor.greyColor,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['label']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? handymanAppColor.blueCustom
                            : handymanAppColor.greyColor,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
