import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/challenges_card.dart';
import '../../../component/custom_Appbar.dart';
import '../../../component/feature_card.dart';
import '../../../resources/bottom_navigation.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/image.dart';
import 'challenges_splah.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selectedIndex = 0;
  bool showAllDiscussion = false;

  List<String> tabs = ["Discussion Forum", "Challenges"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingValue = screenWidth * 0.08;
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Community",
        onBack: () {
          CustomBottomNavigation().launch(context, isNewTask: true);
        },
      ),
      body: Column(
        children: [
          // Toggle Buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: paddingValue),
            child: Row(
              children: List.generate(tabs.length, (index) {
                bool isSelected = selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        showAllDiscussion = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? white : buttonColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tabs[index],
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
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

          SizedBox(height: screenHeight * 0.02),
          Expanded(
            child: selectedIndex == 0 ? (showAllDiscussion ? discussionForum(screenWidth) : mainDiscussionForum(screenWidth)) : challengesList(screenWidth),
          ),
        ],
      ),
    );
  }

  Widget mainDiscussionForum(double screenWidth) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: FeaturedWorkoutCard12(
              imagePath: workoutImage1,
              title: 'Functional Training',
              subtitle: 'Training Of The Day',
              duration: '45 Min',
              calories: '1450 Kcal',
              exercises: '5 Exercises',
            ).paddingSymmetric(horizontal: 16),
          ),

          24.height,

          // Forums Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Forums',
                style: boldTextStyle(size: 18, color: limeColor),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    showAllDiscussion = true;
                  });
                },
                child: Text(
                  "See All",
                  style: boldTextStyle(size: 16, color: limeColor),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),

          10.height,

          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF8E5FF0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  forumItem(
                    title: 'Strength Training Techniques',
                    subtitle: 'Discussion on training methods',
                    time: 'Today 17:05',
                  ),
                  Divider(color: Colors.white54),
                  forumItem(
                    title: 'Nutrition and Diet Strategies',
                    subtitle: 'Meal planning, supplementation preferences',
                    time: 'Today 17:05',
                  ),
                  Divider(color: Colors.white54),
                  forumItem(
                    title: 'Cardiovascular Fitness',
                    subtitle: 'About different types of cardio workouts',
                    time: 'Today 17:05',
                  ),
                  Divider(color: Colors.white54),
                  forumItem(
                    title: 'Flexibility and Mobility',
                    subtitle: 'Strategies for improving flexibility and joint mobility',
                    time: 'Today 17:05',
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: 16),
          ),
          20.height
        ],
      ),
    );
  }

  // Discussion Forum UI
  Widget discussionForum(double screenWidth) {
    return ListView.builder(
      itemCount: 4,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          margin: EdgeInsets.only(bottom: screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.yellow.shade400),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('images/athleto/icons/profilr.jpg'),
                radius: screenWidth * 0.06,
              ),
              SizedBox(width: screenWidth * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Madison", style: boldTextStyle(color: Colors.white, size: 18)),
                        Spacer(),
                        Icon(Icons.star, color: Colors.yellow, size: 18),
                      ],
                    ),
                    SizedBox(height: screenWidth * 0.01),
                    Text(
                      "Exploring the world of design and creativity – finding inspiration in everyday moments and sharing insights with the community",
                      style: secondaryTextStyle(color: Colors.white70, size: 13),
                    ),
                    SizedBox(height: screenWidth * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        infoChip(Icons.thumb_up, "30,254", screenWidth),
                        infoChip(Icons.comment, "12,254", screenWidth),
                        infoChip(Icons.share, "1,254", screenWidth),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget infoChip(IconData icon, String text, double screenWidth) {
    return Row(
      children: [
        Icon(icon, size:18, color: Colors.yellow),
        SizedBox(width: screenWidth * 0.015),
        Text(text, style: primaryTextStyle(color: Colors.white70, size: 18)),
      ],
    );
  }

  Widget forumItem({required String title, required String subtitle, required String time}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: boldTextStyle(color: Colors.white)),
              4.height,
              Text(subtitle, style: secondaryTextStyle(color: Colors.white70)),
            ],
          ),
        ),
        Text(time, style: secondaryTextStyle(color: Colors.white54)),
      ],
    );
  }

  Widget challengesList(double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Challenges and competitions",
            style: boldTextStyle(color: limeColor, size: 20),
          ).paddingSymmetric(horizontal: 16),
          SizedBox(
            height: 700,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: workoutList.length,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: ChallengesCard(
                    imagePath: workoutList[index].imagePath,
                    title: workoutList[index].title,
                    onTap: () {
                      CyclingChallengeScreen(
                        image: workoutList[index].imagePath,
                        title: workoutList[index].title,
                      ).launch(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
