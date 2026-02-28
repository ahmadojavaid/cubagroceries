import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/health/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/health/utils/common.dart';

class TopAppbar extends StatelessWidget {
  const TopAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: healthAppColors.bgColor,
        boxShadow: [
          BoxShadow(
            color: healthAppColors.boxShadow,
            offset: const Offset(0, 10),
            blurRadius: 9,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconsWidget(healthAppImages.drawer, 24, healthAppColors.iconColor),
            txtWidget(
              healthAppString.appbarTitle,
              20,
              FontWeight.w400,
              healthAppColors.iconColor,
            ),
            CircleAvatar(backgroundImage: NetworkImage(healthAppImages.userProfile)),
          ],
        ),
      ),
    );
  }
}
