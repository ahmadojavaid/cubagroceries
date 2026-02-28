import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/fullApps/athleto/utils/colors.dart';

import '../utils/constant.dart';
import '../utils/image.dart';

class ChallengesCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? onTap;

  const ChallengesCard({super.key, required this.imagePath, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: boxDecorationWithRoundedCorners(
          borderRadius: BorderRadius.circular(width * 0.05),
          backgroundColor: buttonColor,
        ),
        padding: EdgeInsets.only(left: width * 0.04),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: width * 0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: boldTextStyle(size: 18, color: white)),
                    SizedBox(height: height * 0.01),
                    Text(
                      "Boost your endurance and burn calories with an intense cycling session.",
                      style: primaryTextStyle(color: white, size: 12),
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
                    imagePath,
                    width: width * 0.4,
                    height: height * 0.16,
                    fit: BoxFit.cover,
                  ),
                ),
                Observer(builder: (_) {
                  bool isFav = favoriteStore.isFavorite(title);
                  return Positioned(
                    top: height * 0.01,
                    right: width * 0.02,
                    child: GestureDetector(
                      onTap: () {
                        favoriteStore.toggleFavorite({"title": title, "image": imagePath, 'type': "Article"});
                      },
                      //TODO:
                      child: ImageIcon(
                        AssetImage(star),
                        color: isFav ? Colors.yellow : white,
                        size: 30,
                      ),
                    ),
                  );
                })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
