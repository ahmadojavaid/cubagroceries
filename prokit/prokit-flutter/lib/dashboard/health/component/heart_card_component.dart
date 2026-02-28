import 'package:flutter/material.dart';

import 'package:prokit_flutter/dashboard/health/component/wavy_chat_component.dart';
import 'package:prokit_flutter/dashboard/health/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/health/utils/common.dart';

class StepsCardComponent extends StatelessWidget {
  const StepsCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 264,
          width: 171,
          decoration: decoratedContainerWidget(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 69.0, top: 17),
                child: txtWidget(
                  healthAppString.heart,
                  13,
                  FontWeight.w400,
                  healthAppColors.iconColor,
                ),
              ),
              SizedBox(height: 40),
              Center(child: WavyChart()),
              SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: txtWidget(
                  healthAppString.steps,
                  11,
                  FontWeight.w400,
                  healthAppColors.subtitleTXTColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0),
                child: txtWidget(
                  healthAppString.stepsForHeart,
                  16,
                  FontWeight.w400,
                  healthAppColors.iconColor,
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
              healthAppImages.heartIcon,
              height: 19,
              color: healthAppColors.cardIconColor,
            ),
          ),
        ),
      ],
    );
  }
}
