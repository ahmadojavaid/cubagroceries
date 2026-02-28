import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/images.dart';

class ShopListComponent extends StatefulWidget {
  final double? horizontalPadding;

  const ShopListComponent({super.key, this.horizontalPadding});

  @override
  State<ShopListComponent> createState() => _ShopListComponentState();
}

class _ShopListComponentState extends State<ShopListComponent> {
  final List<Map<String, dynamic>> shopDetails = [
    {
      'name': 'Caffely Astoria Aromas',
      'location': '350 5th Ave, New York, NY',
      'distance': '1.2km',
      'rating': 4.8,
      'reviews': '2.4k reviews',
      'image': Images.img_cafe11
    },
    {
      'name': 'Caffely West Village Waking',
      'location': '285 Fulton St, New york ,Ny',
      'distance': '1.5km',
      'rating': 4.6,
      'reviews': '1.9k reviews',
      'image': Images.img_cafe2
    },
    {
      'name': 'Caffely Upper East Espresso',
      'location': '45 Rockefeller Plaza, New York, Ny',
      'distance': '1.8km',
      'rating': 4.7,
      'reviews': '2.2k reviews',
      'image': Images.img_cafe3
    },
    {
      'name': 'Caffely Manhattan Morning',
      'location': '89 E 42nd St.New York,Ny',
      'distance': '2.0km',
      'rating': 4.5,
      'reviews': '1.7k reviews',
      'image': Images.img_cafe4
    },
    {
      'name': 'Caffely Wall Street',
      'location': '285 Fulton St, New york ,Ny',
      'distance': '1.5km',
      'rating': 4.2,
      'reviews': '1.9k reviews',
      'image': Images.img_cafe5
    },
    {
      'name': 'Caffely Upper East Expresso',
      'location': '285 Fulton St, New york ,Ny',
      'distance': '1.5km',
      'rating': 4.1,
      'reviews': '1.8k reviews',
      'image': Images.img_cafe6
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding ?? 0, vertical: 18),
        itemCount: shopDetails.length,
        itemBuilder: (context, index) {
          final shop = shopDetails[index];
          return Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network(shop['image'], fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shop['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 15, color: PickColor.brownColor),
                              4.width,
                              Flexible(
                                child: Marquee(
                                  child: Text(
                                    '${shop['distance']} (${shop['location']})',
                                    style: TextStyle(
                                        fontSize: 14), // Add styling as needed
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: PickColor.orange, size: 15),
                              const Icon(Icons.star,
                                  color: PickColor.orange, size: 15),
                              const Icon(Icons.star,
                                  color: PickColor.orange, size: 15),
                              const Icon(Icons.star,
                                  color: PickColor.orange, size: 15),
                              Icon(
                                shop['rating'] >= 4.5
                                    ? Icons.star_half
                                    : Icons.star_border,
                                color: PickColor.orange,
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${shop['rating']} ",
                                style: TextStyle(fontSize: 14), // Optional
                              ),
                              Flexible(
                                child: Marquee(
                                  child: Text(
                                    "(${shop['reviews']})",
                                    style: TextStyle(fontSize: 14),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      color: PickColor.greyColor, size: 18),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Divider(color: PickColor.borderColor),
          );
        },
      ),
    );
  }
}
