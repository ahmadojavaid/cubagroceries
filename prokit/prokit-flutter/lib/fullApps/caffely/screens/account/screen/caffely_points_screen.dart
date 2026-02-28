import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../model/caffely_points_model.dart';

class CaffelyPointsScreen extends StatefulWidget {
  const CaffelyPointsScreen({super.key});

  @override
  State<CaffelyPointsScreen> createState() => _CaffelyPointsScreenState();
}

List<PointListsModel> pointListData = pointLists();

class _CaffelyPointsScreenState extends State<CaffelyPointsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Caffely Points", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: PickColor.brownColor, borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
                const Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    "Total Caffely Points",
                    style: TextStyle(color: PickColor.whiteColor, fontSize: 10),
                  ),
                ),
                const Positioned(
                  top: 40,
                  left: 20,
                  child: Text(
                    "25",
                    style: TextStyle(color: PickColor.whiteColor, fontSize: 35),
                  ),
                ),
                const Positioned(
                  top: 90,
                  left: 20,
                  child: Text(
                    "100 points = \$100 You can use those points as payment.",
                    style: TextStyle(color: PickColor.whiteColor, fontSize: 10),
                  ),
                ),
                const Positioned(
                  top: 20,
                  right: 20,
                  child: Icon(
                    Icons.crop_free_outlined,
                    color: PickColor.whiteColor,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Points History",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    //
                  },
                  child: const Text("View All  >", style: TextStyle(color: PickColor.brownColor)),
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: pointListData.length,
                itemBuilder: (context, index) {
                  final point = pointListData[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(point.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(point.price, style: const TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(point.date, style: const TextStyle(fontSize: 13, color: PickColor.greyColor)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(color: PickColor.borderColor),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
