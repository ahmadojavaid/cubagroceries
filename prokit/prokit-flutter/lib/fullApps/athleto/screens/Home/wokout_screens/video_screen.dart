import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/custom_Appbar.dart';
import '../../../component/excercise_info_card.dart';
import '../../../utils/colors.dart';
import '../../../utils/image.dart';

class WorkoutVideo extends StatefulWidget {
  final String title;

  const WorkoutVideo({super.key, required this.title});

  @override
  State<WorkoutVideo> createState() => _WorkoutVideoState();
}

class _WorkoutVideoState extends State<WorkoutVideo> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
        backgroundColor: scaffoldSecondaryDark,
        appBar: CustomAppBar(
          title: widget.title,
          onBack: () {
            finish(context);
          },
        ),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      //TODO:
                      child: Image.network(
                        videoImage,
                        height: 550,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: primaryColor,
                      //TODO:
                      child: ImageIcon(
                        AssetImage(play),
                        size: 40,
                        color: white,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavourite = !isFavourite;
                          });
                        },
                        //TODO:
                        child: ImageIcon(
                          AssetImage(star),
                          size: 30,
                          color: isFavourite ? Colors.yellow : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              16.height,
              ExerciseInfoCard(
                title: 'Pull Lateral Band Walks',
                description: 'Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. Sed Cursus Libero Eget.',
                time: '10 Seconds',
                reps: '2 Rep',
                level: 'Beginner',
              ),
              40.height
            ],
          ).paddingSymmetric(horizontal: 16),
        ));
  }

  Widget infoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black),
          6.width,
          Text(text, style: primaryTextStyle(size: 14)),
        ],
      ),
    );
  }
}
