import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/frezka/model/package_model.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';

class PackageCards extends StatefulWidget {
  const PackageCards({super.key});

  @override
  State<PackageCards> createState() => _PackageCardsState();
}
class _PackageCardsState extends State<PackageCards> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: titleRowWidget("Our Packages", "View All"),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offerList.length,
            itemBuilder: (context, index) {
              final offer = offerList[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 24 : 8, right: index == (offerList.length -1)? 24:8),
                child: Container(
                  width: 198,
                  height: 220,
                 
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: offer.isHighlighted
                        ? frezlaAppColor.highlightedCard
                        : frezlaAppColor.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: frezlaAppColor.black.withAlpha((0.05 * 255).toInt()),
                        offset: const Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          frezkaAppImages.offerBox, 
                          height: 32,
                          width: 32,
                          fit: BoxFit.cover,
                          color: frezlaAppColor.black,
                        ),
                        const SizedBox(height: 24),
                        Marquee(
                          direction: Axis.horizontal,
                          child: txtWidget(
                            offer.title,
                            14,
                            FontWeight.w500,
                             frezlaAppColor.headLineColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        txtWidget(
                          offer.price,
                          16,
                          FontWeight.w500,
                          frezlaAppColor.priceTxtColor,
                        ),
                        const SizedBox(height: 24),
                        txtWidget(
                          "Explore",
                          12,
                          FontWeight.w500,
                          frezlaAppColor.priceTxtColor,
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
