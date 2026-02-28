import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/Home/wokout_screens/video_screen.dart';
import '../utils/colors.dart';
import '../utils/image.dart';

class ExerciseListItem extends StatelessWidget {
  final String title;
  final String duration;
  final String repetitions;


  const ExerciseListItem({
    super.key,
    required this.title,
    required this.duration,
    required this.repetitions,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WorkoutVideo(
          title: title,
        ).launch(context);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: buttonColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: boxDecorationWithRoundedCorners(backgroundColor: primaryColor, borderRadius: BorderRadius.circular(20)),
              child: ImageIcon(AssetImage(play), color: Colors.white, size: 20),
            ),
            12.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: boldTextStyle(color: white),
                ),
                4.height,
                Row(
                  children: [
                    Icon(Icons.timer, size: 14, color: primaryColor),
                    4.width,
                    Text(
                      duration,
                      style: secondaryTextStyle(color: primaryColor),
                    ),
                  ],
                ),
              ],
            ).expand(),
            Text(
              repetitions,
              style: boldTextStyle(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
