import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';
import '../utils/constant.dart';
import '../utils/image.dart';

class DietCard extends StatelessWidget {
  final List recommadationMeal;
  final bool isFavorite;
  final int index;

  const DietCard({
    super.key,
    required this.recommadationMeal,
    required this.index,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: BorderRadius.circular(width * 0.04),
        backgroundColor: buttonColor,
      ),
      padding: EdgeInsets.only(left: width * 0.03),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: width * 0.034),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recommadationMeal[index].title,
                      style: boldTextStyle(size: 18, color: white)),
                  SizedBox(height: height * 0.01),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time_filled_outlined,
                              color: purpleColor, size: 12),
                          SizedBox(width: width * 0.01),
                          Text(
                            recommadationMeal[index].duration,
                            style: secondaryTextStyle(color: white, size: 14),
                          ),
                        ],
                      ),
                      8.width,
                      Expanded(
                        child: Row(
                          children: [
                            Icon(Icons.local_fire_department,
                                color: purpleColor, size: 15),
                            6.width,
                            Expanded(
                              // Needed to constrain Marquee
                              child: Marquee(
                                child: Text(
                                  recommadationMeal[index].calories,
                                  style: secondaryTextStyle(
                                      color: white, size: 14),
                                  overflow: TextOverflow.visible,
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(width * 0.06),
                  topLeft: Radius.circular(width * 0.06),
                  bottomRight: Radius.circular(width * 0.03),
                  topRight: Radius.circular(width * 0.03),
                ),
                //TODO:
                child: Image.network(
                  recommadationMeal[index].imagePath,
                  width: width * 0.4,
                  height: height * 0.15,
                  fit: BoxFit.cover,
                ),
              ),
              Observer(builder: (_) {
                bool isFav =
                    favoriteStore.isFavorite(recommadationMeal[index].title);
                return Positioned(
                  top: height * 0.01,
                  right: width * 0.02,
                  child: GestureDetector(
                    onTap: () {
                      favoriteStore.toggleFavorite(
                        {
                          "title": recommadationMeal[index].title,
                          "imagePath": recommadationMeal[index].imagePath,
                          "duration": recommadationMeal[index].duration,
                          "calories": recommadationMeal[index].calories,
                          "type": "Video",
                        },
                      );
                    },
                    //TODO:
                    child: ImageIcon(
                      AssetImage(star),
                      color: isFav ? Colors.yellow : Colors.white,
                      size: 25,
                    ),
                  ),
                );
              })
            ],
          ),
        ],
      ),
    ).paddingOnly(top: height * 0.015);
  }
}
