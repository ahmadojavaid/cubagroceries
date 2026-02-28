import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/custom_Appbar.dart';
import '../../../component/excercise_list_item.dart';
import '../../../component/feature_card.dart';
import '../../../utils/colors.dart';
import '../../../utils/image.dart';
import 'community_screens.dart';

class ChallengesAScreen extends StatefulWidget {
  const ChallengesAScreen({super.key});

  @override
  State<ChallengesAScreen> createState() => _ChallengesAScreenState();
}

class _ChallengesAScreenState extends State<ChallengesAScreen> {
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Weekly Challenge",
        onBack: () {
          CommunityScreen().launch(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturedWorkoutCard(
              imagePath: workoutImage1,
              title: 'Functional Training',
              subtitle: 'Training Of The Day',
              duration: '45 Min',
              calories: '1450 Kcal',
              exercises: '5 Exercises',
            ),
            16.height,

            Text(
              "Round 1",
              style: boldTextStyle(size: 20, color: limeColor),
            ),
            4.height,
            SizedBox(
              height: 260,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ExerciseListItem(
                      title: "Dumbbell Rows",
                      duration: "00:30",
                      repetitions: "Repetition 3x",
                    ).paddingOnly(top: 15);
                  }),
            ),
            5.height,
            Text(
              "Round 2",
              style: boldTextStyle(size: 20, color: limeColor),
            ),
            // 16.height,
            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ExerciseListItem(
                      title: "Dumbbell Rows",
                      duration: "00:30",
                      repetitions: "Repetition 3x",
                    ).paddingOnly(top: 15);
                  }),
            )
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
