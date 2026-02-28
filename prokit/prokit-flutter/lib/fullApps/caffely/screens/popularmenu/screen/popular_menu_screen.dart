import 'package:flutter/material.dart';

import '../../../utils/constant.dart';
import '../../productdetail/screen/product_deatil_screen.dart';
import '../model/popular_menu_model.dart';

class PopularMenuScreen extends StatelessWidget {
  PopularMenuScreen({super.key});

  List<PopularMenuModel> popularListData = popularList();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          PopularMenuText.pupularMenu,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of items per row
          crossAxisSpacing: 16, // Spacing between columns
          mainAxisSpacing: 16, // Spacing between rows
          childAspectRatio: screenWidth / (screenWidth * 1.3), // Adjust based on the aspect ratio of your items
        ),
        itemCount: popularListData.length,
        // Number of items
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return PopularMenu(
            coffeeImg: popularListData[index].img,
            name: popularListData[index].name,
            price: popularListData[index].price.toString(),
          );
        },
      ),
    );
  }
}

class PopularMenu extends StatelessWidget {
  final String coffeeImg;
  final String name;
  final String price;

  const PopularMenu({
    super.key,
    required this.coffeeImg,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
      ),
      child: Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(3, 4),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 212, 211, 211),
                borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8)),
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(coffeeImg, width: 80, height: 80, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$ $price',
                    style: const TextStyle(color: Color.fromARGB(255, 105, 48, 27), fontSize: 16),
                    overflow: TextOverflow.ellipsis,
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
