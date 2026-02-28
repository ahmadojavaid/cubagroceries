import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/images.dart';
import '../../home/components/imagecarousel/imageplaceholder_component.dart';
import '../../popularmenu/components/popular_menu_component.dart';
import '../../rating&reviews/screen/rating&reviews_screen.dart';
import '../../specialoffer/screen/specialofferlist_screen.dart';
import '../model/cafe_detail_model.dart';
import 'description_of_cafe_screen.dart';

class CafedetailScreen extends StatefulWidget {
  const CafedetailScreen({Key? key}) : super(key: key);

  @override
  State<CafedetailScreen> createState() => _CafedetailState();
}

final List<Map<String, String?>> nearbyShops = [
  {"image": Images.img_cafe11},
  {"image": Images.img_cafe2},
  {"image": Images.img_cafe3},
  {"image": Images.img_cafe4},
];

List<String> menuList = ["Coffee", "Baked", "Sandwich", "Cakes", "Noodels", "Drinks"];

List<CafeDetailModel> productListData = cafeProductList();

class _CafedetailState extends State<CafedetailScreen> {
  int _selectedIndex = 0;
  List<Widget> _crousel = [];
  int _activePage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _crousel = List.generate(
      nearbyShops.length,
      (index) => ImagePlaceholderComponent(
        imagePath: nearbyShops[index]["image"],
        borderRadius: const BorderRadius.only(bottomLeft: Radius.zero, bottomRight: Radius.zero),
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carousel Section
            Stack(
              children: [
                Column(
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
                      ],
                    ),
                  ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DescriptionOfCafeScreen()));
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
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RatingReviewsScreen())),
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(Icons.star, color: Color.fromARGB(255, 185, 113, 4)),
                          SizedBox(width: 10),
                          Text(CafeDetailText.rating, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(width: 12),
                          Text(CafeDetailText.review)
                        ]),
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
                // Menu selection list
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    children: List.generate(menuList.length, (index) {
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
                ),
                // Popular menu section
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
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  itemCount: productListData.length,
                  itemBuilder: (context, index) {
                    return PopularMenuComponent(
                      coffeeImg: productListData[index].image,
                      name: productListData[index].name,
                      price: productListData[index].price.toString(),
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
