import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/frezka/model/package_model.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRowWidget("Our Category", "View All"),
          const SizedBox(height: 0),
          GridView.builder(
            itemCount: categoryList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 18,
              crossAxisSpacing: 12,
              childAspectRatio: 0.70,
            ),
            itemBuilder: (context, index) {
              final category = categoryList[index];
              return Container(
                height: 200,
                width: 150,
                decoration: BoxDecoration(
                  color: frezlaAppColor.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: frezlaAppColor.black.withAlpha((0.05 * 255).toInt()),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.network(
                        category.imagePath,
                        height: 95,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: txtWidget(
                          category.title,
                          12,
                          FontWeight.w500,
                          frezlaAppColor.dateTxtColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
