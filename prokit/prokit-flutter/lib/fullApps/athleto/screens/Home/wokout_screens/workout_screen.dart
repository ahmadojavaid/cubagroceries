import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/custom_Appbar.dart';
import '../../../component/diet_card.dart';
import '../../../component/feature_card.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/image.dart';
import 'workout_video_list.dart';

class WorkoutScreen extends StatefulWidget {
  WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int selectedIndex = 0;

  List<String> tabs = ["Beginner", "Intermediate", "Advanced"];

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Workout",
        onBack: () {
          finish(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(tabs.length, (index) {
                      bool isSelected = selectedIndex == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 9),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? white : buttonColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? purpleColor : white,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            20.height,
            if (selectedIndex == 0) beginnerWorkout(),
            if (selectedIndex == 1) intermediateWorkout(),
            if (selectedIndex == 2) advancedWorkouts(),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget beginnerWorkout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: () {
              ExcerciseVideo(
                image: workoutImage1,
                title: "Beginner",
              ).launch(context);
            },
            child: FeaturedWorkoutCard(
              imagePath: workoutImage1,
              title: 'Functional Training',
              subtitle: 'Training Of The Day',
              duration: '45 Min',
              calories: '1450 Kcal',
              exercises: '5 Exercises',
            )),
        15.height,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Let's Go Beginner", style: boldTextStyle(color: limeColor, size: 18)),
            Text("Explore Different Workout Styles", style: secondaryTextStyle(color: Colors.white54, size: 14)),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.650,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: workoutCardList.length,
            itemBuilder: (context, index) {
              return DietCard(recommadationMeal: workoutCardList, index: index);
            },
          ),
        ),
      ],
    );
  }

  Widget intermediateWorkout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            ExcerciseVideo(
              image: challengesImage,
              title: "Intermediate",
            ).launch(context);
          },
          child: FeaturedWorkoutCard(
            imagePath: workoutImage3,
            title: 'Cardio Fitness',
            subtitle: 'Training Of The Day',
            duration: '45 Min',
            calories: '1450 Kcal',
            exercises: '5 Exercises',
          ),
        ),

        15.height,

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Keep Rising your level", style: boldTextStyle(color: limeColor, size: 18)),
            Text("Explore intermediate workouts", style: secondaryTextStyle(color: Colors.white54, size: 14)),
          ],
        ),

        // 10.height,
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: intermediateWorkouts.length,
                itemBuilder: (context, index) {
                  return DietCard(recommadationMeal: intermediateWorkouts, index: index);
                }))
      ],
    );
  }

  Widget advancedWorkouts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            ExcerciseVideo(
              image: advanceImage4,
              title: "Advanced",
            ).launch(context);
          },
          child: FeaturedWorkoutCard(
            imagePath: advanceImage4,
            title: 'Cardio Fitness',
            subtitle: 'Training Of The Day',
            duration: '45 Min',
            calories: '1450 Kcal',
            exercises: '5 Exercises',
          ),
        ),
        15.height,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Keep Rising your level", style: boldTextStyle(color: limeColor, size: 18)),
            Text("Explore intermediate workouts", style: secondaryTextStyle(color: Colors.white54, size: 14)),
          ],
        ),
        // 10.height,
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: advancedWorkout.length,
                itemBuilder: (context, index) {
                  return DietCard(recommadationMeal: advancedWorkout, index: index);
                }))
      ],
    );
  }
}
