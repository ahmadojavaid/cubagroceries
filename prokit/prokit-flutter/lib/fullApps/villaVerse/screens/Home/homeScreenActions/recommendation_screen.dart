import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../component/card_select_option.dart';
import '../../../component/my_app_bar.dart';
import '../../../models/product_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../bookingDetail/product_detail_screen.dart';

class RecommendationScreen extends StatefulWidget {
  final String lable;

  const RecommendationScreen({super.key, required this.lable});

  @override
  State<RecommendationScreen> createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen> {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> _sort = [
    {"title": "All", "icon": Icons.check_box},
    {"title": "House", "icon": Icons.home},
    {"title": "villa", "icon": Icons.maps_home_work_sharp},
    {"title": "Apartments", "icon": Icons.apartment},
  ];

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: widget.lable),
      body: Column(
        children: [
          20.height,
          CardSelectOption(list: _sort, selectedIndex: selectedIndex, color: Theme.of(context).colorScheme.surface),
          16.height,
          Expanded(
            child: GridView.builder(
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
                  onTap: () => ProductDetailScreen(featuredProduct: data).launch(
                    context,
                  ),
                  child: Card(
                    elevation: 00,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
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
                            ).paddingLeft(10),
                            Text(
                              data.address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).paddingLeft(10),
                            Text(
                              data.price,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16, color: primaryBlueColor),
                            ).paddingLeft(10),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () => setState(() {
                              data.isFavorite = !data.isFavorite;
                            }),
                            child: data.isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                          ),
                        ).paddingAll(16)
                      ],
                    ),
                  ),
                );
              },
            ).paddingSymmetric(horizontal: 16),
          ),
        ],
      ),
    );
  }
}
