import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/handyman/screens/home_screen.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: handymanAppColor.requestContainerColor),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        handymanAppString.cantFindService,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: handymanAppColor.whiteColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        handymanAppString.feedBack,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: handymanAppColor.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),
              Container(
                height: 35,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: handymanAppColor.btnColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    handymanAppString.newRequest,
                    style: GoogleFonts.inter(
                      color: handymanAppColor.constWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
