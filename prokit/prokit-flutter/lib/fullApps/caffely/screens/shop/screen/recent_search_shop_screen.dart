import 'package:flutter/material.dart';

import 'components/shop_list.dart';

class RecentSearchShopScreen extends StatefulWidget {
  const RecentSearchShopScreen({super.key});

  @override
  State<RecentSearchShopScreen> createState() => _SearchShopScreenState();
}

final List<String> searchList = [
  "Caffely Central Park",
  "Caffely Times Square",
  "Caffely Brooklyn Blend",
  "Caffely Broadway Brews",
  "Caffely SoHo Sips",
  "Caffely Chelsea Chai",
  "Caffely Wall Street Beans",
];

class _SearchShopScreenState extends State<RecentSearchShopScreen> {
  final searchController = TextEditingController();
  List<String> filteredSearchList = searchList; // Initialize with the full list

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {
        filteredSearchList = searchList.where((shop) => shop.toLowerCase().contains(searchController.text.toLowerCase())).toList();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.brown, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        searchController.clear();
                        setState(() {
                          filteredSearchList = searchList;
                        });
                      },
                    ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          searchController.text.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recent Searches",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                filteredSearchList = [];
                              });
                            },
                            child: const Text(
                              "X",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredSearchList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final search = filteredSearchList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  search,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Icon(Icons.close, color: Colors.grey),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              : const ShopListComponent(horizontalPadding: 16)
        ],
      ),
    );
  }
}
