import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/image.dart';

class VideoCard extends StatelessWidget {
  final List recommed;
  final bool? isFavorite;
  final int index;
  final VoidCallback? onPlayTap;

  const VideoCard({
    super.key,
    required this.index,
    required this.recommed,
    this.onPlayTap,
    this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(20),
        backgroundColor: Colors.transparent,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.network(
              recommed[index].imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
          ),

          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Container(
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                backgroundColor: buttonColor,
                border: Border(),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recommed[index].title,
                      style: boldTextStyle(size: 17, color: Color(0xFFE2F163))),
                  5.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Icons.access_time, color: purpleColor, size: 15),
                        5.width,
                        Text(recommed[index].duration,
                            style:
                                primaryTextStyle(color: whiteColor, size: 14)),
                      ]),
                      Row(children: [
                        Icon(Icons.local_fire_department,
                            color: purpleColor, size: 15),
                        5.width,
                        Text(recommed[index].calories,
                            style:
                                primaryTextStyle(color: whiteColor, size: 14)),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 12,
            right: 12,
            child: Observer(
              builder: (_) {
                bool isFav = favoriteStore.isFavorite(recommed[index].title);
                return GestureDetector(
                  onTap: () {
                    favoriteStore.toggleFavorite({
                      "title": recommed[index].title,
                      "imagePath": recommed[index].imagePath,
                      "duration": recommed[index].duration,
                      "calories": recommed[index].calories,
                      "type": "Video"
                    });
                  },
                  //TODO:
                  child: ImageIcon(AssetImage(star),
                      color: isFav ? Colors.yellow : whiteColor, size: 20),
                );
              },
            ),
          ),

          // Play Button
          Positioned(
            bottom: 60,
            right: 15,
            child: GestureDetector(
              onTap: onPlayTap,
              child: Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.circular(50),
                  backgroundColor: purpleColor,
                ),
                padding: const EdgeInsets.all(12),
                //TODO:
                child:
                    const ImageIcon(AssetImage(play), color: white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
