import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/custom_Appbar.dart';
import '../../../component/excercise_list_item.dart';
import '../../../component/feature_card.dart';
import '../../../utils/colors.dart';

class ExcerciseVideo extends StatelessWidget {
  final String image;
  final String title;

  const ExcerciseVideo({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: title,
        onBack: () {
          finish(context);
        },
      ),
      body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeaturedWorkoutCard(
                imagePath: image,
                title: 'Functional Training',
                subtitle: 'Training Of The Day',
                duration: '45 Min',
                calories: '1450 Kcal',
                exercises: '5 Exercises',
              ),
              10.height,
              Text(
                "Round 1",
                style: boldTextStyle(size: 18, color: limeColor),
              ).paddingSymmetric(horizontal: 12),
              4.height,
              SizedBox(
                height: 260,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ExerciseListItem(
                        title: "Dumbbell Rows",
                        duration: "00:30",
                        repetitions: "Repetition 3x",
                      ).paddingOnly(top: 10);
                    }),
              ),
              Text(
                "Round 2",
                style: boldTextStyle(size: 18, color: limeColor),
              ).paddingSymmetric(horizontal: 12),
              SizedBox(
                height: 300,
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ExerciseListItem(
                        title: "Dumbbell Rows",
                        duration: "00:30",
                        repetitions: "Repetition 3x",
                      ).paddingOnly(top: 10);
                    }),
              )
            ],
          )).paddingSymmetric(horizontal: 16),
    );
  }
}
