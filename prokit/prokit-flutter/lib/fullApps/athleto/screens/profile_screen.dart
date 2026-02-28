import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';
import '../utils/image.dart';
import 'Auth/login_screen.dart';
import 'edit_profile.dart';
import 'helpAndSupport/help_support.dart';
import 'setting_screen.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  color: primaryColor,
                  height: 280,
                  width: context.width(),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: screenWidth * 0.08),
                          child: Text(
                            'My Profile',
                            style: boldTextStyle(color: Colors.white, size: 20),
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 16),
                      4.height,
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            decoration: boxDecorationDefault(
                              border: Border.all(color: primaryColor, width: 2),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              margin: EdgeInsets.all(4),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: AssetImage(profile),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 8,
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(6),
                              decoration: boxDecorationDefault(
                                shape: BoxShape.circle,
                                color: primaryColor,
                                border: Border.all(width: 2, color: white),
                              ),
                              child: Icon(Icons.edit, color: white, size: 18),
                            ).onTap(() {
                              EditUserDetailScreen().launch(context);
                            }),
                          ),
                        ],
                      ),
                      4.height,
                      Marquee(child: Text("Madison Smith", style: boldTextStyle(color: white))).paddingSymmetric(horizontal: 16),
                      Marquee(
                        child: Text("madisons@example.com", style: secondaryTextStyle(color: white.withValues(alpha: 0.8), size: 14)),
                      ).paddingSymmetric(horizontal: 16),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 28),
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                    decoration: boxDecorationWithRoundedCorners(backgroundColor: purpleColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        profileStat('75 Kg', 'Weight', screenWidth),
                        verticalDivider(),
                        profileStat('28', 'Years Old', screenWidth),
                        verticalDivider(),
                        profileStat('1.65 CM', 'Height', screenWidth),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.08),
            profileMenuItem(Icons.person, 'Profile', screenWidth, onTap: () {
              EditUserDetailScreen().launch(context);
            }),
            10.height,
            profileMenuItem(Icons.privacy_tip, 'Privacy Policy', screenWidth).onTap(() {}),
            10.height,
            profileMenuItem(Icons.settings, 'Settings', screenWidth).onTap(() {
              SettingsScreen().launch(context);
            }),
            10.height,
            profileMenuItem(Icons.help, 'Help', screenWidth).onTap(() {
              HelpSupportScreen().launch(context);
            }),
            10.height,
            profileMenuItem(Icons.logout, 'Logout', screenWidth).onTap(() {
              showCustomLogoutDialog(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget profileStat(String value, String label, double screenWidth) {
    return Column(
      children: [
        Text(value, style: boldTextStyle(color: Color(0xFFE2F163), size: 18)),
        Text(label, style: primaryTextStyle(color: Colors.white54, size: 15)),
      ],
    );
  }

  Widget verticalDivider() {
    return Container(
      height: 40,
      width: 5,
      decoration: boxDecorationDefault(color: whiteColor),
    );
  }

  Widget profileMenuItem(IconData icon, String title, double screenWidth,
      {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      leading: CircleAvatar(
          backgroundColor: purpleColor,
          child: Icon(icon, color: Colors.white, size: 18)),
      title:
      Text(title, style: primaryTextStyle(color: Colors.white, size: 16)),
      trailing: Icon(Icons.arrow_right, color: limeColor, size: 24),
      onTap: onTap,
    );
  }
}

Future<void> showCustomLogoutDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Warning icon
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: purpleColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(height: 20),

              // Title
              Text(
                'Oh no, You are Leaving!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),

              // Subtitle
              Text(
                'Do you want to logout?',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Cancel Button
                  ElevatedButton(
                    onPressed: () {
                      hideKeyboard(context);
                      finish(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: white,
                      side: BorderSide(color: Colors.white54),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: black),
                    ),
                  ),
                  SizedBox(width: 12),

                  // Logout Button
                  ElevatedButton(
                    onPressed: () {
                      hideKeyboard(context);
                      AuthScreen().launch(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
