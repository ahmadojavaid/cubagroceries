import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../nearbyshop/components/nearbyshoplist_component.dart';
import '../../nearbyshop/screen/nearby_shop_screen.dart';
import '../../notification/screen/notification_screen.dart';
import '../../popularmenu/components/popular_menu_list_component.dart';
import '../../popularmenu/screen/popular_menu_screen.dart';
import '../components/imagecarousel/home_carousel_component.dart';

class HomeContentScreen extends StatelessWidget {
  const HomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      //TODO: image var
                      child: Image.network(
                        Images.img_user,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Good Morning ⛅"),
                        Text("Andrew Ainsley", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color.fromARGB(255, 167, 164, 164), width: 2.0),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(Images.ic_notification),
                        iconSize: 20,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const NotificationScreen()),
                          );
                        },
                      ),
                      Positioned(
                        top: 7.5,
                        right: 7.5,
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const HomeCarouselComponent(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  HomePageText.nearby,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NearbyShopScreen()));
                  },
                  child: const Text(
                    "View All  >",
                    style: TextStyle(
                      color: PickColor.brownColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const NearByShopListComponent(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  HomePageText.popularMenu,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PopularMenuScreen()));
                  },
                  child: const Text(
                    HomePageText.viewAll,
                    style: TextStyle(color: PickColor.brownColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const PopularMenuListComponent(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
