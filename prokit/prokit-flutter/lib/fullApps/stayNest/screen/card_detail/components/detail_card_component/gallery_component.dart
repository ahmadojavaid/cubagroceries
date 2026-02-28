import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';
import '../../view/image_gallery_screen.dart';

Widget buildGallerySection(BuildContext context, int id, List<String> images) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Gallery Photos', style: boldTextStyle(size: 18)),
          TextButton(
            onPressed: () {
              GalleryScreen(hotelid: id).launch(context);
            },
            child: Text('See All', style: TextStyle(color: stayNestPrimaryColor)),
          ),
        ],
      ).paddingSymmetric(horizontal: 16),
      SizedBox(
        height: 80,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          separatorBuilder: (_, __) => SizedBox(width: 10),
          itemBuilder: (_, i) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              images[i],
              width: 100,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}
