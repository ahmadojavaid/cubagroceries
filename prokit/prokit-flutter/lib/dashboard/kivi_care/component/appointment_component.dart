import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_care/utils/common.dart';


class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleRowWidget(kiviCareAppString.upcomingAppointment, kiviCareAppString.seeAll),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: kiviCareAppColor.whiteColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        txtWidget(
                          kiviCareAppString.appointmentID,
                          12,
                          FontWeight.w500,
                          kiviCareAppColor.fadeText,
                        ),
                        txtWidget(
                          kiviCareAppString.id,
                          14,
                          FontWeight.w600,
                          kiviCareAppColor.bgColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: kiviCareAppColor.subContainerColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 9.0,
                        horizontal: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          txtWidget(
                            kiviCareAppString.date,
                            10,
                            FontWeight.w600,
                            kiviCareAppColor.bgColor,
                          ),
                          SizedBox(
                            height: 20, 
                            child: VerticalDivider(
                              thickness: 1,
                              color: kiviCareAppColor.bgColor,
                              width: 20,
                            ),
                          ),
                          txtWidget(
                            kiviCareAppString.time,
                            10,
                            FontWeight.w600,
                            kiviCareAppColor.bgColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: txtWidget(
                      kiviCareAppString.appointTitle,
                      18,
                      FontWeight.w600,
                      kiviCareAppColor.headingColor,
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txtWidget(
                            kiviCareAppString.inClinic,
                            12,
                            FontWeight.w500,
                            kiviCareAppColor.fadeText,
                          ),
                          SizedBox(height: 4),
                          txtWidget(
                            kiviCareAppString.drName,
                            12,
                            FontWeight.w600,
                            kiviCareAppColor.headingColor,
                          ),
                        ],
                      ),
                      txtWidget(
                        "\$25",
                        20,
                        FontWeight.w700,
                        kiviCareAppColor.headingColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 36),
                  Divider(thickness: 0.5, color: kiviCareAppColor.dividerColor),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(kiviCareAppImages.calender, size: 16),

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: kiviCareAppString.booking,
                                  style: GoogleFonts.interTight(
                                    color: kiviCareAppColor.headingColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: kiviCareAppString.chechIn,
                                  style: GoogleFonts.interTight(
                                    color: kiviCareAppColor.greenText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(kiviCareAppImages.money, size: 16),

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: kiviCareAppString.payment,
                                  style: GoogleFonts.interTight(
                                    color: kiviCareAppColor.headingColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: kiviCareAppString.panding,
                                  style: GoogleFonts.interTight(
                                    color: kiviCareAppColor.redText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(thickness: 0.5, color: kiviCareAppColor.dividerColor),
                  SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: kiviCareAppString.bookedFor,
                          style: GoogleFonts.interTight(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: kiviCareAppColor.fadeText,
                          ),
                        ),
                        WidgetSpan(
                          child: SizedBox(width: 10), 
                        ),
                        TextSpan(
                          text: kiviCareAppString.name,
                          style: GoogleFonts.interTight(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kiviCareAppColor.nameText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: kiviCareAppColor.subContainerColor,
                          ),
                          child: Center(
                            child: txtWidget(
                              kiviCareAppString.cancel,
                              12,
                              FontWeight.w700,
                              kiviCareAppColor.nameText,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: kiviCareAppColor.redColor,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Image.network(
                                    kiviCareAppImages.meter,
                                    color: kiviCareAppColor.nameText,
                                  ),
                                ),
                                SizedBox(width: 10),
                                txtWidget(
                                  kiviCareAppString.encounter,
                                  12,
                                  FontWeight.w700,
                                  kiviCareAppColor.nameText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
