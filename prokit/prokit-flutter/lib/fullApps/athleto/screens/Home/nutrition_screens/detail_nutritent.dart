import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/custom_Appbar.dart';
import '../../../component/custom_button.dart';
import '../../../utils/colors.dart';
import '../../../utils/image.dart';
import 'nutritent_screens.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
        backgroundColor: scaffoldSecondaryDark,
        appBar: CustomAppBar(
          title: "Meal Plans",
          onBack: () => finish(context),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Avocado And Egg Toast',
                      style: boldTextStyle(color: limeColor, size: 24),
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: primaryColor, size: 14),
                        4.width,
                        Text('15 Minutes', style: secondaryTextStyle(color: Colors.white54, size:14)),
                        16.width,
                        Icon(Icons.local_fire_department, color: primaryColor, size: 14),
                        4.width,
                        Text('150 Cal', style: secondaryTextStyle(color: Colors.white54, size: 14)),
                      ],
                    ),
                    10.height,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      //TODO:
                      child: Image.network(
                        workoutImage1,
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ).center().paddingSymmetric(vertical: screenHeight * 0.02),
                    20.height,
                    Text(
                      'Ingredients',
                      style: boldTextStyle(color: Colors.yellowAccent, size: 18),
                    ),
                    8.height,
                    UnorderedList(['Wholemeal bread', 'Ripe avocado slices', 'Fried or poached egg']),
                    26.height,
                    Text(
                      'Preparation',
                      style: boldTextStyle(color: Colors.yellowAccent, size: 18),
                    ),
                    8.height,
                    Text(
                      """Toast the Bread: Start by toasting the wholemeal bread slices until they are golden brown and crisp.Prepare the Avocado: While the bread is toasting, mash the ripe avocado slices in a bowl. Add a pinch of salt, pepper, and a drizzle of lemon juice for extra flavor.Cook the Egg: If you prefer a poached egg, bring a pot of water to a gentle simmer and add a splash of vinegar. Crack the egg into the water and let it cook for about 3–4 minutes until the whites are set but the yolk is still runny. If you prefer a fried egg, heat a small pan with oil or butter, crack the egg, and cook until the whites are firm but the yolk remains soft.
                        """,
                      style: primaryTextStyle(color: Colors.white54, size: 16),
                    ),
                    32.height,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.03),
                  child: CustomButton(
                      text: "Save Recipes",
                      onPressed: () {
                        NutritentScreens().launch(context, isNewTask: true);
                      })),
            ),
          ],
        )));
  }
}

class UnorderedList extends StatelessWidget {
  final List<String> items;

  UnorderedList(this.items);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• ', style: primaryTextStyle(color: Colors.white54, size: 16)),
            Expanded(
              child: Text(item, style: primaryTextStyle(color: Colors.white54, size: 16)),
            ),
          ],
        ).paddingBottom(4);
      }).toList(),
    );
  }
}
