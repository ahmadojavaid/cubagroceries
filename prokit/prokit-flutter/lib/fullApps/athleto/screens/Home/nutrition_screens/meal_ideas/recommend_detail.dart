import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../component/custom_Appbar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/image.dart';

class RecommendDetailScreen extends StatelessWidget {
  final String imagePath;
  final String title;

  const RecommendDetailScreen({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(
        title: "Meal Ideas",
        onBack: () => finish(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: boldTextStyle(size: 30, color: limeColor),
                ),
                Observer(builder: (_) {
                  bool isFav = favoriteStore.isFavorite(title);
                  return GestureDetector(
                    onTap: () {
                      favoriteStore.toggleFavorite({"title": title, "image": imagePath, 'type': "Video"});
                    },
                    child: ImageIcon(AssetImage(star), color: isFav ? Colors.yellow : Colors.white, size: 20),
                  );
                })
              ],
            ).paddingSymmetric(horizontal: 20),
            8.height,
            Row(
              children: [
                Icon(Icons.access_time, color: purpleColor, size: 16),
                4.width,
                Text("12 Minutes", style: secondaryTextStyle(color: Colors.white70, size: 15)),
                16.width,
                Icon(Icons.local_fire_department, color: purpleColor, size: 16),
                4.width,
                Text("120 Cal", style: secondaryTextStyle(color: Colors.white70, size: 15)),
              ],
            ).paddingSymmetric(horizontal: 20),
            16.height,
            Container(
              // color: Colors.purpleAccent,
              padding: EdgeInsets.only(left: 26, right: 26),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        //TODO:
                        Image.network(
                          imagePath,
                          height: 550,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            //TODO:
                            child: ImageIcon(
                              AssetImage(play),
                              color: white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            16.height,
            Text("Ingredients", style: boldTextStyle(size: 18, color: Colors.yellow)).paddingSymmetric(horizontal: 16),
            8.height,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• 1/2 cup plain Greek yogurt", style: primaryTextStyle(color: Colors.white70)),
                4.height,
                Text("• 1/2 cup almond milk or your favorite milk", style: primaryTextStyle(color: Colors.white70)),
                4.height,
                Text("• Honey or maple syrup (optional, to sweeten to taste)", style: primaryTextStyle(color: Colors.white70)),
              ],
            ).paddingSymmetric(horizontal: 16),
            16.height,
          ],
        ),
      ),
    );
  }
}
