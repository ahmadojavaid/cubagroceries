import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';
import '../utils/image.dart';

class FeaturedWorkoutCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String duration;
  final String calories;
  final String exercises;

  const FeaturedWorkoutCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.calories,
    required this.exercises,
  });

  @override
  State<FeaturedWorkoutCard> createState() => _FeaturedWorkoutCardState();
}

class _FeaturedWorkoutCardState extends State<FeaturedWorkoutCard> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.white10,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            //TODO:
            child: Image.network(
              widget.imagePath,
              fit: BoxFit.cover,
              height: 220,
              width: double.infinity,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withValues(alpha:0.5),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: limeColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              child: Text(
                widget.subtitle,
                style: boldTextStyle(size: 13, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Marquee(
                          child: Text(widget.title,
                              style: boldTextStyle(color: limeColor, size: 18)),
                        ),
                      ),
                      6.height,
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              color: Colors.white, size: 13),
                          4.width,
                          Text(widget.duration,
                              style: secondaryTextStyle(color: whiteColor)),
                          12.width,
                          const Icon(Icons.local_fire_department,
                              color: Colors.white, size: 13),
                          4.width,
                          Text(widget.calories,
                              style: secondaryTextStyle(color: whiteColor)),
                          12.width,
                          const Icon(Icons.list, color: Colors.white, size: 13),
                          4.width,
                          Text(widget.exercises,
                              style: secondaryTextStyle(color: whiteColor)),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    child: ImageIcon(AssetImage(star),
                        color: isFavourite ? limeColor : white, size: 20),
                    onTap: () {
                      setState(() {
                        isFavourite = !isFavourite;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedWorkoutCard12 extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String duration;
  final String calories;
  final String exercises;

  const FeaturedWorkoutCard12({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.calories,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(15),
        backgroundColor: Colors.white10,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              height: 420,
              width: double.infinity,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withValues(alpha:0.5),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: boldTextStyle(color: limeColor, size: 20)),
                      // 6.height,
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              color: Colors.white, size: 15),
                          4.width,
                          Text(duration,
                              style: secondaryTextStyle(color: whiteColor)),
                          12.width,
                          const Icon(Icons.local_fire_department,
                              color: Colors.white, size: 15),
                          4.width,
                          Text(calories,
                              style: secondaryTextStyle(color: whiteColor)),
                          12.width,
                          const Icon(Icons.list, color: Colors.white, size: 15),
                          4.width,
                          Text(exercises,
                              style: secondaryTextStyle(color: whiteColor)),
                        ],
                      ),
                    ],
                  ),
                  //TODO:
                  ImageIcon(AssetImage(star), color: Colors.yellow, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
