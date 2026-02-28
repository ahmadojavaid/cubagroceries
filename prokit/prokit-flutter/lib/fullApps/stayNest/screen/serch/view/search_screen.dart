import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../components/app_custom_choice_chip.dart';
import '../../../store/hotelSearch_store.dart';
import '../../../utils/colors.dart';
import '../../home/component/booked_card_component.dart';
import 'filter_bottom_sheet.dart';

class HotelSearchScreen extends StatefulWidget {
  const HotelSearchScreen({Key? key}) : super(key: key);

  @override
  State<HotelSearchScreen> createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen> with TickerProviderStateMixin {
  final HotelStoree Hotelstoree = HotelStoree();
  final TextEditingController searchController = TextEditingController();

  final List<String> categories = [
    'All Hotel',
    'Recommended',
    'Popular',
    'Budget',
    'Luxury',
  ];
  String selectedCategory = 'All Hotel';

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
          statusBarBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
        ),
      );
    });
    Hotelstoree.loadHotels();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      ),
    );

    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? black : white,
      body: SafeArea(
        child: Observer(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.height,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: Hotelstoree.setSearchQuery,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        filled: true,
                        prefixIcon: Icon(Icons.search, color: stayNestPrimaryColor),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: appStore.isDarkModeOn ? const Color.fromARGB(255, 54, 54, 55) : const Color.fromARGB(255, 214, 213, 213)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: stayNestPrimaryColor),
                        ),
                      ),
                    ),
                  ),
                  12.width,
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: appStore.isDarkModeOn ? const Color.fromARGB(255, 36, 36, 36) : stayNestPrimaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                      onPressed: () => showFilterBottomSheet(context),
                    ),
                  ),
                ],
              ).paddingAll(16),
              CategoryChips(
                categories: categories,
                selectedCategory: selectedCategory,
                isDarkMode: appStore.isDarkModeOn,
                onCategorySelected: (category) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Observer(
                    builder: (_) {
                      final hasQuery = Hotelstoree.searchQuery.isNotEmpty;
                      final hasResults = Hotelstoree.filteredHotels.isNotEmpty;

                      if (hasQuery && hasResults) {
                        return ListView.builder(
                          itemCount: Hotelstoree.filteredHotels.length,
                          itemBuilder: (context, index) {
                            final hotel = Hotelstoree.filteredHotels[index];
                            return HotelCard(
                              id: index,
                              name: hotel.name,
                              address: hotel.address,
                              pricePerNight: 20,
                              rating: hotel.rating,
                              image: hotel.imageUrl,
                              onTap: () {},
                            );
                          },
                        );
                      } else if (hasQuery && !hasResults) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                "Recent Searches",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: Hotelstoree.recentSearches.length,
                                itemBuilder: (context, index) {
                                  final query = Hotelstoree.recentSearches[index];
                                  return ListTile(
                                    title: Text(query),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        Hotelstoree.removeRecentSearch(
                                          query,
                                        );
                                      },
                                    ),
                                    onTap: () {
                                      searchController.text = query;
                                      Hotelstoree.setSearchQuery(query);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            final hotel = Hotelstoree.filteredHotels[index];
                            return HotelCard(
                              id: index,
                              name: hotel.name,
                              address: hotel.address,
                              pricePerNight: 20,
                              rating: hotel.rating,
                              image: hotel.imageUrl,
                              onTap: () {},
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
