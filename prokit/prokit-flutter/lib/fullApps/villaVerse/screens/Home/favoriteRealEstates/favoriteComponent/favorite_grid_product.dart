import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../../models/product_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../../bookingDetail/product_detail_screen.dart';

class FavoriteGridProduct extends StatefulWidget {
  final VoidCallback voidCallback;

  const FavoriteGridProduct({super.key, required this.voidCallback});

  @override
  State<FavoriteGridProduct> createState() => _FavoriteGridProductState();
}

class _FavoriteGridProductState extends State<FavoriteGridProduct> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1 / 1.55,
      ),
      itemCount: favoriteProducts.length,
      itemBuilder: (context, index) {
        ProductModel data = favoriteProducts[index];
        return GestureDetector(
          onTap: () => ProductDetailScreen(featuredProduct: data).launch(
            context,
          ),
          child: SizedBox(
            child: Card(
              elevation: 00,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
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
                            child: Stack(
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
                                        Text("4.7",
                                            style: TextStyle(color: darkColor))
                                      ],
                                    ).paddingSymmetric(horizontal: 5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ).center(),
                      ).paddingSymmetric(horizontal: 10),
                      Text(
                        data.titleText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ).paddingLeft(10),
                      Text(
                        data.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12),
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
                      onTap: widget.voidCallback,
                      child: Icon(
                        data.isFavorite == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: primaryBlueColor,
                      ),
                    ),
                  ).paddingAll(16)
                ],
              ),
            ),
          ),
        );
      },
    ).paddingSymmetric(horizontal: 16);
  }
}
