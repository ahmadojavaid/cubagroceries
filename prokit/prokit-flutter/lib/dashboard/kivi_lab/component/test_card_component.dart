import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';

class TestCard extends StatelessWidget {
  const TestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.network(
            kiviLabAppImages.blueBackground,
            height: 64,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                txtWidget(
                  kiviLabAppStrings.queTest,
                  14,
                  FontWeight.w600,
                  kiviLabAppColors.titleTXT,
                ),
                Container(
                  height: 32,
                  width: 141,
                  decoration: BoxDecoration(
                    color: kiviLabAppColors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: txtWidget(
                      kiviLabAppStrings.prescription,
                      12,
                      FontWeight.w600,
                      kiviLabAppColors.titleTXT,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
