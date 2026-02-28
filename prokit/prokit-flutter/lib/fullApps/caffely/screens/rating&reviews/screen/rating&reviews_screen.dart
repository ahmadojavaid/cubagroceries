import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../components/rating_bar_component.dart';
import '../components/star_icon_component.dart';

class RatingReviewsScreen extends StatefulWidget {
  const RatingReviewsScreen({super.key});

  @override
  State<RatingReviewsScreen> createState() => _RatingReviewsState();
}

class _RatingReviewsState extends State<RatingReviewsScreen> {
  int _selectedIndex = -1;
  List<String> menuList = ["Sorted by", "5", "4", "3", "2", "1"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RatingText.ratingAndReviews, style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: 140,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          CafeDetailText.rating,
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: PickColor.orange, size: 24),
                            Icon(Icons.star, color: PickColor.orange, size: 24),
                            Icon(Icons.star, color: PickColor.orange, size: 24),
                            Icon(Icons.star, color: PickColor.orange, size: 24),
                            Icon(Icons.star_half, color: PickColor.orange, size: 24),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text("(2.4k reviews)", style: TextStyle(color: PickColor.greyColor, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(width: 10),
                    const VerticalDivider(color: PickColor.greyColor, thickness: 1),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          buildRatingBar(5, 0.9),
                          buildRatingBar(4, 0.7),
                          buildRatingBar(3, 0.4),
                          buildRatingBar(2, 0.2),
                          buildRatingBar(1, 0.1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1),
              Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(6, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: _selectedIndex == index ? PickColor.blackTransparent : PickColor.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 0,
                              backgroundColor: _selectedIndex == index ? PickColor.brownColor : PickColor.whiteColor,
                            ),
                            child: Text(
                              index == 0 ? menuList[index] : '⭐ ${menuList[index]}',
                              style: TextStyle(
                                color: _selectedIndex == index ? PickColor.whiteColor : PickColor.blackColor,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Image.network(
                              Images.img_user2,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 13),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(RatingText.augustina, style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text(RatingText.daysAgo),
                            ],
                          ),
                        ],
                      ),
                      const StarIconComponent(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(RatingText.comment1, style: TextStyle(height: 1.5)),
                  const SizedBox(height: 10),
                  const Divider(color: PickColor.borderColor),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Image.network(
                              Images.img_user3,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 13),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                RatingText.tanner,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(RatingText.daysAgo2)
                            ],
                          ),
                        ],
                      ),
                      const StarIconComponent(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(RatingText.comment2, style: TextStyle(height: 1.5)),
                  const SizedBox(height: 10),
                  const Divider(color: PickColor.borderColor),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Image.network(
                              Images.img_user4,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 13),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(RatingText.krishna, style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text(RatingText.daysAgo3),
                            ],
                          ),
                        ],
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, size: 16, color: PickColor.orange),
                              Icon(Icons.star, size: 16, color: PickColor.orange),
                              Icon(Icons.star, size: 16, color: PickColor.orange),
                              Icon(Icons.star, size: 16, color: PickColor.orange),
                              Icon(Icons.star_border, size: 16, color: PickColor.orange),
                            ],
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.more_vert, size: 25)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(RatingText.comment3, style: TextStyle(height: 1.5)),
                  const SizedBox(height: 10),
                  const Divider(color: PickColor.borderColor),
                  const SizedBox(height: 10),
                  //forth
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipOval(
                            child: Image.network(
                              Images.img_user5,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 13),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(RatingText.rodolfo, style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text(RatingText.daysAgo6),
                            ],
                          ),
                        ],
                      ),
                      const StarIconComponent(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(RatingText.comment4, style: TextStyle(height: 1.5))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
