import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/challenges_card.dart';
import '../../component/custom_Appbar.dart';
import '../../component/diet_card.dart';
import '../../model/meal_model.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  int selectedIndex = 0;
  List<String> tabs = ["All", "Video", "Article"];

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        showBackButton: false,
        title: "Favourites",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text("Sort by:", style: primaryTextStyle(color: limeColor)),
                  SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(tabs.length, (index) {
                      bool isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: isSelected ? white : buttonColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected ? purpleColor : white,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                List<Map<String, String>> favoriteItems = favoriteStore.favoriteItems;

                List<Map<String, String>> filteredFavorites = favoriteItems.where((item) {
                  bool isCategoryMatch = selectedIndex == 0 || item["type"] == tabs[selectedIndex];
                  return isCategoryMatch;
                }).toList();

                return filteredFavorites.isEmpty
                    ? Center(child: Text("No favourites found", style: primaryTextStyle(color: Colors.white, size: 20)))
                    : ListView.builder(
                        itemCount: filteredFavorites.length,
                        itemBuilder: (context, index) {
                          var item = filteredFavorites[index];
                          if (item["type"] == "Article") {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: ChallengesCard(
                                imagePath: item["image"] ?? '',
                                title: item["title"] ?? '',
                                onTap: () {},
                              ),
                            );
                          }

                          // If it's a Video, show `DietCard`
                          else if (item["type"] == "Video") {
                            return Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: DietCard(
                                index: index,
                                recommadationMeal: filteredFavorites.map((e) => Meal.fromMap(e)).toList(),
                              ),
                            );
                          }

                          return SizedBox();
                        }).paddingSymmetric(horizontal: 16);
              },
            ),
          ),
        ],
      ),
    );
  }
}
