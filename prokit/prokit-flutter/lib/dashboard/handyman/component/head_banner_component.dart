import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/handyman/screens/home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          Container(
            height: 118,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: handymanAppColor.blueCustom,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          Positioned(
            top: 34,
            left: 20,
            right: 20,
            child: Row(
              children: [
                Image.network(handymanAppImages.userLogo,
                    height: 30, width: 30), 
                SizedBox(width: 30),
                Container(
                  height: 40,
                  width: 206,
                  decoration: BoxDecoration(
                    color: handymanAppColor.whiteColor,
                    borderRadius: BorderRadius.circular(70),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(handymanAppImages.location,
                                size: 10, color: handymanAppColor.blackColor),
                            SizedBox(width: 6),
                            Text(
                              "582 Lakeview Avenue...",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: handymanAppColor.blackColor,
                              ),
                            ),
                          ],
                        ),
                        Icon(handymanAppImages.downArrow,
                            size: 10, color: handymanAppColor.blackColor),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Icon(
                  handymanAppImages.notification,
                  color: handymanAppColor.constWhite,
                ),
              ],
            ),
          ),
          Positioned(
            top: 90,
            left: 20,
            right: 20,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: handymanAppColor.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: handymanAppColor.black12,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0, right: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(handymanAppImages.search),
                        SizedBox(width: 10),
                        Text(handymanAppString.exampal),
                      ],
                    ),
                    Icon(handymanAppImages.microphone),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
