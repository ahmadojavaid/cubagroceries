import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/handyman/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/handyman/utils/common.dart';

class UpcomingBooking extends StatelessWidget {
  const UpcomingBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleRowWidget(handymanAppString.upComingBooking, ""),
        SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: handymanAppColor.whiteColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: handymanAppColor.black12,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(handymanAppImages.door),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            handymanAppImages.calender,
                            size: 16,
                            color: handymanAppColor.upcomingIcon,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            handymanAppString.date,
                            style:
                                TextStyle(color: handymanAppColor.upcomingIcon),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            handymanAppImages.time,
                            size: 16,
                            color: handymanAppColor.upcomingIcon,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            handymanAppString.time,
                            style:
                                TextStyle(color: handymanAppColor.upcomingIcon),
                          ),
                        ],
                      ),
                      Text(
                        handymanAppString.doorInstallation,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: handymanAppColor.upcomingBlackTxt,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Icon(handymanAppImages.close,
                      size: 18, color: handymanAppColor.greyColor),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    handymanAppString.bookingStatus,
                    style:
                        GoogleFonts.inter(color: handymanAppColor.blackColor),
                  ),
                  Text(
                    handymanAppString.confirmed,
                    style:
                        GoogleFonts.inter(color: handymanAppColor.greenColor),
                  ),
                ],
              ),
              Divider(thickness: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    handymanAppString.paymentStatus,
                    style:
                        GoogleFonts.inter(color: handymanAppColor.blackColor),
                  ),
                  Text(
                    handymanAppString.pending,
                    style: GoogleFonts.inter(color: handymanAppColor.redColor),
                  ),
                ],
              ),
              const SizedBox(height: 23),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: handymanAppColor.cancelBtnColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: handymanAppColor.blackColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
