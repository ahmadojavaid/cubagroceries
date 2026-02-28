import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../../models/product_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../../bookingDetail/product_detail_screen.dart';

class FavoritesProductList extends StatelessWidget {
  final VoidCallback voidCallback;

  const FavoritesProductList({super.key, required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      itemCount: favoriteProducts.length,
      itemBuilder: (context, index) {
        ProductModel data = favoriteProducts[index];
        return GestureDetector(
          onTap: () => ProductDetailScreen(featuredProduct: data).launch(
            context,
          ),
          child: Column(
            children: [
              Card(
                elevation: 00,
                color: appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
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
                                      Text("4.7", style: TextStyle(color: darkColor))
                                    ],
                                  ).paddingSymmetric(horizontal: 5),
                                ),
                              )
                            ],
                          ),
                          12.width,
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.titleText,
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          16.width,
                          Column(
                            children: [
                              GestureDetector(
                                onTap: voidCallback,
                                child: Icon(
                                  Icons.favorite,
                                  color: primaryBlueColor,
                                ),
                              ),
                              25.height,
                              Text(data.price.substring(0, 4), style: TextStyle(color: primaryBlueColor, fontSize: 16)),
                              Text(data.price.substring(4), style: TextStyle(color: primaryBlueColor, fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ).paddingSymmetric(horizontal: 12, vertical: 7),
            ],
          ),
        );
      },
    );
  }
}