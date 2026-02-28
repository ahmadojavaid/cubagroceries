import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../component/custom_Appbar.dart';
import '../component/video_card_list.dart';
import '../resources/bottom_navigation.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import 'Home/nutrition_screens/nutritent_screens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int selectedIndex = 0;
  List<String> tabs = ["All", "Workout", "Nutrition"];
  @override
  void initState() {
    super.initState();
    // Set status bar color once when the widget initializes
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Light icons for dark backgrounds
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Search",
        showBackButton: false,
        onBack: () {
          CustomBottomNavigation().launch(context);
        },
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                hintStyle: primaryTextStyle(color: white),
              ),
            ),
          ).paddingSymmetric(horizontal: 16),
          SizedBox(height: screenHeight * 0.02),
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
                          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
                          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? white : buttonColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              fontSize: screenWidth * 0.040,
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
          SizedBox(height: screenHeight * 0.03),
          if (selectedIndex == 0) allSearch(),
          if (selectedIndex == 1) workoutSearch(),
          if (selectedIndex == 2) nutritionSearch(),
        ],
      )),
    );
  }

  Widget allSearch() {
    return Column(
      children: [
        VideoCardList(list: recommendationDinnerMeal, isFood: true),
        DietListView(meals: recipesForYou).paddingSymmetric(horizontal: 16),
      ],
    );
  }

  Widget workoutSearch() {
    return Column(
      children: [SearchItemWidget(search: "Circuit"), SearchItemWidget(search: "Split"), SearchItemWidget(search: "Challenge"), SearchItemWidget(search: "Legs"), SearchItemWidget(search: "Cardio")],
    ).paddingSymmetric(horizontal: 12);
  }

  Widget nutritionSearch() {
    return Column(
      children: [SearchItemWidget(search: "Breakfast"), SearchItemWidget(search: "Yogourt"), SearchItemWidget(search: "Vegetarian"), SearchItemWidget(search: "Smoothie"), SearchItemWidget(search: "Chicken")],
    ).paddingSymmetric(horizontal: 12);
  }
}

class SearchItemWidget extends StatelessWidget {
  final String search;

  SearchItemWidget({required this.search});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return DoublePressBackWidget(
      message: 'Press Again to Exit',
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.04),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.search, color: limeColor),
                  backgroundColor: primaryColor,
                ),
                20.height,
                Text(
                  search,
                  style: primaryTextStyle(color: white, size:18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
