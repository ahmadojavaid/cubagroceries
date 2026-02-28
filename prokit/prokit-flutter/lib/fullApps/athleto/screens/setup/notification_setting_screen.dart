import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../store/notifications_store.dart';
import '../../utils/colors.dart';

class NotificationsSettingsScreen extends StatelessWidget {
  final NotificationsStore store = NotificationsStore();

  NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // Use Brightness.dark if needed
        ),
        backgroundColor: scaffoldSecondaryDark,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.lime,
            size: 28,
          ),
        ),
        title: Text(
          "Notifications Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.lime,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            notificationItem("General Notification", () => store.generalNotification, store.setGeneralNotification),
            notificationItem("Sound", () => store.sound, store.setSound),
            notificationItem("Don't Disturb Mode", () => store.doNotDisturb, store.setDoNotDisturb),
            notificationItem("Vibrate", () => store.vibrate, store.setVibrate),
            notificationItem("Lock Screen", () => store.lockScreen, store.setLockScreen),
            notificationItem("Reminders", () => store.reminders, store.setReminders),
          ],
        ).paddingAll(16),
      ),
    );
  }

  Widget notificationItem(String title, bool Function() switchValue, Function(bool) onChanged) {
    return Observer(
      builder: (_) => ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        trailing: Switch(
          value: switchValue(),
          inactiveTrackColor: primaryColor,
          activeColor: Colors.lime,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
