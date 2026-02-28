import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/health/component/health_card_component.dart';
import 'package:prokit_flutter/dashboard/health/component/top_appbar_component.dart';
import 'package:prokit_flutter/dashboard/health/utils/app_colors.dart';
import 'package:prokit_flutter/dashboard/health/utils/app_images.dart';
import 'package:prokit_flutter/dashboard/health/utils/app_string.dart';
import 'package:prokit_flutter/dashboard/health/utils/common.dart';

import '../../../main.dart';

HealthAppColors healthAppColors = HealthAppColors();
HealthAppImages healthAppImages = HealthAppImages();
HealthAppString healthAppString = HealthAppString();

class HealthAppHomeScreen extends StatefulWidget {
  const HealthAppHomeScreen({super.key});

  @override
  State<HealthAppHomeScreen> createState() => _HealthAppHomeScreenState();
}

class _HealthAppHomeScreenState extends State<HealthAppHomeScreen> {
  int selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: healthAppColors.bgColor,
        body: _buildBody(),
        bottomNavigationBar: _buildBottomAppBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () => onTabTapped(2), 
          backgroundColor: healthAppColors.blueColor,
          shape: const CircleBorder(),
          child: Text(
            'GO',
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: healthAppColors.constWhite,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 37.0),
      child: Container(
        decoration: BoxDecoration(color: healthAppColors.bgColor),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopAppbar(),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: txtWidget(
                  healthAppString.welcome,
                  20,
                  FontWeight.w500,
                  healthAppColors.titleTXTColor,
                ),
              ),
              const SizedBox(height: 11),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: txtWidget(
                  healthAppString.name,
                  11,
                  FontWeight.w400,
                  healthAppColors.subtitleTXTColor,
                ),
              ),
              const SizedBox(height: 56),
              const HealthCards(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildBottomAppBar() {
    return BottomAppBar(
      notchMargin: 8.0,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                healthAppImages.apps,
                color: selectedIndex == 0
                    ? healthAppColors.deepPurple
                    : healthAppColors.grey,
              ),
              onPressed: () => onTabTapped(0),
            ),
            IconButton(
              icon: Icon(
                healthAppImages.monitor,
                color: selectedIndex == 1
                    ? healthAppColors.deepPurple
                    : healthAppColors.grey,
              ),
              onPressed: () => onTabTapped(1),
            ),
            const SizedBox(width: 40), 
            IconButton(
              icon: Icon(
                healthAppImages.chat,
                color: selectedIndex == 3
                    ? healthAppColors.deepPurple
                    : healthAppColors.grey,
              ),
              onPressed: () => onTabTapped(3),
            ),
            IconButton(
              icon: Icon(
                healthAppImages.profile,
                color: selectedIndex == 4
                    ? healthAppColors.deepPurple
                    : healthAppColors.grey,
              ),
              onPressed: () => onTabTapped(4),
            ),
          ],
        ),
      ),
    );
  }
}
