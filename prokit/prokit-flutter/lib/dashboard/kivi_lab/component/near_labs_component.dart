import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/model/near_labs_model.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';

class NearLabs extends StatelessWidget {
  const NearLabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleRowWidget(kiviLabAppStrings.nearLabs, kiviLabAppStrings.viewAll),
        SizedBox(height: 16),
        SizedBox(
          height: 222,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nearLabs.length,
            itemBuilder: (context, index) {
              NearLabsModel lab = nearLabs[index];
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 20 : 8,
                    right: index == (nearLabs.length - 1) ? 20 : 8,
                  ),
                child: Container(
                  height: 222,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: kiviLabAppColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: kiviLabAppColors.grey.withAlpha((0.1 * 255).toInt()),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, top: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 41,
                              width: 41,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  lab.labLogo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kiviLabAppColors.green,
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 3,
                                        ),
                                        child: txtWidget(
                                          "Open",
                                          8,
                                          FontWeight.w600,
                                          kiviLabAppColors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kiviLabAppColors.topContainer,
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 3,
                                        ),
                                        child: txtWidget(
                                          lab.labeType,
                                          8,
                                          FontWeight.w600,
                                          kiviLabAppColors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                txtWidget(
                                  lab.labName,
                                  14,
                                  FontWeight.w600,
                                  kiviLabAppColors.titleTXT,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        iconRowWidget(kiviLabAppImages.mail, lab.email),
                        SizedBox(height: 6),
                        iconRowWidget(kiviLabAppImages.phone, lab.contact),
                        SizedBox(height: 6),
                        iconRowWidget(kiviLabAppImages.location, lab.labAddress),
                        SizedBox(height: 20),
                        txtWidget(
                          "View Details",
                          12,
                          FontWeight.w600,
                          kiviLabAppColors.secondaryColor,
                        ),
                      ],
                    ),
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
