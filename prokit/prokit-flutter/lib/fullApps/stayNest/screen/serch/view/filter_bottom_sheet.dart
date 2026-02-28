import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../../main.dart';
import '../../../utils/colors.dart';

void showFilterBottomSheet(BuildContext context) {
  // Temporary local state for demo purposes
  Set<String> selectedCountries = {};
  SortOption? selectedSort;
  double minPrice = 10;
  double maxPrice = 80;
  int selectedRating = 0;
  Set<String> selectedFacilities = {};
  Set<String> selectedAccommodationTypes = {};

  List<String> countries = ["USA", "France", "Japan", "India"];
  List<String> facilities = ["WiFi", "Swimming Pool", "Parking", "Restaurant"];
  List<String> accommodationTypes = [
    "Hotels",
    "Resorts",
    "Villas",
    "Apartments",
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => StatefulBuilder(
      builder: (context, setState) => FractionallySizedBox(
        heightFactor: 0.8,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300] ?? black,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  "Filter Hotel",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                8.height,
                Divider(height: 1, thickness: 1),
                16.height,
                _sectionTitle("Country"),
                Wrap(
                  spacing: 8,
                  children: countries.map((country) {
                    final selected = selectedCountries.contains(
                      country,
                    );
                    return FilterChip(
                      side: BorderSide(color: appStore.isDarkModeOn ? const Color.fromARGB(255, 54, 54, 55) : white),
                      showCheckmark: false,
                      label: Text(country),
                      selected: selected,
                      selectedColor: stayNestPrimaryColor,
                      onSelected: (_) {
                        setState(() {
                          selected ? selectedCountries.remove(country) : selectedCountries.add(country);
                        });
                      },
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : stayNestPrimaryColor,
                      ),
                      // ignore: deprecated_member_use
                      backgroundColor: stayNestPrimaryColor.withOpacity(
                        0.1,
                      ),
                    );
                  }).toList(),
                ),
                20.height,
                _sectionTitle("Sort Results"),
                Wrap(
                  spacing: 8,
                  children: SortOption.values.map((option) {
                    final selected = selectedSort == option;
                    final text = option.toString().split('.').last;
                    return FilterChip(
                      side: BorderSide(color: appStore.isDarkModeOn ? const Color.fromARGB(255, 54, 54, 55) : white),
                      showCheckmark: false,
                      label: Text(text),
                      selected: selected,
                      selectedColor: stayNestPrimaryColor,
                      onSelected: (_) {
                        setState(() {
                          selectedSort = option;
                        });
                      },
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : stayNestPrimaryColor,
                      ),
                      backgroundColor: stayNestPrimaryColor.withOpacity(
                        0.1,
                      ),
                    );
                  }).toList(),
                ),
                20.height,
                _sectionTitle("Price Range Per Night"),
                RangeSlider(
                  values: RangeValues(minPrice, maxPrice),
                  min: 0,
                  max: 100,
                  divisions: 10,
                  labels: RangeLabels('\$$minPrice', '\$$maxPrice'),
                  activeColor: stayNestPrimaryColor,
                  onChanged: (range) {
                    setState(() {
                      minPrice = range.start;
                      maxPrice = range.end;
                    });
                  },
                ),
                20.height,
                _sectionTitle("Star Rating"),
                Wrap(
                  spacing: 8,
                  children: List.generate(5, (index) {
                    final rating = 5 - index;
                    final isSelected = selectedRating == rating;
                    return ChoiceChip(
                      side: BorderSide(color: appStore.isDarkModeOn ? const Color.fromARGB(255, 54, 54, 55) : white),
                      showCheckmark: false,
                      selected: isSelected,
                      selectedColor: stayNestPrimaryColor,
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$rating',
                            style: TextStyle(
                              color: isSelected ? Colors.white : stayNestPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      onSelected: (_) {
                        setState(() => selectedRating = rating);
                      },
                      backgroundColor: isSelected ? stayNestPrimaryColor : stayNestPrimaryColor.withOpacity(0.1),
                    );
                  }),
                ),
                20.height,
                _sectionTitle("Facilities"),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: facilities.map((facility) {
                    final selected = selectedFacilities.contains(
                      facility,
                    );
                    return FilterChip(
                      side: BorderSide(color: appStore.isDarkModeOn ? const Color.fromARGB(255, 54, 54, 55) : white),
                      showCheckmark: false,
                      label: Text(facility),
                      selected: selected,
                      selectedColor: stayNestPrimaryColor,
                      onSelected: (_) {
                        setState(() {
                          selected ? selectedFacilities.remove(facility) : selectedFacilities.add(facility);
                        });
                      },
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : stayNestPrimaryColor,
                      ),
                      backgroundColor: stayNestPrimaryColor.withOpacity(
                        0.1,
                      ),
                    );
                  }).toList(),
                ),
                20.height,
                _sectionTitle("Accommodation Type"),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: accommodationTypes.map((type) {
                    final selected = selectedAccommodationTypes.contains(type);
                    return FilterChip(
                      side: BorderSide(color: appStore.isDarkModeOn ? const Color.fromARGB(255, 54, 54, 55) : white),
                      showCheckmark: false,
                      label: Text(type),
                      selected: selected,
                      selectedColor: stayNestPrimaryColor,
                      onSelected: (_) {
                        setState(() {
                          selected
                              ? selectedAccommodationTypes.remove(
                                  type,
                                )
                              : selectedAccommodationTypes.add(
                                  type,
                                );
                        });
                      },
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : stayNestPrimaryColor,
                      ),
                      backgroundColor: stayNestPrimaryColor.withOpacity(
                        0.1,
                      ),
                    );
                  }).toList(),
                ),
                30.height,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedCountries.clear();
                            selectedSort = null;
                            minPrice = 0;
                            maxPrice = 100;
                            selectedRating = 0;
                            selectedFacilities.clear();
                            selectedAccommodationTypes.clear();
                          });
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: stayNestPrimaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Reset",
                          style: TextStyle(color: stayNestPrimaryColor),
                        ),
                      ),
                    ),
                    16.width,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          hideKeyboard(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: stayNestPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Apply Filter",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                30.height,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _sectionTitle(String title, {VoidCallback? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        if (onTap != null)
          GestureDetector(
            onTap: onTap,
            child: const Text("See All", style: TextStyle(color: stayNestPrimaryColor)),
          ),
      ],
    ),
  );
}

enum SortOption { popularity, priceLowToHigh, priceHighToLow, rating }
