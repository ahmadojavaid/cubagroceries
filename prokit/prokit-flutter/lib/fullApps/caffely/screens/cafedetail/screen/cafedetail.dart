import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../checkout/screen/check_out_screen.dart';
import '../../home/components/imagecarousel/imageplaceholder_component.dart';
import '../../popularmenu/components/popular_menu_component.dart';
import '../../productdetail/screen/model/product_detail_model.dart';
import '../../rating&reviews/screen/rating&reviews_screen.dart';
import '../../specialoffer/screen/specialofferlist_screen.dart';
import '../model/cafe_detail_model.dart';
import 'description_of_cafe_screen.dart';

class CafeDetailScreen2 extends StatefulWidget {
  final ProductDetailModel productDetail;

  const CafeDetailScreen2({super.key, required this.productDetail});

  @override
  State<CafeDetailScreen2> createState() => _CafedetailState();
}

class _CafedetailState extends State<CafeDetailScreen2> {
  int _selectedIndex = 0;
  List<Widget> _crousel = [];
  int _activePage = 0;
  bool _isLiked = false;

  final PageController _pageController = PageController(initialPage: 0);

  final List<Map<String, String?>> nearbyShops = [
    {"image": Images.img_cafe11},
    {"image": Images.img_cafe2},
    {"image": Images.img_cafe3},
    {"image": Images.img_cafe4},
  ];

  List<String> menuList = ["Coffee", "Baked", "Sandwich", "Cakes", "Noodels", "Drinks"];

  List<CafeDetailModel> productListData = cafeProductList();

  @override
  void initState() {
    super.initState();
    _crousel = List.generate(
      nearbyShops.length,
      (index) => ImagePlaceholderComponent(
        imagePath: nearbyShops[index]["image"],
        fit: BoxFit.cover,
        borderRadius: BorderRadius.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 300,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: nearbyShops.length,
                        onPageChanged: (value) {
                          setState(() {
                            _activePage = value;
                          });
                        },
                        itemBuilder: (context, index) {
                          return _crousel[index];
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      left: 0,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _crousel.length,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: InkWell(
                                onTap: () {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn,
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 4,
                                  backgroundColor: _activePage == index ? PickColor.whiteColor : PickColor.greyColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40.0,
                      left: 10.0,
                      right: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: PickColor.whiteColor.withOpacity(0.5),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back, color: PickColor.whiteColor),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: PickColor.whiteColor.withOpacity(0.5),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    _isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: _isLiked ? Colors.red : Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isLiked = !_isLiked;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.share, color: Colors.white),
                                  onPressed: () {
                                    const String textToShare = CafeDetailText.checkOutThisAmazingContent;
                                    Share.share(textToShare);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DescriptionOfCafeScreen()),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              CafeDetailText.caffelyAstoriaAromas,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Color.fromARGB(255, 214, 213, 213), thickness: 1),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RatingReviewsScreen()),
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star, color: Color.fromARGB(255, 185, 113, 4)),
                                SizedBox(width: 10),
                                Text(CafeDetailText.rating, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                SizedBox(width: 12),
                                Text(CafeDetailText.review),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios, size: 20)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Color.fromARGB(255, 214, 213, 213), thickness: 1),
                    const SizedBox(height: 5),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on_sharp, color: PickColor.brownColor),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(CafeDetailText.km, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              SizedBox(height: 4),
                              Text(CafeDetailText.availableForPickUpAndDelivery),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Divider(color: Color.fromARGB(255, 214, 213, 213), thickness: 1),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SpecialOfferListScreen()),
                          ),
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.discount, color: PickColor.brownColor),
                                SizedBox(width: 10),
                                Text(
                                  CafeDetailText.promosAreAvailable,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios, size: 20)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: _selectedIndex == index ? Colors.transparent : const Color.fromARGB(255, 214, 213, 213),
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 0,
                                backgroundColor: _selectedIndex == index ? PickColor.brownColor : PickColor.whiteColor,
                              ),
                              child: Text(
                                menuList[index],
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
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  // Disable internal scrolling
                  shrinkWrap: true,
                  // Adjust height to fit parent
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items per row
                    crossAxisSpacing: 16, // Horizontal spacing between grid items
                    mainAxisSpacing: 16, // Vertical spacing between grid items
                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.width * 1.3), // Adjust aspect ratio if needed
                  ),
                  itemCount: productListData.length,
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  itemBuilder: (context, index) {
                    return PopularMenuComponent(
                      coffeeImg: productListData[index].image,
                      name: productListData[index].name,
                      price: productListData[index].price.toString(),
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
                const SizedBox(height: 110)
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen())),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: PickColor.brownColor,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total item(s)",
                          style: TextStyle(color: PickColor.whiteColor, fontSize: 12),
                        ),
                        Text(
                          widget.productDetail.totalPrize,
                          style: const TextStyle(color: PickColor.whiteColor, fontSize: 18),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text(
                          "Checkout",
                          style: TextStyle(color: PickColor.whiteColor, fontSize: 16),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward_ios, color: PickColor.whiteColor, size: 18),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
