import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/custom_Appbar.dart';
import '../../../component/grid_video_card.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import 'workout_video_list.dart';

class SeeallRecommedndation extends StatelessWidget {
  const SeeallRecommedndation({super.key});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Recommendation",
        onBack: () {
          finish(context);
        },
      ),
      body: SingleChildScrollView(

        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Most Popular",
              style: boldTextStyle(color: limeColor, size: 20),
            ),
            workoutVideos(context)
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget workoutVideos(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.height,
        SizedBox(
          height: height * 0.8,
          child: GridView.builder(
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
}
