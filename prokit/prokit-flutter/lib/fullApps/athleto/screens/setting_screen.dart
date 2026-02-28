import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';
import 'setup/notification_setting_screen.dart';
import 'setup/password_setting_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
        backgroundColor: scaffoldSecondaryDark,
        appBar: AppBar(
          backgroundColor: scaffoldSecondaryDark,
          elevation: 0,
          leading: Icon(Icons.arrow_back, color: limeColor, size: 28).onTap(() {
            finish(context);
          }),
          title: Text("Settings", style: boldTextStyle(color: limeColor, size: 20)),
        ),
        body: Column(
          children: [
            settingItem(context, "Notification Setting", Icons.notifications, () {
              NotificationsSettingsScreen().launch(context);
            }),
            settingItem(context, "Password Setting", Icons.vpn_key, () {
              PasswordSettingsScreen().launch(context);
            }),
            settingItem(context, "Delete Account", Icons.person, () {}),
          ],
        ));
  }

  Widget settingItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return SettingItemWidget(
      title: title,
      titleTextStyle: primaryTextStyle(color: Colors.white, size: 18),
      leading: Icon(icon, color: primaryColor, size: 28),
      trailing: Icon(Icons.keyboard_arrow_right_outlined, color: limeColor),
      onTap: onTap,
    ).paddingTop(15);
  }
}
