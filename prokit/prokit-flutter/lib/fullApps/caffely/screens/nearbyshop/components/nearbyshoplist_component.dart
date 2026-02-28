import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../model/nearby_shop_list_mode.dart';
import 'nearbyshop_component.dart';

class NearByShopListComponent extends StatefulWidget {
  const NearByShopListComponent({super.key});

  @override
  State<NearByShopListComponent> createState() => _NearByShopListComponentState();
}

List<NearbyShopListModel> nearShopDataList = nearbyShopList();

class _NearByShopListComponentState extends State<NearByShopListComponent> {
  final limitedShopData = nearShopDataList.take(4).toList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ListView.builder(
        itemCount: limitedShopData.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(right: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: NearByShopComponent(
              image: Image.network(
                limitedShopData[index].image,
              ),
              text: limitedShopData[index].text,
              text2: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: PickColor.brownColor,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(limitedShopData[index].text2),
                ],
              ),
              rating: limitedShopData[index].rating,
            ),
          );
        },
      ),
    );
  }
}
