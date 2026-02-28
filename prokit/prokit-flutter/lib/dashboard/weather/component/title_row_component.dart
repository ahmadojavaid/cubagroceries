import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/weather/screens/home_screeen.dart';
import 'package:prokit_flutter/dashboard/weather/utils/common.dart';


class TitleRowComponent extends StatelessWidget {
  const TitleRowComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          txtWidget(weatherAppString.forecastHourly, 14, FontWeight.w600, weatherAppColors.white),
          txtWidget(weatherAppString.forecastweekly, 14, FontWeight.w600, weatherAppColors.white),    
        ],
      ),
    );
  }
}