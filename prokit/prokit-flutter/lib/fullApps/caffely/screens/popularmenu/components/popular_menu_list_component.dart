import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/popularmenu/components/popular_menu_component.dart';

import '../../cafedetail/model/cafe_detail_model.dart';

class PopularMenuListComponent extends StatefulWidget {
  const PopularMenuListComponent({super.key});

  @override
  State<PopularMenuListComponent> createState() => _PopularMenuListComponentState();
}

List<CafeDetailModel> productListData = cafeProductList();

class _PopularMenuListComponentState extends State<PopularMenuListComponent> {
  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
      shrinkWrap: true,
      // Let GridView size itself based on content
      physics: const NeverScrollableScrollPhysics(),
      // Disable scrolling inside
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items in a row
        crossAxisSpacing: 16, // Space between columns
        mainAxisSpacing: 16, // Space between rows
        childAspectRatio: screenWidth / (screenWidth * 1.3), // Dynamic aspect ratio
      ),
      itemCount: productListData.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return PopularMenuComponent(
          coffeeImg: productListData[index].image,
          name: productListData[index].name,
          price: productListData[index].price.toString(),
          padding: EdgeInsets.zero, // Remove additional padding
        );
      },
    );
  }
}
