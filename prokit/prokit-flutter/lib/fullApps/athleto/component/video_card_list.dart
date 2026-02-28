import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/Home/nutrition_screens/meal_ideas/recommend_detail.dart';
import '../screens/Home/wokout_screens/workout_video_list.dart';
import 'video_card.dart';

class VideoCardList extends StatelessWidget {
  final List list;
  final bool isFood;

  const VideoCardList({super.key, required this.list, required this.isFood});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: 16,
              left: index == 0 ? 16 : 0,
            ),
            child: GestureDetector(
              onTap: () {
                if (isFood) {
                  RecommendDetailScreen(
                          imagePath: list[index].imagePath,
                          title: list[index].title)
                      .launch(context);
                } else {
                  ExcerciseVideo(
                          image: list[index].imagePath,
                          title: list[index].title)
                      .launch(context);
                }
              },
              child: VideoCard(
                index: index,
                recommed: list,
                isFavorite: true,
                onPlayTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
