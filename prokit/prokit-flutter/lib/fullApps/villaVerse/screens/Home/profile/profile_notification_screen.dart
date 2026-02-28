import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../component/my_app_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class ProfileNotificationScreen extends StatefulWidget {
  const ProfileNotificationScreen({super.key});

  @override
  State<ProfileNotificationScreen> createState() => _ProfileNotificationScreenState();
}

class _ProfileNotificationScreenState extends State<ProfileNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Notification'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.height,
            buildObserverSwitch(
              "General Notification",
              () => notiStore.generalNotification,
              (val) => notiStore.generalNotification = val,
            ),
            buildObserverSwitch(
              "Sound",
              () => notiStore.sound,
              (val) => notiStore.sound = val,
            ),
            buildObserverSwitch(
              "Vibrate",
              () => notiStore.vibrate,
              (val) => notiStore.vibrate = val,
            ),
            buildObserverSwitch(
              "Special Offers",
              () => notiStore.specialOffers,
              (val) => notiStore.specialOffers = val,
            ),
            buildObserverSwitch(
              "Promo & Discount",
              () => notiStore.promoDiscount,
              (val) => notiStore.promoDiscount = val,
            ),
            buildObserverSwitch(
              "Payment",
              () => notiStore.payment,
              (val) => notiStore.payment = val,
            ),
            buildObserverSwitch(
              "Cashback",
              () => notiStore.cashback,
              (val) => notiStore.cashback = val,
            ),
            buildObserverSwitch(
              "App Updates",
              () => notiStore.appUpdates,
              (val) => notiStore.appUpdates = val,
            ),
            buildObserverSwitch(
              "New Service Available",
              () => notiStore.newService,
              (val) => notiStore.newService = val,
            ),
            buildObserverSwitch(
              "New Tips Available",
              () => notiStore.newTipAvailable,
              (val) => notiStore.newTipAvailable = val,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildObserverSwitch(String title, bool Function() getValue, Function(bool) setValue) {
    return Observer(
      builder: (_) {
        return SwitchListTile(
          trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
            return Colors.transparent;
          }),
          inactiveTrackColor: context.cardColor,
          title: Text(title, style: primaryTextStyle()),
          value: getValue(),
          onChanged: setValue,
          inactiveThumbColor: hintTextColor,
          activeColor: primaryBlueColor,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        );
      },
    );
  }
}
