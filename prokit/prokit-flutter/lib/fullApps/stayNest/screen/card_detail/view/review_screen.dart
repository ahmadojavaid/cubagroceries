// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class Review {
  final String name;
  final String date;
  final double rating;
  final String comment;
  final String avatar;

  Review(this.name, this.date, this.rating, this.comment, this.avatar);
}

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int? selectedRating;

  final List<Review> reviews = [
    Review(
      "Jenny Wilson",
      "Dec 10, 2024",
      5.2,
      "Very nice and comfortable hotel, thank you for accompanying my vacation!",
      userImage,
    ),
    Review(
      "Guy Hawkins",
      "Dec 10, 2024",
      4.3,
      "Very beautiful hotel, my family and I are very satisfied with the service!",
      userImage,
    ),
    Review(
      "Kristin Watson",
      "Dec 09, 2024",
      5.5,
      "The rooms are very comfortable and the natural views are amazing, can't wait to come back again!",
      userImage,
    ),
    Review(
      "Darrell Steward",
      "Dec 09, 2024",
      5.1,
      "Extraordinary! I am very happy with the facilities and services provided! Highly recommended!",
      userImage,
    ),
    Review(
      "Kristin Watson",
      "Dec 09, 2024",
      3.8,
      "The rooms are very comfortable and the natural views are amazing, can't wait to come back again!",
      userImage,
    ),
    Review(
      "Darrell Steward",
      "Dec 09, 2024",
      2.8,
      "Extraordinary! I am very happy with the facilities and services provided! Highly recommended!",
      userImage,
    ),
  ];

  List<Review> get filteredReviews {
    if (selectedRating == null) return reviews;
    return reviews.where((review) => review.rating.floor() == selectedRating).toList();
  }

  Widget ratingFilterButton(String label, int? rating) {
    final isSelected = selectedRating == rating;
    return ChoiceChip(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      showCheckmark: false,
      label: Text(
        label,
        style: primaryTextStyle(color: isSelected ? whiteColor : Colors.black),
      ),
      selected: isSelected,
      onSelected: (_) => setState(() => selectedRating = rating),
      selectedColor: stayNestPrimaryColor,
      backgroundColor: Colors.grey.shade200,
    ).paddingSymmetric(horizontal: 5, vertical: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      appBar: AppBar(
        title: Text('Review', style: boldTextStyle()),
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(
          color: appStore.isDarkModeOn ? Colors.white : Colors.black,
        ),
        backgroundColor: appStore.isDarkModeOn ? Colors.black : Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ratingFilterButton("All", null),
                ratingFilterButton("5", 5),
                ratingFilterButton("4", 4),
                ratingFilterButton("3", 3),
                ratingFilterButton("2", 2),
              ],
            ),
          ),
          8.height,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                4.width,
                Text("4.8", style: boldTextStyle()),
                8.width,
                Text("(4,981 reviews)", style: secondaryTextStyle()),
              ],
            ),
          ),
          8.height,
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(review.avatar),
                              radius: 24,
                            ),
                            12.width,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          review.name,
                                          style: boldTextStyle(),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: stayNestPrimaryColor,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              size: 14,
                                              color: Colors.yellow,
                                            ),
                                            2.width,
                                            Text(
                                              "${review.rating}",
                                              style: primaryTextStyle(
                                                color: whiteColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  4.height,
                                  Text(
                                    review.date,
                                    style: secondaryTextStyle(size: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        12.height,
                        Text(review.comment, style: secondaryTextStyle()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
