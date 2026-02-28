import 'dart:math';
import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/health/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/health/utils/common.dart';

class WaterCardComponent extends StatelessWidget {
  WaterCardComponent({super.key});
  final random = Random();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 215,
          width: 171,
          decoration: decoratedContainerWidget(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 69.0, top: 8),
                child: txtWidget(
                  healthAppString.water,
                  13,
                  FontWeight.w400,
                  healthAppColors.iconColor,
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: 100,
                  width: 132,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(10, (index) {
                      double maxHeight = 100;
                      double progress = random.nextDouble() * maxHeight;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: 4,
                              height: maxHeight,
                              decoration: BoxDecoration(
                                color: healthAppColors.barChat1,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Container(
                              width: 4,
                              height: progress,
                              decoration: BoxDecoration(
                                color: healthAppColors.barChat2,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: txtWidget(
                  healthAppString.liters,
                  11,
                  FontWeight.w400,
                  healthAppColors.subtitleTXTColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 6),
                child: txtWidget(
                  healthAppString.waterQuantity,
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
              healthAppImages.waterBottle,
              height: 19,
              color: healthAppColors.cardIconColor,
            ),
          ),
        ),
      ],
    );
  }
}
