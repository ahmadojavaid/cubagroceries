import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/card_select_option.dart';
import '../../../models/product_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../../../main.dart';
import '../../../utils/image.dart';
import 'favoriteComponent/favorite_grid_product.dart';
import 'favoriteComponent/favorites_product_list.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  int sortViewSelection = 1;

  final List<Map<String, dynamic>> _sort = [
    {"title": "All", "icon": Icons.check_box},
    {"title": "House", "icon": Icons.home},
    {"title": "villa", "icon": Icons.maps_home_work_sharp},
    {"title": "Apartments", "icon": Icons.apartment},
  ];
  int selectedIndex = 0;

  Future<void> showConfirmSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        hideKeyboard(context);
        ProductModel data = favoriteProducts[0];
        return Container(
          height: 350,
          width: context.width(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
            color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
          ),
          child: Column(
            children: [
              5.height,
              Divider(color: Colors.grey, height: 20)
                  .paddingSymmetric(horizontal: context.width() * .45),
              16.height,
              Text("Remove from Favorites?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              16.height,
              Card(
                elevation: 00,
                color: appStore.isDarkModeOn ? darkColor : lightColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.network(
                                      data.imagePath,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 7,
                                right: 7,
                                child: Card(
                                  color: inputFillColorlight,
                                  elevation: 00,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: Colors.yellowAccent[400],
                                      ),
                                      Text(
                                        "4.7",
                                        style: TextStyle(color: hintTextColor),
                                      )
                                    ],
                                  ).paddingSymmetric(horizontal: 5),
                                ),
                              )
                            ],
                          ),
                          16.width,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.titleText,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  data.address,
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    data.isFavorite = !data.isFavorite;
                                  });
                                },
                                child: Icon(
                                  data.isFavorite == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: primaryBlueColor,
                                ),
                              ),
                              25.height,
                              Text(data.price.substring(0, 3),
                                  style: TextStyle(
                                      color: primaryBlueColor, fontSize: 16)),
                              Text(data.price.substring(3),
                                  style: TextStyle(
                                      color: primaryBlueColor, fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ).paddingSymmetric(horizontal: 12, vertical: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    elevation: 0,
                    text: 'Cancel',
                    textStyle: boldTextStyle(
                        color: appStore.isDarkModeOn
                            ? lightColor
                            : primaryBlueColor),
                    color: appStore.isDarkModeOn ? hintTextColor : blueLight,
                    width: context.width() / 2.5,
                    onTap: () => finish(context),
                    shapeBorder:
                        RoundedRectangleBorder(borderRadius: radius(20)),
                  ),
                  AppButton(
                    elevation: 0,
                    text: 'Yes, Remove',
                    color: primaryBlueColor,
                    textStyle: boldTextStyle(color: lightColor),
                    width: context.width() / 2.5,
                    onTap: () => finish(context),
                    shapeBorder:
                        RoundedRectangleBorder(borderRadius: radius(20)),
                  ),
                ],
              ).paddingOnly(bottom: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                villaVerse,
                height: 40,
                width: 40,
              ),
              title: Text(
                "Favorites",
                style: boldTextStyle(size: 16),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    color: appStore.isDarkModeOn ? lightColor : darkColor,
                  ),
                  12.width,
                ],
              ),
            ),
            16.height,
            CardSelectOption(
                list: _sort,
                selectedIndex: selectedIndex,
                color: appStore.isDarkModeOn ? darkColor : lightColor),
            16.height,
            resultSorter('32 favorites'),
            Expanded(
              child: sortViewSelection == 1
                  ? FavoritesProductList(voidCallback: showConfirmSheet)
                  : FavoriteGridProduct(voidCallback: showConfirmSheet),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleText(String text) {
    return Text(text, style: TextStyle(fontSize: 16))
        .paddingSymmetric(horizontal: 16);
  }

  Widget resultSorter(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.list_alt,
              size: 27,
              color: sortViewSelection == 1 ? primaryBlueColor : hintTextColor),
          onPressed: () => setState(() => sortViewSelection = 1),
        ),
        IconButton(
          icon: Icon(Icons.dashboard,
              size: 27,
              color: sortViewSelection == 2 ? primaryBlueColor : hintTextColor),
          onPressed: () => setState(() => sortViewSelection = 2),
        ),
      ],
    ).paddingSymmetric(horizontal: 16);
  }
}

Widget filtterOptions(String centerText, Color backgroundColor, Color textColor,
    [IconData? icon]) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: primaryBlueColor)),
    color: backgroundColor,
    elevation: 00,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: textColor,
          size: 20,
        ),
        5.width,
        Text(
          centerText,
          style: TextStyle(color: textColor),
        ),
      ],
    ).paddingSymmetric(horizontal: 20, vertical: 5),
  );
}
