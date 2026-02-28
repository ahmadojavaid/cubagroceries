import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/Home/profile/payments_method.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/Home/profile/profile_notification_screen.dart';
import 'package:prokit_flutter/fullApps/villaVerse/screens/Home/profile/update_profile.dart';
import 'package:prokit_flutter/main.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/image.dart';
import '../../Auth/sign_in.dart';
import 'booking_screen.dart';
import 'help_center.dart';
import 'invite_friends_screen.dart';
import 'language_screen.dart';
import 'security_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Image.asset(
                  villaVerse,
                  height: 40,
                  width: 40,
                ),
                title: Text("Profile", style: boldTextStyle(size: 18)),
              ),
              16.height,
              Center(
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      image == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.network(friend2),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(500),
                              child: SizedBox(
                                height: 120,
                                width: 120,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.file(image),
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () => UpdateProfile().launch(
                            context,
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                color: primaryBlueColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: lightColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Andrew Ainsley",
                style: boldTextStyle(size: 16),
              ),
              12.height,
              Divider(color: context.cardColor)
                  .paddingSymmetric(horizontal: 16),
              12.height,
              buildListTile(
                FontAwesomeIcons.calendarCheck,
                "My Booking",
                () => BookingScreen().launch(context),
              ),
              buildListTile(
                Icons.payment,
                "Payments",
                () => PaymentsMethod().launch(context),
              ),
              Divider(color: context.cardColor)
                  .paddingSymmetric(horizontal: 16),
              buildListTile(
                Icons.person,
                "Profile",
                () => UpdateProfile().launch(context),
              ),
              buildListTile(
                Icons.notifications,
                "Notification",
                () => ProfileNotificationScreen().launch(context),
              ),
              buildListTile(
                Icons.security,
                "Security",
                () => SecurityScreen().launch(
                  context,
                ),
              ),
              ListTile(
                onTap: () => LanguageScreen().launch(
                  context,
                ),
                leading: Icon(Icons.language),
                title: Text("Language", style: primaryTextStyle()),
                trailing: Text("English (US)", style: secondaryTextStyle()),
              ),
              Observer(builder: (_) {
                return SwitchListTile(
                  trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                      (Set<WidgetState> states) {
                    return Colors.transparent;
                  }),
                  title: Text(
                    "Dark Mode",
                    style: primaryTextStyle(),
                  ),
                  value: appStore.isDarkModeOn,
                  inactiveThumbColor: hintTextColor,
                  inactiveTrackColor: inputFillColorlight,
                  activeColor: primaryBlueColor,
                  onChanged: (value) {
                    appStore.toggleDarkMode(value: value);
                  },
                  secondary: Icon(Icons.remove_red_eye_outlined),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                );
              }),
              buildListTile(Icons.help_center_rounded, "Help Center",
                  () => HelpCenter().launch(context)),
              buildListTile(Icons.group_add, "Invite Friends",
                  () => InviteFriendsScreen().launch(context)),
              SizedBox(height: 16),
              Divider(color: context.cardColor)
                  .paddingSymmetric(horizontal: 16),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Logout", style: TextStyle(color: Colors.red)),
                onTap: () => logOutSheet(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logOutSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        hideKeyboard(context);
        return Container(
          height: 190,
          width: context.width(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
            color: appStore.isDarkModeOn
                ? inputFillColorDart
                : inputFillColorlight,
          ),
          child: Column(
            children: [
              5.height,
              Divider(color: Colors.grey, height: 20)
                  .paddingSymmetric(horizontal: context.width() * .45),
              16.height,
              Text("Logout",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              16.height,
              Text(
                "Are you sure you want to log out?",
                style: secondaryTextStyle(),
              ),
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: AppButton(
                      elevation: 0,
                      text: 'Cancel',
                      color: appStore.isDarkModeOn ? hintTextColor : blueLight,
                      textStyle: boldTextStyle(
                        color: appStore.isDarkModeOn
                            ? lightColor
                            : primaryBlueColor,
                      ),
                      onTap: () => finish(context),
                      shapeBorder:
                          RoundedRectangleBorder(borderRadius: radius(20)),
                    ),
                  ),
                  16.width,
                  Expanded(
                    child: AppButton(
                      elevation: 0,
                      text: 'Yes, Logout',
                      color: primaryBlueColor,
                      textStyle: boldTextStyle(color: lightColor),
                      onTap: () => SignIn().launch(context),
                      shapeBorder:
                          RoundedRectangleBorder(borderRadius: radius(20)),
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 16, left: 16, right: 16),
            ],
          ),
        );
      },
    );
  }

  Widget buildListTile(IconData icon, String title, VoidCallback voidCallBack) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: primaryTextStyle()),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: voidCallBack,
    );
  }
}
