import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/profile/view/payment_method.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/profile/view/privacy_policy_screen.dart';
import 'package:prokit_flutter/fullApps/stayNest/screen/profile/view/terms_conditions_screen.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';
import '../../auth/view/new_password_screen.dart';
import '../../auth/view/sign_in_screen.dart';
import '../../home/view/recently_booking.dart';
import '../components/profile_header.dart';
import '../components/profile_tile.dart';
import 'edit_screen.dart';

class ProfileScreenState extends StatefulWidget {
  const ProfileScreenState({super.key});

  @override
  State<ProfileScreenState> createState() => _ProfileScreenStateState();
}

class _ProfileScreenStateState extends State<ProfileScreenState> {
  @override
  void initState() {
    super.initState();
    setStatusBarColor(Colors.transparent, statusBarIconBrightness: Brightness.light);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "My Profile",
            style: TextStyle(color: white),
          ),
          centerTitle: true,
          backgroundColor: stayNestPrimaryColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
        body: Column(
          children: [
            ProfileHeader(
              name: 'Curtis Weaver',
              email: 'curtis.weaver@example.com',
              onEdit: () => EditProfileScreen().launch(context),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 10),
                children: [
                  ProfileTile(
                    icon: Icons.edit_outlined,
                    title: "Edit Profile",
                    onTap: () => EditProfileScreen().launch(context),
                  ),
                  dividerWidget(),
                  ProfileTile(
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    onTap: () => NewPasswordScreen().launch(context),
                  ),
                  dividerWidget(),
                  ProfileTile(
                    icon: Icons.credit_card,
                    title: "Payment Method",
                    onTap: () {
                      PaymentMethodsScreen().launch(context);
                    },
                  ),
                  dividerWidget(),
                  ProfileTile(
                    icon: Icons.book_online_outlined,
                    title: "My Bookings",
                    onTap: () => RecentlyBooking().launch(context),
                  ),
                  dividerWidget(),
                  Observer(
                    builder: (_) => SwitchListTile(
                      title: Text(
                        "Dark Mode",
                        style: primaryTextStyle(size: 16),
                      ),
                      value: appStore.isDarkModeOn,
                      activeColor: stayNestPrimaryColor,
                      onChanged: (value) {
                        appStore.toggleDarkMode(value: value);
                      },
                      secondary: const Icon(Icons.remove_red_eye_outlined),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                  ),
                  dividerWidget(),
                  ProfileTile(
                    icon: Icons.privacy_tip_outlined,
                    title: "Privacy Policy",
                    onTap: () => PrivacyPolicyScreen().launch(context),
                  ),
                  dividerWidget(),
                  ProfileTile(
                    icon: Icons.description_outlined,
                    title: "Terms & Conditions",
                    onTap: () => TermsConditionsScreen().launch(context),
                  ),
                  dividerWidget(),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: appStore.isDarkModeOn ? blackColor : whiteColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: appStore.isDarkModeOn ? const Color.fromARGB(255, 83, 82, 82) : whiteColor,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.logout, color: stayNestPrimaryColor, size: 40),
                          24.height,
                          const Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          24.height,
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    side: MaterialStateProperty.all(
                                      BorderSide(color: stayNestPrimaryColor),
                                    ),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: stayNestPrimaryColor),
                                  ),
                                ),
                              ),
                              12.width,
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close dialog
                                    LoginScreen().launch(
                                      context,
                                    ); // Navigate to login
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      stayNestPrimaryColor,
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    side: MaterialStateProperty.all(
                                      BorderSide(color: stayNestPrimaryColor),
                                    ),
                                  ),
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ).paddingAll(16),
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text("Logout", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: stayNestPrimaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ).paddingAll(16),
          ],
        ),
      );
    });
  }

  Widget dividerWidget() => Divider(
        height: 1,
        thickness: 1,
        color: Color(0x33000000),
      ).paddingSymmetric(horizontal: 16);
}
