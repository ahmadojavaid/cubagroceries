import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Stack(
        children: [
          Container(
            height: 171 + MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              color: frezlaAppColor.topContainerColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                left: 24,
                right: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  txtWidget("Redbox Unisex Salon", 22, FontWeight.w500,
                      frezlaAppColor.constWhite),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      iconWidget(
                          frezkaAppImages.location, 16, frezlaAppColor.constWhite),
                      const SizedBox(width: 8),
                      Expanded(
                        child: txtWidget(
                          "4245 Stonepot Road, Weehawken, New Jersey...",
                          14,
                          FontWeight.w400,
                          frezlaAppColor.constWhite,
                        ),
                      ),
                      const SizedBox(width: 8),
                      iconWidget(
                          frezkaAppImages.downArrow, 16, frezlaAppColor.constWhite),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(
                      thickness: 0.5, color: frezlaAppColor.dividerBarColor),
                ],
              ),
            ),
          ),
          Positioned(
            top: 138,
            left: 24,
            right: 24,
            child: Container(
              height: 58,
              decoration: BoxDecoration(
                color: frezlaAppColor.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: frezlaAppColor.blackShadow,
                    offset: Offset(0, 14),
                    blurRadius: 14,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        iconWidget(
                          frezkaAppImages.searchIcon,
                          15.64,
                          frezlaAppColor.topContainerIcon,
                        ),
                        SizedBox(width: 10),
                        txtWidget(
                          "Search for ‘hair color’",
                          14,
                          FontWeight.w400,
                          frezlaAppColor.topContainerIcon,
                        ),
                      ],
                    ),
                    iconWidget(
                      frezkaAppImages.microPhone,
                      17.42,
                      frezlaAppColor.topContainerIcon,
                    ),
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
