import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/help_center_screen.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/language_screen.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/payment_methods_account_screen.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/personal_info_screen.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/saved_address_screen.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/security_screen.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/account/screen/vouchers_and_discount.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../components/account_list_component.dart';
import 'about_caffely_screen.dart';
import 'caffely_points_screen.dart';
import 'caffely_reward_screen.dart';
import 'favorit_cofee_screen.dart';
import 'notification_account_screen.dart';

class AccountHomeScreen extends StatefulWidget {
  const AccountHomeScreen({super.key});

  @override
  State<AccountHomeScreen> createState() => _AccountHomeScreenState();
}

class _AccountHomeScreenState extends State<AccountHomeScreen> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(Images.ic_appIcon, width: 30, height: 30),
                const SizedBox(width: 100),
                const Center(
                  child: Text(
                    "Account",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    Images.img_user,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Andrew Ainsley", style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text("andrew.ainsley@yourdomain.com"),
                        ],
                      ),
                      Icon(Icons.qr_code),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: PickColor.borderColor),
            const SizedBox(height: 10),

            // Account List Section
            Column(
              children: [
                AccountListComponent(
                  name: 'Vouchers & Discounts',
                  image: Images.ic_offer,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const VouchersAndDiscount()),
                    );
                  },
                ),
                AccountListComponent(
                  name: 'Caffely Points',
                  image: Images.ic_points,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CaffelyPointsScreen()),
                    );
                  },
                ),
                AccountListComponent(
                  name: 'Caffely Rewards',
                  image: Images.ic_ticket,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CaffelyRewardScreen()),
                    );
                  },
                ),
                AccountListComponent(
                  name: 'Favorite Coffee',
                  image: Images.ic_coffee,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritCofeeScreen()),
                    );
                  },
                ),
                AccountListComponent(
                  name: 'Saved Address',
                  image: Images.ic_location,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SavedAddressScreen()),
                    );
                  },
                ),
                AccountListComponent(
                  name: 'Payment Methods',
                  image: Images.ic_creaditcard,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PaymentMethodAccountScreen()),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "General",
                  style: TextStyle(fontSize: 15, color: PickColor.greyColor),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Divider(color: PickColor.borderColor, thickness: 1.0),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // General List Section
            Column(
              children: [
                AccountListComponent(
                  name: 'Personal Info',
                  image: Images.ic_user,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PersonalInfoScreen()),
                    );
                  },
                ),
                AccountListComponent(
                  name: 'Notification',
                  image: Images.ic_notification,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NotificationAccountScreen()),
                    );
                  },
                ),
                AccountListComponent(
                  name: 'Security',
                  image: Images.ic_secuirity,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecurityScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LanguageScreen()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            Images.ic_language,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Language",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Text("English(US)"),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward_ios, size: 15),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(Images.ic_theme, height: 20, width: 20),
                          const SizedBox(width: 15),
                          const Text(
                            "Dark Mode",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Transform.scale(
                        scale: 0.8, // Adjust this value to change the size (e.g., 1.5 for 150%)
                        child: Switch(
                          value: isActive, // Make sure to pass the current state of `isActive`
                          onChanged: (value) {
                            setState(() {
                              isActive = !isActive; // Update `isActive` based on switch toggle
                            });
                          },
                          activeTrackColor: PickColor.brownColor,
                          activeColor: PickColor.whiteColor,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("About", style: TextStyle(fontSize: 15, color: PickColor.greyColor)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Divider(
                        color: PickColor.borderColor,
                        thickness: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                AccountListComponent(
                  name: 'Help Center',
                  image: Images.ic_creaditcard,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
                    );
                  },
                ),
                AccountListComponent(
                  name: 'About Caffely',
                  image: Images.ic_info,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutCaffelyScreen()),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.logout, color: PickColor.orange),
                    SizedBox(width: 10),
                    Text(
                      "Logout",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: PickColor.orange),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
