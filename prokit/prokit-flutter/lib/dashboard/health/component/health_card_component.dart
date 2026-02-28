import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/health/component/calories_card_component.dart';
import 'package:prokit_flutter/dashboard/health/component/heart_card_component.dart';
import 'package:prokit_flutter/dashboard/health/component/sleep_card_component.dart';
import 'package:prokit_flutter/dashboard/health/component/walk_card_component.dart';
import 'package:prokit_flutter/dashboard/health/component/water_card_component.dart';


class HealthCards extends StatelessWidget {
  const HealthCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                WalkCardComponent(),
                SizedBox(width: 16),
                WaterCardComponent(),
              ],
            ),
          ),
        ),
        SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepsCardComponent(),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SleepCardComponent(),
                    SizedBox(height: 18),
                    CaloriesCardComponent(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
