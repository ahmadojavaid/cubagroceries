import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/health/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/health/utils/common.dart';


class CaloriesCardComponent extends StatelessWidget {
  const CaloriesCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 123,
      width: 171,
      decoration: decoratedContainerWidget(),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 69.0),
                child: txtWidget(
                  healthAppString.calories,
                  13,
                  FontWeight.w400,
                  healthAppColors.iconColor,
                ),
              ),
              SizedBox(height: 52),
              Padding(
                padding: const EdgeInsets.only(left: 7.0, top: 05),
                child: txtWidget(
                  healthAppString.kcal,
                  11,
                  FontWeight.w400,
                  healthAppColors.subtitleTXTColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0, top: 7),
                child: txtWidget(
                  healthAppString.burnedCal,
                  16,
                  FontWeight.w400,
                  healthAppColors.iconColor,
                ),
              ),
            ],
          ),
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              height: 30,
              width: 30,
              decoration: subDecoratedContainerWidget(),
              child: Image.network(
                healthAppImages.caloriesIcon,
                height: 19,
                color: healthAppColors.cardIconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
