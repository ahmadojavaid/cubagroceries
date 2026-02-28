import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/frezka/model/package_model.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';

class ExpertsTabs extends StatelessWidget {
  const ExpertsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRowWidget("Our Experts", "View All"),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 35,
                crossAxisSpacing: 12,
                childAspectRatio: 0.70,
              ),
              itemCount: experts.length,
              itemBuilder: (context, index) {
                final expert = experts[index];
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 192,
                      width: 180,
                      decoration: BoxDecoration(
                        color: frezlaAppColor.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: frezlaAppColor.black.withAlpha(
                              (0.05 * 255).toInt(),
                            ),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 56.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Marquee(direction: Axis.horizontal,
                                child: txtWidget(
                                  expert.name,
                                  16,
                                  FontWeight.w600,
                                  frezlaAppColor.headLineColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            txtWidget(
                              expert.proffession,
                              12,
                              FontWeight.w500,
                              frezlaAppColor.dateTxtColor,
                            ),
                            const SizedBox(height: 14),
                            Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: frezlaAppColor.expertContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    iconWidget(
                                      frezkaAppImages.star,
                                      12,
                                      frezlaAppColor.rateStarColor,
                                    ),
                                    const SizedBox(width: 4),
                                    txtWidget(
                                      expert.rating,
                                      14,
                                      FontWeight.w600,
                                      frezlaAppColor.constBlack,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -36,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: CircleAvatar(
                          radius: 36,
                          backgroundImage: NetworkImage(expert.imagePath),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
