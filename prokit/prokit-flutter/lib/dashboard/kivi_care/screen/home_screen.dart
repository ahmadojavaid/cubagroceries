import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prokit_flutter/dashboard/kivi_care/component/user_info_component.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/body_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_care/utils/app_color.dart';
import 'package:prokit_flutter/dashboard/kivi_care/utils/app_images.dart';
import 'package:prokit_flutter/dashboard/kivi_care/utils/app_string.dart';

KiviCareAppColor kiviCareAppColor = KiviCareAppColor();
KiviCareAppString kiviCareAppString = KiviCareAppString();
KiviCareAppImages kiviCareAppImages = KiviCareAppImages();

class KiviCareHomeScreen extends StatefulWidget {
  const KiviCareHomeScreen({super.key});

  @override
  State<KiviCareHomeScreen> createState() => _KiviCareHomeScreenState();
}

class _KiviCareHomeScreenState extends State<KiviCareHomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: kiviCareAppColor.bgColor,
        body: Stack(
          children: [
            Container(height: 140, color: kiviCareAppColor.bgColor),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 58.0, left: 20, right: 20),
                  child: UserInfo(),
                ),
                const SizedBox(height: 20),
                Expanded(child: BodyContainer()),
              ],
            ),
            
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Center(
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: kiviCareAppColor.navigationBGColor,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      navItem(icon: Icons.home, label: 'Home', index: 0),
                      const SizedBox(width: 8),
                      navItem(
                        icon: Icons.calendar_today,
                        label: 'Bookings',
                        index: 1,
                      ),
                      const SizedBox(width: 8),
                      navItem(
                        icon: Icons.person_outline,
                        label: 'Profile',
                        index: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 10,
        ),
        decoration: isSelected
            ? BoxDecoration(
                color: kiviCareAppColor.bgColor,
                borderRadius: BorderRadius.circular(30),
              )
            : const BoxDecoration(),
        child: Row(
          children: [
            Icon(icon, color: kiviCareAppColor.constWhite, size: 20),
            if (isSelected && label.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  label,
                  style: TextStyle(
                    color: kiviCareAppColor.constWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
