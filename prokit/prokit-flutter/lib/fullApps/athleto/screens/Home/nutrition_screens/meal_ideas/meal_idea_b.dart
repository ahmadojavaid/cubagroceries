import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../component/custom_Appbar.dart';
import '../../../../component/custom_button.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/image.dart';
import '../nutritent_screens.dart';

class RecipeDetailsScreen123 extends StatelessWidget {
  final String imagePath;
  final String title;

  const RecipeDetailsScreen123({super.key, required this.imagePath, required this.title});

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
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: boldTextStyle(
                      color: limeColor,
                      size: 30,
                    ),
                  ),
                ),
                Observer(builder: (_) {
                  bool isFav = favoriteStore.isFavorite(title);
                  return GestureDetector(
                    onTap: () {
                      favoriteStore.toggleFavorite({"title": title, "image": imagePath, 'type': "Video"});
                    },
                    //TODO:
                    child: ImageIcon(
                      AssetImage(star),
                      color: isFav ? Colors.yellow : Colors.grey,
                      size: 20,
                    ),
                  );
                })
              ],
            ),
            16.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.access_time, color: primaryColor, size: 16),
                4.width,
                Text('12 Minutes', style: secondaryTextStyle(color: Colors.white)),
                16.width,
                Icon(Icons.local_fire_department, color: primaryColor, size: 16),
                4.width,
                Text('120 Cal', style: secondaryTextStyle(color: Colors.white)),
              ],
            ),
            16.height,
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  //TODO:
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    height: 250,
                  ),
                ).center().paddingSymmetric(vertical: 16),
                Positioned(
                  top: 16,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: limeColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    ),
                    child: Text('Recipe Of The Day', style: boldTextStyle(color: Colors.black, size: 12)),
                  ),
                ),
              ],
            ),
            // 16.height,
            Container(
              // padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ingredients', style: boldTextStyle(color: limeColor, size: 18)),
                  8.height,
                  Text("• 2-3 eggs\n• A handful of fresh spinach\n• 1 small tomato\n• Salt and pepper to taste\n• Olive oil or butter", style: secondaryTextStyle(color: Colors.white, size: 16)),
                  16.height,
                  Text('Preparation', style: boldTextStyle(color: limeColor, size: 18)),
                  10.height,
                  Text(
                    """Toast the Bread: Start by toasting the wholemeal bread slices until they are golden brown and crisp.
Prepare the Avocado: While the bread is toasting, mash the ripe avocado slices in a bowl. Add a pinch of salt, pepper, and a drizzle of lemon juice for extra flavor.
Cook the Egg: If you prefer a poached egg, bring a pot of water to a gentle simmer and add a splash of vinegar. Crack the egg into the water and let it cook for about 3–4 minutes until the whites are set but the yolk is still runny. If you prefer a fried egg, heat a small pan with oil or butter, crack the egg, and cook until the whites are firm but the yolk remains soft.
""",
                    style: secondaryTextStyle(color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
            16.height,
            Align(
                alignment: Alignment.center,
                child: CustomButton(
                  text: "Save Recipes",
                  onPressed: () {
                    NutritentScreens().launch(context, isNewTask: true);
                  },
                  color: limeColor,
                  textcolor: black,
                )),
            20.height,
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
