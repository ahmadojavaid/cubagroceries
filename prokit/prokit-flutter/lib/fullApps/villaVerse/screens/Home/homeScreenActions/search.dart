import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../component/card_select_option.dart';
import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import '../../../utils/image.dart';
import 'components/filter_location_selector.dart';
import 'components/filter_option_chips.dart';
import 'components/filter_section_title.dart';
import 'components/search_list_product.dart';
import 'components/sort_gride_selecton.dart';
import '../../../../../main.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  RangeValues currentRangeValues = const RangeValues(20, 40);
  int sortViewSelection = 1;

  final List<Map<String, dynamic>> _rating =
      List.generate(5, (i) => {"title": "${5 - i}", "icon": Icons.star});

  final List<Map<String, dynamic>> _sort = [
    {"title": "All", "icon": Icons.check_box},
    {"title": "House", "icon": Icons.home},
    {"title": "villa", "icon": Icons.maps_home_work_sharp},
    {"title": "Apartments", "icon": Icons.apartment},
  ];
  final ExpansionTileController _controllerTile = ExpansionTileController();
  final List<Map<String, dynamic>> _filterSort = [
    {"title": "All", "icon": Icons.check_box},
    {"title": "House", "icon": Icons.home},
    {"title": "villa", "icon": Icons.maps_home_work_sharp},
    {"title": "Apartments", "icon": Icons.apartment},
  ];
  final List<String> _facilites = ["All", "Car Parking", "Gym", "Restaurant"];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      body: SafeArea(
        child: Column(
          children: [
            buildSearchBar(),
            CardSelectOption(
              list: _sort,
              selectedIndex: selectedIndex,
              color: appStore.isDarkModeOn ? darkColor : lightColor,
            ),
            16.height,
            buildResultHeader(),
            20.height,
            Expanded(
              child: selectedIndex == 2
                  ? buildNoDataFound()
                  : sortViewSelection == 1
                      ? SearchListProduct(listData: recommended)
                      : SortGrideSelecton(listData: recommended),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar() {
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.arrow_back,
            color: appStore.isDarkModeOn ? lightColor : darkColor),
        onPressed: () => finish(context),
      ),
      title: AppTextField(
        textStyle: primaryTextStyle(),
        controller: searchController,
        keyboardType: TextInputType.text,
        textFieldType: TextFieldType.OTHER,
        decoration: InputDecoration(
          prefixIconColor: hintTextColor,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: GestureDetector(
            onTap: () => showFilterBottomSheet(context),
            child: const Icon(Icons.tune),
          ),
          suffixIconColor: hintTextColor,
          hintText: "Search",
          filled: true,
          fillColor:
              appStore.isDarkModeOn ? inputFillColorDart : inputFillColorlight,
          hintStyle: const TextStyle(color: hintTextColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryBlueColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    int filterSelectedIndex = 0;
    int facilitesIndex = 0;
    int ratingIndex = 0;
    String selectedLocation = "Location";
    final locationList = ["New Delhi, India", "New York, US", 'Tokyo, Japan'];

    hideKeyboard(context);

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 630,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(27)),
                color: appStore.isDarkModeOn
                    ? inputFillColorDart
                    : inputFillColorlight,
              ),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      height: 3,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: hintTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Center(
                      child: Text("Filter", style: TextStyle(fontSize: 16))),
                  const SizedBox(height: 16),
                  Divider(color: Theme.of(context).dividerColor),
                  const SizedBox(height: 16),

                  // Category
                  const FilterSectionTitle("Category"),
                  const SizedBox(height: 8),
                  CardSelectOption(
                      list: _filterSort,
                      selectedIndex: filterSelectedIndex,
                      color: appStore.isDarkModeOn
                          ? inputFillColorDart
                          : inputFillColorlight),

                  const SizedBox(height: 16),
                  const FilterSectionTitle("Price Range"),
                  const SizedBox(height: 8),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      valueIndicatorColor: hintTextColor,
                      valueIndicatorTextStyle: TextStyle(color: lightColor),
                    ),
                    child: RangeSlider(
                      values: currentRangeValues,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      activeColor: primaryBlueColor,
                      inactiveColor: hintTextColor,
                      labels: RangeLabels(
                        '\$${currentRangeValues.start.round()}',
                        '\$${currentRangeValues.end.round()}',
                      ),
                      onChanged: (values) {
                        setModalState(() {
                          currentRangeValues = values;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 16),
                  const FilterSectionTitle("Facilities"),
                  const SizedBox(height: 8),
                  FilterOptionChips(
                    options: _facilites,
                    selectedIndex: facilitesIndex,
                    onTap: (index) =>
                        setModalState(() => facilitesIndex = index),
                  ),

                  const SizedBox(height: 16),
                  const FilterSectionTitle("Location"),
                  const SizedBox(height: 8),
                  FilterLocationSelector(
                    controller: _controllerTile,
                    locations: locationList,
                    selected: selectedLocation,
                    onSelect: (loc) =>
                        setModalState(() => selectedLocation = loc),
                  ),

                  const SizedBox(height: 16),
                  const FilterSectionTitle("Rating"),
                  const SizedBox(height: 8),
                  CardSelectOption(
                    list: _rating,
                    selectedIndex: ratingIndex,
                    color: appStore.isDarkModeOn
                        ? inputFillColorDart
                        : inputFillColorlight,
                  ),

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton(
                        elevation: 0,
                        text: 'Reset',
                        color:
                            appStore.isDarkModeOn ? hintTextColor : blueLight,
                        textStyle: boldTextStyle(
                          color: appStore.isDarkModeOn
                              ? lightColor
                              : primaryBlueColor,
                        ),
                        width: context.width() / 2.5,
                        onTap: () {
                          setModalState(() {
                            filterSelectedIndex = 0;
                            facilitesIndex = 0;
                            ratingIndex = 0;
                            currentRangeValues = const RangeValues(18, 40);
                            selectedLocation = "Location";
                          });
                          finish(context);
                        },
                        shapeBorder:
                            RoundedRectangleBorder(borderRadius: radius(20)),
                      ),
                      AppButton(
                        elevation: 0,
                        text: 'Apply',
                        color: primaryBlueColor,
                        textStyle: boldTextStyle(color: lightColor),
                        width: context.width() / 2.5,
                        onTap: () => finish(context),
                        shapeBorder:
                            RoundedRectangleBorder(borderRadius: radius(20)),
                      ),
                    ],
                  ).paddingOnly(bottom: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildResultHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            selectedIndex == 2 ? "0 founds" : "755 founds",
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.list_alt,
                size: 27,
                color:
                    sortViewSelection == 1 ? primaryBlueColor : hintTextColor),
            onPressed: () => setState(() => sortViewSelection = 1),
          ),
          IconButton(
            icon: Icon(Icons.dashboard,
                size: 27,
                color:
                    sortViewSelection == 2 ? primaryBlueColor : hintTextColor),
            onPressed: () => setState(() => sortViewSelection = 2),
          ),
        ],
      ),
    );
  }

  Widget buildNoDataFound() {
    return Center(
      child: ListView(
        children: [
          70.height,
          Image.network(noDataFound,
              height: context.height() * .3, width: context.height() * .3),
          16.height,
          Text('Not found', style: TextStyle(fontSize: 16)),
          16.height,
          Text(
            'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ).paddingSymmetric(horizontal: 16),
        ],
      ),
    );
  }

  Widget lableText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(text),
    );
  }
}
