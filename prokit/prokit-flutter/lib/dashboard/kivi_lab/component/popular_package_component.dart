import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/popular_package_card_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/model/popular_test_model.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';

class HealthPackageList extends StatelessWidget {
  const HealthPackageList({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleRowWidget(kiviLabAppStrings.popularPackage, kiviLabAppStrings.viewAll),
        const SizedBox(height: 16),
        SizedBox(
          height: 500,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: healthPackages.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 360,
                child: HealthPackageCard(package: healthPackages[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
