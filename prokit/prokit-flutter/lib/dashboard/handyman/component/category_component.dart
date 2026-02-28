import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/handyman/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/handyman/utils/common.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final List<Map<String, String>> categories = [
    {"title": "AC Repair", "image": handymanAppImages.acRepair},
    {"title": "Carpenter", "image": handymanAppImages.carprnter},
    {"title": "Cleaning", "image": handymanAppImages.cleaning},
    {"title": "Cooking", "image": handymanAppImages.cooking},
    {"title": "Electrician", "image": handymanAppImages.electritian},
    {"title": "Painter", "image": handymanAppImages.painter},
    {"title": "Salon", "image": handymanAppImages.salon},
    {"title": "Plumber", "image": handymanAppImages.plumber},
  ];
  @override
  Widget build(BuildContext context) {
    final List<List<Map<String, String>>> twoRowChunks = [];
    for (int i = 0; i < categories.length; i += 2) {
      final chunk = categories.sublist(
        i,
        i + 2 > categories.length ? categories.length : i + 2,
      );
      twoRowChunks.add(chunk);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row
        titleRowWidget("Category", "View All"),
        const SizedBox(height: 12),
        SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: twoRowChunks.asMap().entries.map((entry) {
                final index = entry.key;
                final chunk = entry.value;
                final isLast = index == twoRowChunks.length - 1;
                return Padding(
                  padding: EdgeInsets.only(right: isLast ? 0 : 12),
                  child: Column(
                    children: chunk.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SizedBox(
                          width: 120,
                          height: 125,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(item['image']!, fit: BoxFit.cover),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        handymanAppColor.transparent,
                                        handymanAppColor.black6,
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      item['title']!,
                                      style: TextStyle(
                                        color: handymanAppColor.constWhite,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
