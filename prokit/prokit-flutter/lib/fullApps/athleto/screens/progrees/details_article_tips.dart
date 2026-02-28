import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/custom_Appbar.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/image.dart';

class DetailArticleScreen extends StatelessWidget {
  final String imagePath;
  final String title;

  const DetailArticleScreen({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Colors.transparent,
        statusBarIconBrightness: Brightness.light);
    return Scaffold(
      backgroundColor: scaffoldSecondaryDark,
      appBar: CustomAppBar(title: "Articles & Tips", onBack: () => finish(context)),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: boldTextStyle(color: limeColor, size: 20)),
                Observer(builder: (_) {
                  bool isFav = favoriteStore.isFavorite(title);
                  return GestureDetector(
                    onTap: () {
                      favoriteStore.toggleFavorite({"title": title, "image": imagePath, 'type': "Article"});
                    },
                    child: ImageIcon(
                      AssetImage(star),
                      color: isFav ? Colors.yellow : white,
                    ).paddingRight(10),
                  );
                }),
              ],
            ),
            Row(
              children: [
                Icon(Icons.circle, color: purpleColor, size: 12),
                6.width,
                Text("Published On September 15", style: primaryTextStyle(color: Colors.grey, size: 14)),
              ],
            ),
            16.height,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imagePath, fit: BoxFit.cover, width: double.infinity, height: 220),
              ),
            ),
            20.height,
            Text("Discover essential Strength Training Tips to maximize your workouts and achieve your fitness goals efficiently. Learn how to optimize your routine, prevent injuries, and unlock your full potential in the gym.",
                style: primaryTextStyle(color: Colors.white, size: 16)),
            20.height,
            Text("Plan Your Routine:", style: boldTextStyle(color: limeColor, size: 18)),
            8.height,
            Text(
              "Before starting any workout, plan your routine for the week. Focus on different muscle groups on different days to allow for adequate rest and recovery.",
              style: primaryTextStyle(color: Colors.white, size: 16),
            ),
            20.height,
            Text("Warm-Up:", style: boldTextStyle(color: limeColor, size: 18)),
            8.height,
            Text(
              "Begin your workout with a proper warm-up session. This could include light cardio exercises like jogging or jumping jacks, as well as dynamic stretches to prepare your muscles for the upcoming workout.",
              style: primaryTextStyle(color: Colors.white, size: 16),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
