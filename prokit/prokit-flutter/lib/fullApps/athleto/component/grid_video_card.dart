import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/image.dart';

class GridVideoCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String duration;
  final String calories;
  final bool? isFavorite;
  final VoidCallback? onPlayTap;

  const GridVideoCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.calories,
    this.onPlayTap,
    this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width * 0.45,
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(width * 0.05),
        backgroundColor: Colors.transparent,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * 0.05),
              topRight: Radius.circular(width * 0.05),
            ),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: height * 0.15,
            ),
          ),
          Positioned(
            top: height * 0.13,
            left: 0,
            right: 0,
            child: Container(
              decoration: boxDecorationWithRoundedCorners(
                backgroundColor: buttonColor,
                border: Border(
                  left: BorderSide(color: gray, width: 0.5),
                  right: BorderSide(color: gray, width: 0.5),
                  bottom: BorderSide(color: gray, width: 0.5),
                ),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.01, horizontal: width * 0.020),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  4.height,
                  Marquee(
                    direction: Axis.horizontal,
                    animationDuration: Duration(milliseconds: 100),
                    child: Text(title,
                        style: boldTextStyle(size: 16, color: limeColor)),
                  ),
                  5.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        // Wrap first row
                        child: Row(
                          children: [
                            Icon(Icons.access_time_filled_sharp,
                                color: purpleColor, size: 12),
                            SizedBox(width: width * 0.006),
                            Expanded(
                              // Constrain Marquee text inside
                              child: Marquee(
                                child: Text(
                                  duration,
                                  style: primaryTextStyle(
                                      color: Colors.white, size: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8), // Optional spacing between items
                      Flexible(
                        // Wrap second row
                        child: Row(
                          children: [
                            Icon(Icons.local_fire_department,
                                color: purpleColor, size: 12),
                            SizedBox(width: width * 0.0038),
                            Expanded(
                              child: Marquee(
                                child: Text(
                                  calories,
                                  style: primaryTextStyle(
                                      color: Colors.white, size: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: height * 0.008,
            right: width * 0.03,
            child: Observer(
              builder: (_) {
                bool isFav = favoriteStore.isFavorite(title);
                return GestureDetector(
                  onTap: () {
                    favoriteStore.toggleFavorite(
                      {
                        "title": title,
                        "imagePath": imagePath,
                        "duration": duration,
                        "calories": calories,
                        "type": "Video",
                      },
                    );
                  },
                  //TODO:
                  child: ImageIcon(AssetImage(star),
                      color: isFav ? Colors.yellow : Colors.white, size: 20),
                );
              },
            ),
          ),
          Positioned(
            bottom: height * 0.095,
            right: width * 0.015,
            child: GestureDetector(
              onTap: onPlayTap,
              child: Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.circular(width * 0.1),
                  backgroundColor: purpleColor,
                ),
                padding: EdgeInsets.all(width * 0.03),
                //TODO:
                child: ImageIcon(
                  AssetImage(play),
                  color: white,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
