import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../component/custom_Appbar.dart';
import '../../../../component/feature_card.dart';
import '../../../../component/video_card_list.dart';
import '../../../../model/meal_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../nutritent_screens.dart';
import 'meal_idea_b.dart';

class MealIdeaAScreen extends StatefulWidget {
  const MealIdeaAScreen({super.key});

  @override
  State<MealIdeaAScreen> createState() => _MealIdeaAScreenState();
}

class _MealIdeaAScreenState extends State<MealIdeaAScreen> {
  List<String> meals = ["Breakfast", "Lunch", "Dinner"];
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Meal Idea",
        onBack: () {
          NutritentScreens().launch(context);
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          NutritentScreens().launch(context, isNewTask: true);
          return true;
        },
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            5.height,
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // Distribute tabs
                    children: List.generate(meals.length, (index) {
                      bool isSelected = selectedIndex == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? white : buttonColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              meals[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? purpleColor : white,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 25),
            16.height,
            if (selectedIndex == 0) breakfastContent(),
            if (selectedIndex == 1) lunchContent(),
            if (selectedIndex == 2) dinnerContent(),
          ],
        )),
      ),
    );
  }

  Widget breakfastContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            RecipeDetailsScreen123(
              imagePath: featuredRecipe.imagePath,
              title: featuredRecipe.title,
            ).launch(context);
          },
          child: FeaturedWorkoutCard(
            imagePath: featuredRecipe.imagePath,
            title: featuredRecipe.title,
            subtitle: featuredRecipe.duration,
            duration: featuredRecipe.calories,
            calories: featuredRecipe.calories,
            exercises: featuredRecipe.calories,
          ).paddingSymmetric(horizontal: 16),
        ),
        10.height,
        Text(
          "Recommended",
          style: boldTextStyle(size: 18, color: limeColor),
        ).paddingSymmetric(horizontal: 16),
        10.height,
        VideoCardList(
          list: recommendationMeal,
          isFood: true,
        ),
        10.height,
        Text("Recipes for You",
                style: boldTextStyle(size: 18, color: limeColor))
            .paddingSymmetric(horizontal: 16),
        DietListView(meals: recipesForYou).paddingSymmetric(horizontal: 16),
        20.height,
      ],
    );
  }

  Widget lunchContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            RecipeDetailsScreen123(
              imagePath: featuredLunchMeal.imagePath,
              title: featuredLunchMeal.title,
            ).launch(context);
          },
          child: FeaturedWorkoutCard(
            imagePath: featuredLunchMeal.imagePath,
            title: featuredLunchMeal.title,
            subtitle: featuredLunchMeal.duration,
            duration: featuredLunchMeal.calories,
            calories: featuredLunchMeal.calories,
            exercises: featuredLunchMeal.calories,
          ).paddingSymmetric(horizontal: 16),
        ),
        10.height,
        Text(
          "Recommended",
          style: boldTextStyle(size: 18, color: limeColor),
        ).paddingSymmetric(horizontal: 16),
        10.height,
        VideoCardList(
          isFood: true,
          list: recommendationLunchMeal,
        ),
        10.height,
        Text("Recipes for You",
                style: boldTextStyle(size: 18, color: limeColor))
            .paddingSymmetric(horizontal: 16),
        DietListView(meals: recipesForYouLunch)
            .paddingSymmetric(horizontal: 16),
        20.height,
      ],
    );
  }

  Widget dinnerContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            RecipeDetailsScreen123(
              imagePath: featuredDinnerMeal.imagePath,
              title: featuredDinnerMeal.title,
            ).launch(context);
          },
          child: FeaturedWorkoutCard(
            imagePath: featuredDinnerMeal.imagePath,
            title: featuredDinnerMeal.title,
            subtitle: featuredDinnerMeal.duration,
            duration: featuredDinnerMeal.calories,
            calories: featuredDinnerMeal.calories,
            exercises: featuredDinnerMeal.calories,
          ).paddingSymmetric(horizontal: 16),
        ),
        10.height,
        Text(
          "Recommended",
          style: boldTextStyle(size: 18, color: limeColor),
        ).paddingSymmetric(horizontal: 16),
        10.height,
        VideoCardList(
          isFood: true,
          list: recommendationDinnerMeal,
        ),
        10.height,
        Text("Recipes for You",
                style: boldTextStyle(size: 18, color: limeColor))
            .paddingSymmetric(horizontal: 16),
        DietListView(meals: recipesForYouDinner)
            .paddingSymmetric(horizontal: 16),
        20.height,
      ],
    );
  }
}
