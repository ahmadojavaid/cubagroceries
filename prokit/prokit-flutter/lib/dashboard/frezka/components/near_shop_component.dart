import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/frezka/model/package_model.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';

class NearShop extends StatefulWidget {
  const NearShop({super.key});

  @override
  State<NearShop> createState() => _NearShopState();
}
class _NearShopState extends State<NearShop> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: titleRowWidget("Near You", "View All"),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 355,
          width: 380,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nearShopList.length,
            itemBuilder: (context, index) {
              final shop = nearShopList[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 24 : 8, right: index == (nearShopList.length - 1)? 24:8),
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 335,
                  width: 380,
                  decoration: decoratedContainerWidget(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(7),
                        ),
                        child: Image.network(
                          shop.image,
                          height: 160,
                          width: 380,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            txtWidget(
                              shop.shopName,
                              16,
                              FontWeight.w500,
                              frezlaAppColor.headLineColor,
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                iconWidget(
                                  frezkaAppImages.location,
                                  16,
                                  frezlaAppColor.topContainerColor,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Marquee(
                                    direction: Axis.horizontal,
        
                                    child: txtWidget(
                                      shop.address,
                                      14,
                                      FontWeight.w400,
                                      frezlaAppColor.dateTxtColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                iconWidget(
                                  frezkaAppImages.direction,
                                  16,
                                  frezlaAppColor.topContainerColor,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: txtWidget(
                                    shop.distance,
                                    14,
                                    FontWeight.w400,
                                    frezlaAppColor.dateTxtColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      iconWidget(
                                        frezkaAppImages.star,
                                        16,
                                        frezlaAppColor.rateStarColor,
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: txtWidget(
                                          shop.rating,
                                          14,
                                          FontWeight.w400,
                                          frezlaAppColor.dateTxtColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: frezlaAppColor.openBTN,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: txtWidget(
                                      "Open",
                                      12,
                                      FontWeight.w400,
                                      frezlaAppColor.openBTNTXT,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
