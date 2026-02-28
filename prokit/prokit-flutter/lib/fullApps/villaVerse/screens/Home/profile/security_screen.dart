import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';
import '../../../component/my_app_bar.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Security'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.height,
            buildObserverSwitch(
              "Remember Me",
              () => notiStore.rememberMe,
              (val) => notiStore.rememberMe = val,
            ),
            buildObserverSwitch(
              "Face ID",
              () => notiStore.faceId,
              (val) => notiStore.faceId = val,
            ),
            buildObserverSwitch(
              'Biometric ID',
              () => notiStore.biometricId,
              (val) => notiStore.biometricId = val,
            ),
            ListTile(
              title: Text("Google Authentication", style: primaryTextStyle()),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: appStore.isDarkModeOn ? lightColor : darkColor,
              ),
              onTap: () {},
            ),
            20.height,
            AppButton(
              elevation: 0,
              text: 'Change PIN',
              color: appStore.isDarkModeOn ? hintTextColor : blueLight,
              textStyle: boldTextStyle(
                  color: appStore.isDarkModeOn ? lightColor : primaryBlueColor),
              width: context.width(),
              onTap: () {},
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
            ).paddingSymmetric(horizontal: 16),
            16.height,
            AppButton(
              elevation: 0,
              text: 'Change Password',
              color: appStore.isDarkModeOn ? hintTextColor : blueLight,
              textStyle: boldTextStyle(
                  color: appStore.isDarkModeOn ? lightColor : primaryBlueColor),
              width: context.width(),
              onTap: () {},
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(20)),
            ).paddingSymmetric(horizontal: 16),
          ],
        ),
      ),
    );
  }

  // switch object
  Widget buildObserverSwitch(
      String title, bool Function() getValue, Function(bool) setValue) {
    return Observer(builder: (_) {
      return SwitchListTile(
        trackOutlineColor:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
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
    });
  }
}
