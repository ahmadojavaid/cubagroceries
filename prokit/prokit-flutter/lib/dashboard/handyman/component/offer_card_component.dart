import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/handyman/screens/home_screen.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: handymanAppColor.btnColor),
      child: Center(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 20),
              child: SizedBox(
                width: 225,
                child: Text(
                  handymanAppString.spendAtCheckOut,
                  maxLines: 2,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: handymanAppColor.constWhite,
                  ),
                ),
              ),
            ),
            Image.network(handymanAppImages.cleanner, height: 145), 
          ],
        ),
      ),
    );
  }
}
