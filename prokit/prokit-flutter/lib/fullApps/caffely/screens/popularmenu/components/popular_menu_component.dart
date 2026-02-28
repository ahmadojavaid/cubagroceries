import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../productdetail/screen/product_deatil_screen.dart';

class PopularMenuComponent extends StatelessWidget {
  final String coffeeImg; // Change to String to hold the asset path
  final String name;
  final String price;
  final EdgeInsetsGeometry? padding;

  const PopularMenuComponent({
    super.key,
    required this.coffeeImg,
    required this.name,
    required this.price,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Outer container with box shadow
            Container(
              width: double.infinity,
              // Adjusting height to accommodate both image and text
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white, // Set to white for the background
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(3, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image container with shadow
                  Container(
                    width: double.infinity,
                    height: 146, // Adjust image size
                    decoration: BoxDecoration(
                      color: PickColor.borderColor,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(3, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center, // Center align the contents of the Stack
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8), // Round the image corners
                          child: Image.network(
                            coffeeImg,
                            width: 80, // Adjust width for better appearance
                            height: 80, // Adjust height for better appearance
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5), // Space between image and text
                  // Text container
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name text
                        Text(
                          name,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16, // Optional: Increase font size for better readability
                          ),
                        ),
                        // Price text
                        Text(
                          "\$ $price",
                          style: const TextStyle(
                            color: PickColor.brownColor,
                            fontSize: 14, // Optional: Increase font size for better readability
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
