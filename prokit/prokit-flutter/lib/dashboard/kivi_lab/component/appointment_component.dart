import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';

class Appointment extends StatelessWidget {
  const Appointment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 328,
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 22,
                        width: 64,
                        decoration: BoxDecoration(
                          color: kiviLabAppColors.appontCard,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: 1,
                            color: kiviLabAppColors.titleTXT,
                          ),
                        ),
                        child: Center(
                          child: txtWidget(
                            kiviLabAppStrings.package,
                            10,
                            FontWeight.w400,
                            kiviLabAppColors.titleTXT,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: kiviLabAppStrings.apointIDlbl,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: kiviLabAppColors.greyTXT,
                              ),
                            ),
                            WidgetSpan(child: SizedBox(width: 4)),
                            TextSpan(
                              text: kiviLabAppStrings.apointID,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: kiviLabAppColors.topContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  txtWidget(
                    kiviLabAppStrings.price,
                    18,
                    FontWeight.w600,
                    kiviLabAppColors.topContainer,
                  ),
                ],
              ),
              SizedBox(height: 14),
              txtWidget(
                kiviLabAppStrings.testName,
                16,
                FontWeight.w600,
                kiviLabAppColors.titleTXT,
              ),
              SizedBox(height: 20),
              Container(
                height: 130,
                decoration: BoxDecoration(
                  color: kiviLabAppColors.appontCard,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    right: 14,
                    left: 14,
                  ),
                  child: Column(
                    children: [
                      cardRowWidget(
                        kiviLabAppStrings.bookingLbl,
                        txtWidget(
                          kiviLabAppStrings.panding,
                          12,
                          FontWeight.w600,
                          kiviLabAppColors.red,
                        ),
                      ),
                      cardRowWidget(
                        kiviLabAppStrings.bookingLbl,
                        txtWidget(
                          kiviLabAppStrings.dateAndTime,
                          12,
                          FontWeight.w600,
                          kiviLabAppColors.titleTXT,
                        ),
                      ),
                      cardRowWidget(
                        kiviLabAppStrings.bookingLbl,
                        Row(
                          children: [
                            Image.network(
                              kiviLabAppImages.hospital,
                              height: 18,
                              width: 18,
                              color: kiviLabAppColors.topContainer,
                            ),
                            SizedBox(width: 12),
                            txtWidget(
                              kiviLabAppStrings.atCenter,
                              12,
                              FontWeight.w400,
                              kiviLabAppColors.titleTXT,
                            ),
                          ],
                        ),
                      ),
                      cardRowWidget(
                        kiviLabAppStrings.paidBY,
                        txtWidget(
                          kiviLabAppStrings.paidBY,
                          12,
                          FontWeight.w600,
                          kiviLabAppColors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: kiviLabAppColors.appontCard,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: txtWidget(
                          kiviLabAppStrings.cancel,
                          14,
                          FontWeight.w600,
                          kiviLabAppColors.titleTXT,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: kiviLabAppColors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: txtWidget(
                          kiviLabAppStrings.reschedule,
                          14,
                          FontWeight.w600,
                          kiviLabAppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
