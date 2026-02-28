import 'package:flutter/material.dart';
import 'package:prokit_flutter/fullApps/caffely/screens/shop/screen/recent_search_shop_screen.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import 'components/shop_list.dart';

class ShopHomeScreen extends StatefulWidget {
  const ShopHomeScreen({super.key});

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  bool isAllSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Images.ic_appIcon, width: 30, height: 30),
                const Text("Shop", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RecentSearchShopScreen()),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 20),
                    Text(
                      "Your Location",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "New York",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Icon(Icons.arrow_drop_down, color: PickColor.brownColor, size: 30),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Custom Toggle Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllSelected = true;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: isAllSelected ? PickColor.brownColor : PickColor.borderColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "All",
                          style: TextStyle(
                            color: isAllSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isAllSelected = false;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: !isAllSelected ? PickColor.brownColor : PickColor.borderColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Favorites",
                          style: TextStyle(
                            color: !isAllSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            isAllSelected ? const ShopListComponent() : const ShopListComponent(),
          ],
        ),
      ),
    );
  }
}
