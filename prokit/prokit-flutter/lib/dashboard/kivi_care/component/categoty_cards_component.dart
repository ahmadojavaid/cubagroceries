import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/dashboard/kivi_care/screen/home_screen.dart';
import 'package:prokit_flutter/dashboard/kivi_care/utils/common.dart';

class CategotyCards extends StatelessWidget {
  const CategotyCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 195,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRowWidget(kiviCareAppString.category, kiviCareAppString.seeAll),
          const SizedBox(height: 8),
          SizedBox(
            height: 160, 
            child: ListView.builder(
              scrollDirection: Axis.horizontal, 
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                final item = categoryList[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 20 : 8,
                    right: index == (categoryList.length - 1) ? 20 : 8,
                  ),
                  child: Container(
                    width: 116,
                    height: 155,
                    decoration: BoxDecoration(
                      color: kiviCareAppColor.whiteColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 18,
                      ),
                      child: SizedBox(
                        height: 22,
                        width: 72,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 12),
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: NetworkImage(item['imagepath']!),
                            ),
                            const SizedBox(height: 12),
                            Marquee(
                              direction: Axis.horizontal,
                              child: txtWidget(
                                item['title']!,
                                12,
                                FontWeight.w600,
                                kiviCareAppColor.headingColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


List<Map<String, String>> categoryList = [
  {"imagepath": kiviCareAppImages.generalCheckUP, "title": "General CheckUp"},
  {"imagepath": kiviCareAppImages.dermatology, "title": "Dermatology"},
  {"imagepath": kiviCareAppImages.psychiatrists, "title": "Psychiatrists"},
  {"imagepath": kiviCareAppImages.dieticians, "title": "Dieticians"},
];
