import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../cafedetail/screen/cafe_detail_screen.dart';
import '../model/nearby_shop_list_mode.dart';

class NearbyShopScreen extends StatefulWidget {
  const NearbyShopScreen({super.key});

  @override
  State<NearbyShopScreen> createState() => _NearbyShopScreenState();
}

class _NearbyShopScreenState extends State<NearbyShopScreen> {
  List<NearbyShopListModel> nearShopListData = nearbyShopList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HomePageText.nearby, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: GridView.builder(
          itemCount: nearShopListData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 10, // Horizontal spacing between items
            mainAxisSpacing: 10, // Vertical spacing between items
            childAspectRatio: 0.8, // Adjust the aspect ratio for the grid items
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          itemBuilder: (context, index) {
            return NearByShop(
              image: Image.network(
                nearShopListData[index].image,
              ),
              text: nearShopListData[index].text,
              text2: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                    color: PickColor.brownColor,
                  ),
                  Text(nearShopListData[index].text2),
                ],
              ),
              rating: nearShopListData[index].rating,
            );
          },
        ),
      ),
    );
  }
}

class NearByShop extends StatelessWidget {
  final Image image;
  final String text;
  final Widget text2;
  final String rating;

  const NearByShop({
    super.key,
    required this.image,
    required this.text,
    required this.text2,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CafedetailScreen())),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: PickColor.whiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: PickColor.greyColor.shade100,
              offset: const Offset(3, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(
                        image: image.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: PickColor.yellow,
                            size: 14,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            rating,
                            style: const TextStyle(
                              color: PickColor.whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      text,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  text2,
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
