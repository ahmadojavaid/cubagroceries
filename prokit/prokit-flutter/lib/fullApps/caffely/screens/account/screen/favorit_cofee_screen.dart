import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../popularmenu/components/popular_menu_component.dart';
import '../../popularmenu/model/popular_menu_model.dart';

class FavoritCofeeScreen extends StatelessWidget {
  FavoritCofeeScreen({super.key});

  List<PopularMenuModel> popularListData = popularList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Coffee',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.search,
              color: PickColor.blackColor,
            ),
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        // height: 0,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.width * 1.3),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: popularListData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return PopularMenuComponent(
              coffeeImg: popularListData[index].img,
              name: popularListData[index].name,
              price: popularListData[index].price.toString(),
              padding: EdgeInsets.zero,
            );
          },
        ),
      ),
    );
  }
}
