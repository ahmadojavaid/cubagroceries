import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/health/component/circular_percent_indicator_component.dart';
import 'package:prokit_flutter/dashboard/health/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/health/utils/common.dart';

class WalkCardComponent extends StatelessWidget {
  const WalkCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 215,
          width: 171,
          decoration: decoratedContainerWidget(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: txtWidget(
                  healthAppString.walk,
                  13,
                  FontWeight.w400,
                  healthAppColors.iconColor,
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 148,
                width: 148,
                child: CircularPercentIndicator(
                  radius: 40,
                  lineWidth: 8.0,
                  percent: 0.7,
                  center: Text(
                    healthAppString.completedSteps,
                    textAlign: TextAlign.center,
                  ),
                  progressColor: healthAppColors.completedStep,
                  backgroundColor: healthAppColors.grey300,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            height: 30,
            width: 30,
            decoration: subDecoratedContainerWidget(),
            child: Image.network(
              healthAppImages.walkIcon,
              height: 19,
              color: healthAppColors.cardIconColor,
            ),
          ),
        ),
      ],
    );
  }
}
