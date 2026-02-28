import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/model/popular_test_model.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';

class HealthPackageCard extends StatelessWidget {
  final HealthPackageModel package;
  const HealthPackageCard({super.key, required this.package});
  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency(decimalDigits: 0);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.network(
                  package.imagePath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20),
              Marquee(
                direction: Axis.horizontal,
                child: txtWidget(
                  package.title,
                  16,
                  FontWeight.w600,
                  kiviLabAppColors.titleTXT,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              txtWidget(
                currency.format(package.offerPrice),
                20,
                FontWeight.w600,
                kiviLabAppColors.topContainer,
              ),
              const SizedBox(width: 8),
              Text(
                currency.format(package.originalPrice),
                style: GoogleFonts.interTight(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kiviLabAppColors.greyTXT,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: kiviLabAppColors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  package.discountLabel,
                  style: TextStyle(color: kiviLabAppColors.white, fontSize: 12),
                ),
              ),
              const Spacer(),
              txtWidget(
                'Ends: ${package.expiryDate}',
                12,
                FontWeight.w600,
                kiviLabAppColors.titleTXT,
              ),
            ],
          ),
          const SizedBox(height: 21),
          Divider(thickness: 1, color: kiviLabAppColors.greyTXT),
          txtWidget(package.labName, 14, FontWeight.w600, kiviLabAppColors.titleTXT),
          const SizedBox(height: 4),
          txtWidget(package.description, 12, FontWeight.w400, kiviLabAppColors.greyTXT),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              txtWidget('Package Includes:', 12, FontWeight.w600, kiviLabAppColors.titleTXT),
              Row(
                children: [
                  txtWidget(
                    "View More",
                    10,
                    FontWeight.w700,
                    kiviLabAppColors.secondaryColor,
                  ),
                  Icon(
                    kiviLabAppImages.downArrow,
                    size: 12,
                    color: kiviLabAppColors.secondaryColor,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kiviLabAppColors.appontCard,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: package.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      txtWidget(item.name, 12, FontWeight.w600, kiviLabAppColors.titleTXT),
                      Row(
                        children: [
                          txtWidget(
                            currency.format(item.price),
                            14,
                            FontWeight.w600,
                            kiviLabAppColors.topContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currency.format(item.originalPrice),
                            style: GoogleFonts.interTight(
                              color: kiviLabAppColors.greyTXT,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kiviLabAppColors.secondaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: txtWidget('Book Now', 14, FontWeight.w600, kiviLabAppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
