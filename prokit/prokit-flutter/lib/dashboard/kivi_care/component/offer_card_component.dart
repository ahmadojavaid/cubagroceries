import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Image.network(
            kiviCareAppImages.offerCard,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              width: double.infinity, 
              decoration: BoxDecoration(color: kiviCareAppColor.redColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Marquee(
                  direction: Axis.horizontal,
                  animationDuration: const Duration(seconds: 10),
                  backDuration: const Duration(seconds: 5),
                  pauseDuration: const Duration(seconds: 1),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          "Precision Dental",
                          style: GoogleFonts.pacifico(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kiviCareAppColor.headingColor,
                          ),
                        ),
                        VerticalDivider(
                          thickness: 1,
                          width: 20,
                          color: kiviCareAppColor.headingColor,
                          indent: 8,
                          endIndent: 8,
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "5% OFF",
                                style: GoogleFonts.muktaMalar(
                                  color: kiviCareAppColor.headingColor,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: kiviCareAppString.videoAppointment,
                                style: GoogleFonts.muktaMalar(
                                  color: kiviCareAppColor.headingColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
