import 'package:flutter/material.dart';
import 'package:prokit_flutter/dashboard/frezka/screens/home_screen.dart';
import 'package:prokit_flutter/dashboard/frezka/model/package_model.dart';
import 'package:prokit_flutter/dashboard/frezka/utils/common.dart';

class MakupList extends StatelessWidget {
  const MakupList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: titleRowWidget("More In Makup", ""),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 132,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: makupList.length,
            itemBuilder: (context, index) {
              CategoryModel nail = makupList[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 24 : 8,
                  right: index == (makupList.length - 1) ? 24 : 8,
                ),
                child: Container(
                  height: 132,
                  width: 113,
                  decoration: decoratedContainerWidget(),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        child: Image.network(
                          nail.imagePath,
                          height: 95,
                          width: 113,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: txtWidget(
                          nail.title,
                          12,
                          FontWeight.w500,
                          frezlaAppColor.dateTxtColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
