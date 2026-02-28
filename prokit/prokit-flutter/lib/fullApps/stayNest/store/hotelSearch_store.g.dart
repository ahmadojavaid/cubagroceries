// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotelSearch_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HotelStore on _HotelStore, Store {
  late final _$searchQueryAtom =
      Atom(name: '_HotelStore.searchQuery', context: context);

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$recentSearchesAtom =
      Atom(name: '_HotelStore.recentSearches', context: context);

  @override
  ObservableList<String> get recentSearches {
    _$recentSearchesAtom.reportRead();
    return super.recentSearches;
  }

  @override
  set recentSearches(ObservableList<String> value) {
    _$recentSearchesAtom.reportWrite(value, super.recentSearches, () {
      super.recentSearches = value;
    });
  }

  late final _$selectedCountriesAtom =
      Atom(name: '_HotelStore.selectedCountries', context: context);

  @override
  ObservableList<String> get selectedCountries {
    _$selectedCountriesAtom.reportRead();
    return super.selectedCountries;
  }

  @override
  set selectedCountries(ObservableList<String> value) {
    _$selectedCountriesAtom.reportWrite(value, super.selectedCountries, () {
      super.selectedCountries = value;
    });
  }

  late final _$selectedFacilitiesAtom =
      Atom(name: '_HotelStore.selectedFacilities', context: context);

  @override
  ObservableList<String> get selectedFacilities {
    _$selectedFacilitiesAtom.reportRead();
    return super.selectedFacilities;
  }

  @override
  set selectedFacilities(ObservableList<String> value) {
    _$selectedFacilitiesAtom.reportWrite(value, super.selectedFacilities, () {
      super.selectedFacilities = value;
    });
  }

  late final _$selectedAccommodationTypesAtom =
      Atom(name: '_HotelStore.selectedAccommodationTypes', context: context);

  @override
  ObservableList<String> get selectedAccommodationTypes {
    _$selectedAccommodationTypesAtom.reportRead();
    return super.selectedAccommodationTypes;
  }

  @override
  set selectedAccommodationTypes(ObservableList<String> value) {
    _$selectedAccommodationTypesAtom
        .reportWrite(value, super.selectedAccommodationTypes, () {
      super.selectedAccommodationTypes = value;
    });
  }

  late final _$sortOptionAtom =
      Atom(name: '_HotelStore.sortOption', context: context);

  @override
  SortOption get sortOption {
    _$sortOptionAtom.reportRead();
    return super.sortOption;
  }

  @override
  set sortOption(SortOption value) {
    _$sortOptionAtom.reportWrite(value, super.sortOption, () {
      super.sortOption = value;
    });
  }

  late final _$minPriceAtom =
      Atom(name: '_HotelStore.minPrice', context: context);

  @override
  int get minPrice {
    _$minPriceAtom.reportRead();
    return super.minPrice;
  }

  @override
  set minPrice(int value) {
    _$minPriceAtom.reportWrite(value, super.minPrice, () {
      super.minPrice = value;
    });
  }

  late final _$maxPriceAtom =
      Atom(name: '_HotelStore.maxPrice', context: context);

  @override
  int get maxPrice {
    _$maxPriceAtom.reportRead();
    return super.maxPrice;
  }

  @override
  set maxPrice(int value) {
    _$maxPriceAtom.reportWrite(value, super.maxPrice, () {
      super.maxPrice = value;
    });
  }

  late final _$selectedRatingAtom =
      Atom(name: '_HotelStore.selectedRating', context: context);

  @override
  int get selectedRating {
    _$selectedRatingAtom.reportRead();
    return super.selectedRating;
  }

  @override
  set selectedRating(int value) {
    _$selectedRatingAtom.reportWrite(value, super.selectedRating, () {
      super.selectedRating = value;
    });
  }

  late final _$allHotelsAtom =
      Atom(name: '_HotelStore.allHotels', context: context);

  @override
  ObservableList<Hotel> get allHotels {
    _$allHotelsAtom.reportRead();
    return super.allHotels;
  }

  @override
  set allHotels(ObservableList<Hotel> value) {
    _$allHotelsAtom.reportWrite(value, super.allHotels, () {
      super.allHotels = value;
    });
  }

  late final _$_HotelStoreActionController =
      ActionController(name: '_HotelStore', context: context);

  @override
  void setSearchQuery(String value) {
    final _$actionInfo = _$_HotelStoreActionController.startAction(
        name: '_HotelStore.setSearchQuery');
    try {
      return super.setSearchQuery(value);
    } finally {
      _$_HotelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(
      {List<String>? countries,
      List<String>? facilities,
      List<String>? types,
      int? rating,
      int? min,
      int? max,
      SortOption? sort}) {
    final _$actionInfo = _$_HotelStoreActionController.startAction(
        name: '_HotelStore.setFilter');
    try {
      return super.setFilter(
          countries: countries,
          facilities: facilities,
          types: types,
          rating: rating,
          min: min,
          max: max,
          sort: sort);
    } finally {
      _$_HotelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFilter() {
    final _$actionInfo = _$_HotelStoreActionController.startAction(
        name: '_HotelStore.resetFilter');
    try {
      return super.resetFilter();
    } finally {
      _$_HotelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchQuery: ${searchQuery},
recentSearches: ${recentSearches},
selectedCountries: ${selectedCountries},
selectedFacilities: ${selectedFacilities},
selectedAccommodationTypes: ${selectedAccommodationTypes},
sortOption: ${sortOption},
minPrice: ${minPrice},
maxPrice: ${maxPrice},
selectedRating: ${selectedRating},
allHotels: ${allHotels}
    ''';
  }
}