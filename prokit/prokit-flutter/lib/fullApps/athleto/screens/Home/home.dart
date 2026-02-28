import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/Article_card.dart';
import '../../component/video_card_list.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/image.dart';
import '../notification_screen.dart';
import '../progrees/article_tip_screen.dart';
import '../progrees/details_article_tips.dart';
import 'community_screens/community_screens.dart';
import 'nutrition_screens/nutritent_screens.dart';
import 'progress_tracking/progress_tracking_screen.dart';
import 'wokout_screens/seeAll_recommedndation.dart';
import 'wokout_screens/workout_screen.dart';

class FitnessDashboardScreen extends StatefulWidget {
  const FitnessDashboardScreen({super.key});

  @override
  State<FitnessDashboardScreen> createState() => _FitnessDashboardScreenState();
}

class _FitnessDashboardScreenState extends State<FitnessDashboardScreen> {
  int _current = 0;

  final List<Map<String, String>> challenges = [
    {
      'title': 'Plank With Hip Twist',
      'subtitle': 'Weekly Challenge',
      'imagePath': articleImage4,
    },
    {
      'title': 'Plank With Hip Twist',
      'subtitle': 'Weekly Challenge',
      'imagePath': articleImage4,
    },
    {
      'title': 'Plank With Hip Twist',
      'subtitle': 'Weekly Challenge',
      'imagePath': articleImage4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
        backgroundColor: scaffoldSecondaryDark,
        body: SafeArea(
          child: SingleChildScrollView(
            // padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi, Madison ',
                            style: boldTextStyle(size: 23, color: purpleColor)),
                        Text("It's time to challenge your limits.",
                            style: secondaryTextStyle(
                                color: Colors.white70, size: 16)),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          NotificationsScreen().launch(context);
                        },
                        child: Icon(Icons.notifications, color: purpleColor)
                            .paddingSymmetric(horizontal: 8)),
                  ],
                ).paddingSymmetric(horizontal: 16),
                14.height,

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                            onTap: () {
                              WorkoutScreen().launch(context);
                            },
                            child: _categoryItem(workoutIcon, 'Workout')
                          ),
                      ),
                      Container(
                        height: 40,
                        width: 3,
                        decoration: boxDecorationDefault(color: purpleColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                            onTap: () {
                              ProgreesScreen().launch(context);
                            },
                            child:
                                _categoryItem(progressIcon, 'Progress Tracking')),
                      ),
                      Container(
                        height: 40,
                        width: 3,
                        decoration: boxDecorationDefault(color: purpleColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                            onTap: () {
                              NutritentScreens().launch(context);
                            },
                            child: _categoryItem(nutrientIcon, 'Nutrition')),
                      ),
                      Container(
                        height: 40,
                        width: 3,
                        decoration: boxDecorationDefault(color: purpleColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                            onTap: () {
                              CommunityScreen().launch(context);
                            },
                            child: _categoryItem(communityIcon, 'Community')),
                      ),
                    ],
                  ),
                ),
                18.height,

                // Recommendations Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recommenddation',
                            style: boldTextStyle(color: limeColor, size: 18))
                        .paddingSymmetric(horizontal: 16),
                    TextButton(
                        onPressed: () {
                          SeeallRecommedndation().launch(context);
                        },
                        child: Text(
                          "See All",
                          style:
                              primaryTextStyle(color: Colors.white, size: 16),
                        ).paddingRight(15))
                  ],
                ),
                10.height,
                VideoCardList(isFood: false, list: mainWorkout),
                10.height,
                // Weekly Challenge Section
                CarouselSlider.builder(
                  itemCount: challenges.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        color: purpleColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Weekly \nChallenge',
                                    style: boldTextStyle(
                                        color: limeColor, size: 25),
                                  ),
                                  2.height,
                                  Text(
                                    'Plank With Hip Twist',
                                    style: secondaryTextStyle(
                                        color: Colors.white, size: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                              //TODO:
                              child: Image.network(
                                articleImage4,
                                fit: BoxFit.cover,
                                height: 170,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 170,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                5.height,

                /// Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: challenges.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => setState(() => _current = entry.key),
                      child: Container(
                        width: _current == entry.key ? 16.0 : 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == entry.key
                              ? primaryColor
                              : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Articles & Tips',
                            style: boldTextStyle(color: limeColor, size: 18))
                        .paddingSymmetric(horizontal: 16),
                    TextButton(
                        onPressed: () {
                          ArticleTipScreen().launch(context);
                        },
                        child: Text(
                          "See All",
                          style:
                              primaryTextStyle(color: Colors.white, size: 16),
                        ).paddingRight(15))
                  ],
                ),

                SizedBox(
                  height: 174,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: articleList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            right: 16, left: index == 0 ? 16 : 0),
                        child: ArticleCard(
                          image: articleList[index].imagePath,
                          title: articleList[index].title,
                          isFavorite: false,
                          onTap: () {
                            DetailArticleScreen(
                              imagePath: articleList[index].imagePath,
                              title: articleList[index].title,
                            ).launch(context);
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _categoryItem(String image, String title) {
    return Column(
      children: [
        ImageIcon(AssetImage(image), color: purpleColor, size: 25),
        4.height,
        Text(title, style: secondaryTextStyle(color: Colors.white)),
      ],
    );
  }
}
