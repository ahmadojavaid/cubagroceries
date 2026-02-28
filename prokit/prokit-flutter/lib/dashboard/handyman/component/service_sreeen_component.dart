import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/handyman/model/pageview_model.dart';
import 'package:prokit_flutter/dashboard/handyman/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/handyman/utils/common.dart';

class ServiceCardList extends StatelessWidget {
  const ServiceCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        titleRowWidget(handymanAppString.service, handymanAppString.viewAll),
        SizedBox(height: 8),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: serviceCards.length,
            padding: const EdgeInsets.only(left: 20),
            itemBuilder: (context, index) {
              final card = serviceCards[index];
              return Container(
                width: 220,
                margin:  EdgeInsets.only(right: index == (serviceCards.length-1) ? 20 : 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: NetworkImage(card['image']),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [handymanAppColor.black2, handymanAppColor.black6],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: handymanAppColor.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  card['tag'],
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: handymanAppColor.blackColor,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: handymanAppColor.blueCustom,
                                ),
                                child: Center(
                                  child: Image.network(
                                    handymanAppImages.shop,
                                    color: handymanAppColor.whiteColor,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: handymanAppColor.greenColor,
                                ),
                                child: Center(
                                  child: Image.network(
                                    handymanAppImages.video,
                                    color: handymanAppColor.whiteColor,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            card['title'],
                            style: GoogleFonts.inter(
                              color: handymanAppColor.constWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(card['avatar']),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                card['name'],
                                style: GoogleFonts.inter(
                                  color: handymanAppColor.constWhite,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            height: 40,
                            width: 105,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: handymanAppColor.blueCustom,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "\$${card['price']}",
                                  style: GoogleFonts.inter(
                                    color: handymanAppColor.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "\$${card['originalPrice']}",
                                  style: GoogleFonts.inter(
                                    color: handymanAppColor.white60,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
