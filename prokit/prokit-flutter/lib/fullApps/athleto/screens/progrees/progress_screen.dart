import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/challenges_card.dart';
import '../../component/custom_Appbar.dart';
import '../../component/grid_video_card.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../Home/wokout_screens/workout_video_list.dart';
import 'details_article_tips.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int selectedIndex = 0;
  List<String> tabs = ["Workout Videos", "Articles & Tips"];
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setStatusBarColor(
    //     Colors.transparent,
    //     statusBarIconBrightness: Brightness.light,
    //   );
    // });
  }
  @override
  Widget build(BuildContext context) {

    // setStatusBarColor(Colors.transparent,
    //     statusBarIconBrightness: Brightness.light);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Change to Brightness.dark if needed
    ));
    return Scaffold(
        backgroundColor: scaffoldSecondaryDark,
        appBar: CustomAppBar(
          title: "Resources",
          showBackButton: false,
      
        ),
        body:  AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child:
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: height * 0.01),
                              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected ? white : buttonColor,
                                borderRadius: BorderRadius.circular(width * 0.05),
                              ),
                              child: Text(
                                tabs[index],
                                style: TextStyle(
                                  fontSize: width * 0.040,
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
              SizedBox(height: height * 0.02),
              selectedIndex == 0 ? workoutVideos(context) : articleAndTips(),
            ],
          ).paddingSymmetric(horizontal: 16),
        ),
      ),
    );
  }

  Widget workoutVideos(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick & Easy Workout Videos",
          style: boldTextStyle(color: limeColor, size: 18),
        ),
        Text("Discover Fresh Workouts: Elevate Your Training", style: primaryTextStyle(size: 14, color: Colors.white)),
        SizedBox(height: height * 0.02),
        SizedBox(
          height: height * 1,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: recommendedList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: width * 0.038,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ExcerciseVideo(image: recommendedList[index].imagePath, title: recommendedList[index].title).launch(context);
                },
                child: GridVideoCard(
                  imagePath: recommendedList[index].imagePath,
                  title: recommendedList[index].title,
                  duration: recommendedList[index].duration,
                  calories: recommendedList[index].exercises,
                  isFavorite: recommendedList[index].isFavorite,
                  onPlayTap: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget articleAndTips() {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: height * 1,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: articleList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ChallengesCard(
                  imagePath: articleList[index].imagePath,
                  title: articleList[index].title,
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
    );
  }
}
