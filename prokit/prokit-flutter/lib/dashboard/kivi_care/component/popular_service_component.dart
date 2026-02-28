import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/kivi_care/model/service_model.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_care/utils/common.dart';

class PopularService extends StatelessWidget {
  const PopularService({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleRowWidget(kiviCareAppString.popularService, kiviCareAppString.seeAll),
        SizedBox(height: 8),
        SizedBox(
          height: 266,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: services.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              ServiceCardModel service = services[index];
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 20 : 8,
                    right: index == (services.length - 1) ? 20 : 8,
                  ),
                child: Container(
                  width: 182,
                  height: 266,
                  decoration: BoxDecoration(
                    color: kiviCareAppColor.whiteColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 110,
                            width: 182,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                              child: Image.network(
                                service.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 8,
                            top: 8,
                            child: Container(
                              height: 22,
                              width: 80,
                              decoration: BoxDecoration(
                                color: kiviCareAppColor.whiteColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: txtWidget(
                                  service.category,
                                  10,
                                  FontWeight.w700,
                                  kiviCareAppColor.redText,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 24,
                              width: 34,
                              decoration: BoxDecoration(
                                color: kiviCareAppColor.greenText,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                ),
                                border: Border(
                                  top: BorderSide(
                                    color: kiviCareAppColor.whiteColor,
                                    width: 2,
                                  ),
                                  left: BorderSide(
                                    color: kiviCareAppColor.whiteColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Image.network(
                                kiviCareAppImages.videoCall,
                                color: kiviCareAppColor.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            txtWidget(
                              service.title,
                              14,
                              FontWeight.w600,
                              kiviCareAppColor.nameText,
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                txtWidget(
                                  "Duration:",
                                  10,
                                  FontWeight.w600,
                                  kiviCareAppColor.fadeText,
                                ),
                                SizedBox(width: 10),
                                txtWidget(
                                  service.duration,
                                  10,
                                  FontWeight.w600,
                                  kiviCareAppColor.headingColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                txtWidget(
                                  service.price,
                                  16,
                                  FontWeight.w700,
                                  kiviCareAppColor.bgColor,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  service.originalPrice,
                                  style: GoogleFonts.interTight(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: kiviCareAppColor.greenText,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: 10),
                                txtWidget(
                                  "${service.discount} Off",
                                  12,
                                  FontWeight.w600,
                                  kiviCareAppColor.greenText,
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Container(
                              height: 36,
                              width: 150,
                              decoration: BoxDecoration(
                                color: kiviCareAppColor.subContainerColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Center(
                                child: txtWidget(
                                  "Book Now",
                                  12,
                                  FontWeight.w600,
                                  kiviCareAppColor.bgColor,
                                ),
                              ),
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
