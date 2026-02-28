import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class ExerciseInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String reps;
  final String level;

  const ExerciseInfoCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.reps,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(20),
        backgroundColor: limeColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: boldTextStyle(size: 25)),
          4.height,
          Text(description,
              style: primaryTextStyle(size: 18),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          8.height,
          Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: BorderRadius.circular(20),
              backgroundColor: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.timer, size: 16, color: Colors.black),
                      4.width,
                      Flexible(
                        // In case the text is long
                        child: Text(time,
                            style: primaryTextStyle(size: 16),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fitness_center, size: 16, color: Colors.black),
                      4.width,
                      Flexible(
                        child: Text(reps,
                            style: primaryTextStyle(size: 16),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.directions_run, size: 16, color: Colors.black),
                      4.width,
                      Flexible(
                        child: Text(level,
                            style: primaryTextStyle(size: 16),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
