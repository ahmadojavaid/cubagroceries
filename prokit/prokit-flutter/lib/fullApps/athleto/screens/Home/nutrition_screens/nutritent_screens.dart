import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/custom_Appbar.dart';
import '../../../component/diet_card.dart';
import '../../../component/feature_card.dart';
import '../../../component/video_card_list.dart';
import '../../../model/meal_model.dart';
import '../../../resources/bottom_navigation.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/image.dart';
import 'meal_ideas/meal_idea_b.dart';
import 'meal_ideas/meal_ideas_splash.dart';
import 'meal_plan/meal_plan_splash.dart';

class NutritentScreens extends StatefulWidget {
  const NutritentScreens({super.key});

  @override
  State<NutritentScreens> createState() => _NutritentScreensState();
}

class _NutritentScreensState extends State<NutritentScreens> {
  int selectedIndex = 0;
  List<String> tabs = ["Meal Plan", "Meal Ideas"];

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
        appBar: CustomAppBar(
          title: "Nutrition",
          onBack: () {
            CustomBottomNavigation().launch(context, isNewTask: true);
          },
        ),
        body: WillPopScope(
          onWillPop: () async {
            CustomBottomNavigation().launch(context);
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                if (index == 0) {
                                  MealPlanScreen().launch(context);
                                } else {
                                  MealIdeasScreen().launch(context);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
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
                ).paddingSymmetric(horizontal: 16),
                20.height,
                GestureDetector(
                  onTap: () {},
                  child: FeaturedWorkoutCard(
                    imagePath: workoutImage1,
                    title: 'Functional Training',
                    subtitle: 'Training Of The Day',
                    duration: '45 Min',
                    calories: '1450 Kcal',
                    exercises: '5 Exercises',
                  ).paddingSymmetric(horizontal: 16),
                ),
                15.height,
                Text(
                  "Recommended",
                  style: boldTextStyle(size: 18, color: limeColor),
                ).paddingSymmetric(horizontal: 16),
                8.height,
                VideoCardList(
                  isFood: true,
                  list: recommendationMeal,
                ),
                10.height,
                Text("Recipes for You", style: boldTextStyle(size: 18, color: limeColor)).paddingSymmetric(horizontal: 16),
                DietListView(meals: recipesForYou).paddingSymmetric(horizontal: 16).paddingOnly(bottom: 20),
              ],
            ),
          ),
        ));
  }
}

class DietListView extends StatelessWidget {
  final List<Meal> meals;

  const DietListView({super.key, required this.meals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            RecipeDetailsScreen123(
              imagePath: meals[index].imagePath,
              title: meals[index].title,
            ).launch(context);
          },
          child: DietCard(
            recommadationMeal: meals,
            index: index,
            isFavorite: false,
          ).paddingSymmetric(vertical: 5),
        );
      },
    );
  }
}
