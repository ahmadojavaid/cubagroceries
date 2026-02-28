import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(color: frezlaAppColor.membershipContainer),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 19),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      color: frezlaAppColor.membershipCircleBG,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.network(
                        frezkaAppImages.membership,
                        height: 30,
                        width: 30,
                        color: frezlaAppColor.constWhite,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      txtWidget(
                        "Join membership for benefits",
                        14,
                        FontWeight.w500,
                        frezlaAppColor.constHeadline,
                      ),
                      SizedBox(height: 5),
                      txtWidget(
                        "Join membership for benefits",
                        10,
                        FontWeight.w400,
                        frezlaAppColor.constHeadline,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 16,
              ),
              txtWidget(
                "View All",
                12,
                FontWeight.w500,
                frezlaAppColor.topContainerColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
