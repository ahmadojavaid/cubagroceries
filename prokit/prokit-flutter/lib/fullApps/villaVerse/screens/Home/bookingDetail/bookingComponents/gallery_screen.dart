import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../../main.dart';
import '../../../../component/my_app_bar.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/image.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<String> bedroom = [welcomeImage1, interior3, welcomeImage2, welcomeImage2, interior2, interior1];
  List<String> bathroom = [welcomeImage2, interior1, welcomeImage1, welcomeImage2, interior2, interior1];
  List<String> parking = [welcomeImage1, interior3, welcomeImage3, welcomeImage2, interior2, interior1];
  List<String> kitchen = [welcomeImage3, interior2, welcomeImage1, welcomeImage2, interior2, interior1];
  List<String> livingRoom = [welcomeImage2, interior3, welcomeImage2, welcomeImage2, interior2, interior1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      appBar: MyAppBar(title: 'Gallery'),
      body: ListView(
        children: [
          20.height,
          titleText('Bedroom'),
          12.height,
          SizedBox(
            height: 100,
            child: AnimatedListView(
              scrollDirection: Axis.horizontal,
              itemCount: bedroom.length,
              itemBuilder: (context, index) {
                return galleryImage(bedroom[index]).paddingSymmetric(horizontal: index == 0 ? 16 : 8);
              },
            ),
          ),
          20.height,
          titleText('Bathroom'),
          12.height,
          SizedBox(
            height: 100,
            child: AnimatedListView(
              scrollDirection: Axis.horizontal,
              itemCount: bathroom.length,
              itemBuilder: (context, index) {
                return galleryImage(bathroom[index]).paddingSymmetric(horizontal: index == 0 ? 16 : 8);
              },
            ),
          ),
          20.height,
          titleText('Living Room'),
          12.height,
          SizedBox(
            height: 100,
            child: AnimatedListView(
              scrollDirection: Axis.horizontal,
              itemCount: livingRoom.length,
              itemBuilder: (context, index) {
                return galleryImage(livingRoom[index]).paddingSymmetric(horizontal: index == 0 ? 16 : 8);
              },
            ),
          ),
          20.height,
          titleText('Kitchen'),
          12.height,
          SizedBox(
            height: 100,
            child: AnimatedListView(
              scrollDirection: Axis.horizontal,
              itemCount: kitchen.length,
              itemBuilder: (context, index) {
                return galleryImage(kitchen[index]).paddingSymmetric(horizontal: index == 0 ? 16 : 8);
              },
            ),
          ),
          20.height,
          titleText('Parking'),
          12.height,
          SizedBox(
            height: 100,
            child: AnimatedListView(
              scrollDirection: Axis.horizontal,
              itemCount: parking.length,
              itemBuilder: (context, index) {
                return galleryImage(parking[index]).paddingSymmetric(horizontal: index == 0 ? 16 : 8);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: boldTextStyle(size: 16),
    ).paddingSymmetric(horizontal: 16);
  }

  Widget galleryImage(String imgPath) {
    return SizedBox(
      height: 100,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(imgPath, fit: BoxFit.cover),
      ),
    );
  }
}
