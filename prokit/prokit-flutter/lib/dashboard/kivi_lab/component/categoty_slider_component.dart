import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/component/category_items_component.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/model/category_model.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_lab/utils/common.dart';

class CategotySlider extends StatelessWidget {
  const CategotySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        titleRowWidget(kiviLabAppStrings.category, kiviLabAppStrings.viewAll),
        const SizedBox(height: 16), 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.builder(
            itemCount: categoryList.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero, 
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 12, 
              childAspectRatio: 0.95, 
            ),
            itemBuilder: (context, index) {
              final item = categoryList[index];
              return ServiceItem(imagePath: item.image, title: item.title);
            },
          ),
        ),
      ],
    );
  }
}
