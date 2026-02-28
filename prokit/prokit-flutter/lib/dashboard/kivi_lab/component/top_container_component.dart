import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';


class TopContainer extends StatefulWidget {
  const TopContainer({super.key});

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  bool isTestTapped = false;
  bool isLabTapped = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 218,
      color: kiviLabAppColors.topContainer,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(kiviLabAppImages.location, size: 16, color: kiviLabAppColors.constWhite),
                    SizedBox(width: 6),
                    txtWidget(
                      kiviLabAppStrings.address,
                      14,
                      FontWeight.w600,
                      kiviLabAppColors.constWhite,
                    ),
                  ],
                ),
                Icon(kiviLabAppImages.notification, size: 16, color: kiviLabAppColors.constWhite),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isTestTapped = !isTestTapped;
                        isLabTapped = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: isTestTapped
                            ? kiviLabAppColors.white
                            : kiviLabAppColors.topContainerBTN,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        kiviLabAppStrings.sbTest,
                        style: TextStyle(
                          color: isTestTapped
                              ? kiviLabAppColors.constWhite
                              : kiviLabAppColors.constWhite,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLabTapped = !isLabTapped;
                        isTestTapped = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: isLabTapped
                            ? kiviLabAppColors.white
                            : kiviLabAppColors.topContainerBTN,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        kiviLabAppStrings.sbLab,
                        style: TextStyle(
                          color: isLabTapped
                              ? kiviLabAppColors.constWhite
                              : kiviLabAppColors.constWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(
                color: kiviLabAppColors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          kiviLabAppImages.search,
                          size: 12,
                          color: kiviLabAppColors.btn,
                        ),
                        SizedBox(width: 8),
                        txtWidget(
                          kiviLabAppStrings.searchBar,
                          12,
                          FontWeight.w400,
                          kiviLabAppColors.btn,
                        ),
                      ],
                    ),
                    Icon(kiviLabAppImages.mic, size: 12, color: kiviLabAppColors.btn),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
