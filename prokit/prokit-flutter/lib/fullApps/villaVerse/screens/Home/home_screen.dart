import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../component/card_select_option.dart';
import '../../component/my_text_field.dart';
import '../../component/see_all_text_row.dart';
import '../../models/product_model.dart';
import '../../utils/colors.dart';
import '../../utils/constant.dart';
import '../../utils/image.dart';
import '../../../../main.dart';
import 'bookingDetail/product_detail_screen.dart';
import 'homeScreenActions/notification_screen.dart';
import 'homeScreenActions/recommendation_screen.dart';
import 'homeScreenActions/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> _sort = [
    {"title": "All", "icon": Icons.check_box},
    {"title": "House", "icon": Icons.home},
    {"title": "villa", "icon": Icons.maps_home_work_sharp},
    {"title": "Apartments", "icon": Icons.apartment},
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      appStore.isDarkModeOn
          ? const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
    );
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: image == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(friend2),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.file(image),
                          ),
                        ),
                      ),
                subtitle: Text(
                  "Andrew Ainsly",
                  style: TextStyle(fontSize: 16),
                ),
                title: Text(
                  "Good Morning 👋",
                  style: TextStyle(fontSize: 12),
                ),
                trailing: GestureDetector(
                  onTap: () => NotificationScreen().launch(
                    context,
                  ),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: hintTextColor),
                      borderRadius: BorderRadius.circular(500),
                      color: appStore.isDarkModeOn
                          ? inputFillColorDart
                          : inputFillColorlight,
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.notifications_none,
                            color:
                                appStore.isDarkModeOn ? lightColor : darkColor,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ).paddingAll(10)
                      ],
                    ),
                  ),
                ),
              ),
              MyTextField(
                hintTextColor: hintTextColor,
                prefixIcondata: Icon(Icons.search, color: hintTextColor),
                fillColor: appStore.isDarkModeOn
                    ? inputFillColorDart
                    : inputFillColorlight,
                hintText: "Search",
                keyboardType: TextInputType.text,
                readOnly: true,
                voidCallBack: () => Search().launch(
                  context,
                ),
                sufixIcondata: Icons.tune,
              ).paddingSymmetric(horizontal: 16),
              16.height,
              SeeAllTextRow(
                text: "Featured",
                voidCallback: () =>
                    RecommendationScreen(lable: 'Featured').launch(context),
              ),
              SizedBox(
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredList.length,
                  itemBuilder: (context, index) {
                    ProductModel data = featuredList[index];
                    return GestureDetector(
                      onTap: () => ProductDetailScreen(
                              featuredProduct: featuredList[index])
                          .launch(
                        context,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: SizedBox(
                              height: 270,
                              width: 220,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(data.imagePath),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 00,
                              left: 00,
                              right: 00,
                              top: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        inputFillColorDart
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              )),
                          Positioned(
                            bottom: 20,
                            left: 15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.titleText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: lightColor),
                                ),
                                5.height,
                                Text(
                                  data.address,
                                  style: TextStyle(color: lightColor),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      data.price.substring(0, 4),
                                      style: TextStyle(
                                          color: lightColor, fontSize: 16),
                                    ),
                                    Text(
                                      data.price.substring(4),
                                      style: TextStyle(
                                          color: lightColor, fontSize: 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 15,
                            child: GestureDetector(
                              onTap: () => setState(() {
                                data.isFavorite = !data.isFavorite;
                              }),
                              child: data.isFavorite == true
                                  ? Icon(
                                      Icons.favorite,
                                      color: lightColor,
                                    )
                                  : Icon(Icons.favorite_border,
                                      color: lightColor),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 15,
                            child: Card(
                              elevation: 0,
                              color: lightColor,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                    size: 15,
                                  ),
                                  Text('4.5',
                                      style: TextStyle(color: darkColor)),
                                ],
                              ).paddingSymmetric(horizontal: 10, vertical: 3),
                            ),
                          )
                        ],
                      ).paddingOnly(left: index == 0 ? 16 : 0, right: 16),
                    );
                  },
                ),
              ),
              16.height,
              SeeAllTextRow(
                text: "Our reccommendation",
                voidCallback: () =>
                    RecommendationScreen(lable: 'Our Reccommendation')
                        .launch(context),
              ),
              CardSelectOption(
                list: _sort,
                selectedIndex: selectedIndex,
                color: appStore.isDarkModeOn ? darkColor : lightColor,
              ),
              16.height,
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1 / 1.55,
                ),
                itemCount: recommended.length,
                itemBuilder: (context, index) {
                  ProductModel data = recommended[index];
                  return GestureDetector(
                    onTap: () =>
                        ProductDetailScreen(featuredProduct: data).launch(
                      context,
                    ),
                    child: SizedBox(
                      child: Card(
                        elevation: 00,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: appStore.isDarkModeOn
                            ? inputFillColorDart
                            : inputFillColorlight,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    height: 150,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(data.imagePath),
                                    ),
                                  ).center(),
                                ).paddingOnly(left: 10, right: 10),
                                Text(
                                  data.titleText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: primaryTextStyle(),
                                ).paddingLeft(10),
                                Text(
                                  data.address,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ).paddingLeft(10),
                                Row(
                                  children: [
                                    Text(
                                      data.price.substring(0, 4),
                                      style: primaryTextStyle(
                                          color: primaryBlueColor),
                                    ),
                                    Text(
                                      data.price.substring(4),
                                      style: secondaryTextStyle(
                                          color: primaryBlueColor),
                                    ),
                                  ],
                                ).paddingLeft(10)
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  data.isFavorite = !data.isFavorite;
                                }),
                                child: data.isFavorite
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                              ),
                            ).paddingAll(16),
                            Positioned(
                              top: 20,
                              right: 15,
                              child: Card(
                                elevation: 0,
                                color: lightColor,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orangeAccent,
                                      size: 15,
                                    ),
                                    Text('4.5',
                                        style: TextStyle(color: darkColor)),
                                  ],
                                ).paddingSymmetric(horizontal: 8, vertical: 2),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).paddingSymmetric(horizontal: 16),
              50.height,
            ],
          ),
        ),
      ),
    );
  }
}
