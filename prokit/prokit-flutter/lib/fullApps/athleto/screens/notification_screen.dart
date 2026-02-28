import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../component/custom_Appbar.dart';
import '../resources/bottom_navigation.dart';
import '../store/notifications_store.dart';
import '../utils/colors.dart';
import '../utils/image.dart';

class NotificationsScreen extends StatelessWidget {
  final NotificationsStore store = NotificationsStore();

  final List<String> tabs = ["Remainders", "System"];

  NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Notification",
        onBack: () {
          CustomBottomNavigation().launch(context, isNewTask: true);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Observer(
            builder: (_) => Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(tabs.length, (index) {
                      bool isSelected = store.selectedIndex == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => store.setSelectedIndex(index),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? white : buttonColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                fontSize: 18,
                                color: isSelected ? purpleColor : white,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
          ),

          // Notification List
          Expanded(
            child: ListView(
              children: [
                sectionHeader("Today").paddingLeft(25),
                notificationTile("New Workout Is Available", "June 10 - 10:00 AM", star),
                notificationTile("Don't Forget To Drink Water", "June 10 - 8:00 AM", bulb),
                sectionHeader("Yesterday").paddingLeft(25),
                notificationTile("Upper Body Workout Completed!", "June 09 - 8:00 PM", trophyIcon),
                notificationTile("Remember Your Exercise Session", "June 09 - 3:00 PM", bulb),
                notificationTile("New Article & Tip Posted!", "June 09 - 10:00 AM", progressIcon),
                sectionHeader("May 29 - 20XX").paddingLeft(25),
                notificationTile("You Started A New Challenge!", "May 29 - 8:00 AM", bulb),
                notificationTile("New House Training Ideas!", "May 29 - 8:20 AM", bulb),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title, style: boldTextStyle(color: Colors.white, size: 16)),
    );
  }

  Widget notificationTile(String title, String time, String image) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: buttonColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ImageIcon(AssetImage(image), color: Colors.white),
          ),
          12.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: boldTextStyle(color: white),
              ),
              4.height,
              Row(
                children: [
                  Icon(Icons.timer, size: 14, color: primaryColor),
                  4.width,
                  Text(
                    time,
                    style: secondaryTextStyle(color: primaryColor),
                  ),
                ],
              ),
            ],
          ).expand(),
        ],
      ),
    ).paddingAll(10);
  }
}
