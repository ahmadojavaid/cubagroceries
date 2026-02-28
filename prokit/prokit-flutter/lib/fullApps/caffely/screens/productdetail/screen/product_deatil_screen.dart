import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../cafedetail/screen/cafedetail.dart';
import '../components/categorylist_screen.dart';
import 'model/product_detail_model.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductdeatilState();
}

class _ProductdeatilState extends State<ProductDetailScreen> {
  bool _isLiked = false;
  int _selectedCoffeeType = 0;
  int _selectedSize = 0;

  int _quantity = 1;
  final double _pricePerUnit = 3.50;

  // Calculate total price based on quantity
  double get totalPrice => _quantity * _pricePerUnit;

  final ProductDetailModel productDetail = ProductDetailModel(
    productName: "Classic Brew",
    productPrize: "\$${3.50}",
    availableIn: "Hot",
    size: "Tall",
    totalPrize: "", // Will be updated with calculated total
  );

  void updateProductDetailModel() {
    productDetail.size = _selectedSize == 0
        ? "Tall"
        : _selectedSize == 1
            ? "Grande"
            : "Venti";
    productDetail.totalPrize = "\$${totalPrice.toStringAsFixed(2)}";
    productDetail.availableIn = _selectedCoffeeType == 1 ? "Hot" : "Iced";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: PickColor.blackColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: SvgPicture.asset(
                            _isLiked ? Images.ic_favorite : Images.ic_unfavorite,
                          ),
                          onPressed: () {
                            setState(() {
                              _isLiked = !_isLiked;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.share_outlined, color: PickColor.blackColor),
                          onPressed: () {
                            const String textToShare = PopularMenuText.checkAmazingContent;
                            Share.share(textToShare);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      height: 300,
                      width: 400,
                      decoration: const BoxDecoration(
                        color: PickColor.borderColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 50,
                      child: Image.network(
                        Images.img_coffeCup,
                        height: 250,
                        width: 250,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          PopularMenuText.classicBrew,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(PopularMenuText.classicBrewPrice, style: TextStyle(fontSize: 18))
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              if (_quantity > 1) {
                                _quantity--;
                              }
                            });
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: PickColor.brownColor, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              shape: BoxShape.rectangle,
                            ),
                            child: const Icon(Icons.remove, size: 20, color: PickColor.brownColor),
                          ),
                        ),
                        Text(
                          "$_quantity",
                          style: const TextStyle(fontSize: 20),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: PickColor.brownColor, width: 1),
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              shape: BoxShape.rectangle,
                            ),
                            child: const Icon(Icons.add, size: 20, color: PickColor.brownColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: PickColor.borderColor, thickness: 1),
                const SizedBox(height: 10),
                const Text(
                  PopularMenuText.availableIn,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCoffeeType = 1;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedCoffeeType == 1 ? PickColor.brownColor : PickColor.borderColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(Images.img_hotCoffeeCup),
                            const SizedBox(height: 5),
                            const Text(CheckOutText.hot),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCoffeeType = 2;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedCoffeeType == 2 ? PickColor.brownColor : PickColor.borderColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(Images.img_iceCoffeeCup),
                            const SizedBox(height: 5),
                            const Text(CheckOutText.iced),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Size", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSize = 0;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedSize == 0 ? PickColor.brownColor : PickColor.borderColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(Images.img_hotCoffeeCup, height: 25),
                            const SizedBox(height: 5),
                            const Text("Tall", style: TextStyle(fontWeight: FontWeight.bold)),
                            const Text("Free"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSize = 1;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedSize == 1 ? PickColor.brownColor : PickColor.borderColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(Images.img_hotCoffeeCup, height: 30),
                            const SizedBox(height: 5),
                            const Text("Grande", style: TextStyle(fontWeight: FontWeight.bold)),
                            const Text("+ 0.50"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSize = 2;
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedSize == 2 ? PickColor.brownColor : PickColor.borderColor,
                          ),
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(Images.img_hotCoffeeCup, height: 35),
                            const SizedBox(height: 5),
                            const Text("Venti", style: TextStyle(fontWeight: FontWeight.bold)),
                            const Text("+ 1.00"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(color: PickColor.borderColor),
                const SizedBox(height: 10),
                const CategoryListScreen(),
                const Divider(color: PickColor.borderColor),
                const Text("Notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const TextField(
                  decoration: InputDecoration(
                    fillColor: PickColor.borderColor,
                    filled: true,
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PickColor.blackTransparent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: PickColor.blackTransparent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    isDense: true,
                    hintText: "Example: No added cream",
                    hintStyle: TextStyle(color: PickColor.greyColor),
                  ),
                  maxLines: null,
                  minLines: 3,
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: PickColor.borderColor,
              border: Border.all(
                color: PickColor.borderColor,
                width: 1.0,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Total price\n\$${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: PickColor.blackColor,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      updateProductDetailModel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CafeDetailScreen2(productDetail: productDetail),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: PickColor.brownColor),
                    child: const Center(
                      child: Text(
                        PopularMenuText.addBasket,
                        style: TextStyle(fontSize: 18, color: PickColor.whiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
