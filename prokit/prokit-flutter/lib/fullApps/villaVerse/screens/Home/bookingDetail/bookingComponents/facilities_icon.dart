import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../../main.dart';
import '../../../../utils/colors.dart';

class FacilitiesIcon extends StatelessWidget {
  final String text;
  final IconData icon;

  const FacilitiesIcon({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: appStore.isDarkModeOn ? seconderyBlue : blueLight,
          ),
          child: Center(
            child: Icon(icon, color: primaryBlueColor, size: 20),
          ),
        ),
        5.height,
        Text(
          maxLines: 1,
          text,
        )
      ],
    );
  }
}
