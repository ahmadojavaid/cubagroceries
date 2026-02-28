import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';


class RateTheApp extends StatelessWidget {
  const RateTheApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            streamITApString.rateApp,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: streamITAppColors.white,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 157,
            decoration: BoxDecoration(color: streamITAppColors.fadeBlack),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        streamITApString.thoughts,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: streamITAppColors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        streamITApString.opinion,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: streamITAppColors.movieDis,
                        ),
                      ),
                      Text(
                        streamITApString.feedback,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: streamITAppColors.movieDis,
                        ),
                      ),
                      SizedBox(height: 26),
                      Container(
                        height: 30,
                        width: 102,
                        decoration: BoxDecoration(
                          color: streamITAppColors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            streamITApString.rateNow,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: streamITAppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                    child: Lottie.asset(streamITAppImages.lottie, fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
