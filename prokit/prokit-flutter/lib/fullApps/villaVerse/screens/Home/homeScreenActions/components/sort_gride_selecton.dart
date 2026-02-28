import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main.dart';

import '../../../../models/product_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constant.dart';
import '../../bookingDetail/product_detail_screen.dart';

class SortGrideSelecton extends StatefulWidget {
  final List<ProductModel> listData;

  const SortGrideSelecton({
    super.key,
    required this.listData,
  });

  @override
  State<SortGrideSelecton> createState() => _SortGrideSelectonState();
}

class _SortGrideSelectonState extends State<SortGrideSelecton> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 1 / 1.55,
      ),
      itemCount: widget.listData.length,
      itemBuilder: (context, index) {
        ProductModel data = recommended[index];
        return GestureDetector(
          onTap: () {
            hideKeyboard(context);
            ProductDetailScreen(featuredProduct: data).launch(
              context,
            );
          },
          child: SizedBox(
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                                    color: lightColor,
                                    elevation: 00,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: Colors.yellowAccent[400],
                                        ),
                                        Text(
                                          "4.7",
                                          style: TextStyle(color: darkColor, fontSize: 10),
                                        )
                                      ],
                                    ).paddingSymmetric(horizontal: 8, vertical: 3),
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
                      Row(
                        children: [
                          Text(
                            data.price.substring(0, 4),
                            style: TextStyle(color: primaryBlueColor, fontSize: 16),
                          ),
                          Text(
                            data.price.substring(4),
                            style: TextStyle(color: primaryBlueColor, fontSize: 12),
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
                      child: Icon(
                        data.isFavorite == true ? Icons.favorite : Icons.favorite_border,
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