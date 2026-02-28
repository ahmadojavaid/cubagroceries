// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../utils/images.dart';

part 'hotelSearch_store.g.dart';

// MobX store instance
class HotelStoree = _HotelStore with _$HotelStore;

// Hotel model
class Hotel {
  final String id;
  final String name;
  final String location;
  final String address;
  final double rating;
  final int reviews;
  final int price;
  final String imageUrl;

  Hotel(
    this.id,
    this.name,
    this.location,
    this.address,
    this.rating,
    this.reviews,
    this.price,
    this.imageUrl,
  );
}

// Sorting options enum
enum SortOption { popularity, priceHigh, priceLow }

/// Main MobX store
abstract class _HotelStore with Store {
  // Observable search query
  @observable
  String searchQuery = '';
  @observable
  ObservableList<String> recentSearches = ObservableList.of([]);
  @observable
  ObservableList<String> selectedCountries = ObservableList.of([]);
  @observable
  ObservableList<String> selectedFacilities = ObservableList.of([]);
  @observable
  ObservableList<String> selectedAccommodationTypes = ObservableList.of([]);
  @observable
  SortOption sortOption = SortOption.popularity;
  @observable
  int minPrice = 0;
  @observable
  int maxPrice = 100;
  @observable
  int selectedRating = 0;
  @observable
  ObservableList<Hotel> allHotels = ObservableList.of([]);
  @computed
  List<Hotel> get filteredHotels {
    var list = allHotels.where((hotel) {
      final matchesSearch = searchQuery.isEmpty || hotel.name.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesCountry = selectedCountries.isEmpty ||
          selectedCountries.any(
            (c) => hotel.location.toLowerCase().contains(c.toLowerCase()),
          );
      final matchesFacilities = true; 
      final matchesType = true; 

      final matchesRating = selectedRating == 0 || hotel.rating >= selectedRating;
      final matchesPrice = hotel.price >= minPrice && hotel.price <= maxPrice;

      return matchesSearch && matchesCountry && matchesFacilities && matchesType && matchesRating && matchesPrice;
    }).toList();

    // Apply sorting
    switch (sortOption) {
      case SortOption.priceHigh:
        list.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.priceLow:
        list.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.popularity:
        list.sort((a, b) => b.reviews.compareTo(a.reviews));
        break;
    }

    return list;
  }

  @action
  void setSearchQuery(String value) {
    searchQuery = value;
    if (value.isNotEmpty) {
      if (!recentSearches.contains(value)) {
        recentSearches.insert(0, value);
        if (recentSearches.length > 1) {
          recentSearches.removeLast();
        }
      }
    }
  }

  @action
  void setFilter({
    List<String>? countries,
    List<String>? facilities,
    List<String>? types,
    int? rating,
    int? min,
    int? max,
    SortOption? sort,
  }) {
    if (countries != null) selectedCountries = ObservableList.of(countries);
    if (facilities != null) selectedFacilities = ObservableList.of(facilities);
    if (types != null) selectedAccommodationTypes = ObservableList.of(types);
    if (rating != null) selectedRating = rating;
    if (min != null) minPrice = min;
    if (max != null) maxPrice = max;
    if (sort != null) sortOption = sort;
  }

  @action
  void resetFilter() {
    selectedCountries.clear();
    selectedFacilities.clear();
    selectedAccommodationTypes.clear();
    sortOption = SortOption.popularity;
    minPrice = 0;
    maxPrice = 100;
    selectedRating = 0;
  }

  @action
  void loadHotels() {
    allHotels = ObservableList.of([
      Hotel(
        '1',
        'Le Bristol Hotel',
        'Istanbul, Turkiye',
        'No:112, Sisli, Istanbul',
        4.8,
        4981,
        27,
        roomimage1,
      ),
      Hotel(
        '2',
        'Maison Souquet',
        'Paris, France',
        '10 Rue de Bruxelles, 75009 Paris',
        4.8,
        4378,
        35,
        roomimage1,
      ),
      Hotel(
        '3',
        'Le Meurice Hotel',
        'London, United Kingdom',
        '100 Piccadilly, London W1J 7NQ',
        4.6,
        3672,
        32,
        roomimage1,
      ),
      Hotel(
        '4',
        'Hotel Splendido',
        'Portofino, Italy',
        'Via Roma, 2, 16034 Portofino',
        4.9,
        5203,
        45,
        roomimage2,
      ),
      Hotel(
        '5',
        'Burj Al Arab',
        'Dubai, UAE',
        'Jumeirah St - Dubai',
        4.7,
        6842,
        85,
        roomimage2,
      ),
      Hotel(
        '6',
        'The Peninsula',
        'Bangkok, Thailand',
        '333 Charoennakorn Rd, Khlong San',
        4.5,
        3990,
        38,
        roomimage2,
      ),
      Hotel(
        '7',
        'Mandarin Oriental',
        'New York, USA',
        '80 Columbus Cir, New York, NY',
        4.8,
        6102,
        72,
        roomimage3,
      ),
      Hotel(
        '8',
        'The Ritz',
        'Paris, France',
        '15 Place Vendôme, 75001 Paris',
        4.9,
        5280,
        90,
        roomimage3,
      ),
      Hotel(
        '9',
        'Park Hyatt',
        'Tokyo, Japan',
        '3-7-1-2 Nishi Shinjuku, Shinjuku-ku',
        4.6,
        4780,
        60,
        roomimage3,
      ),
      Hotel(
        '10',
        'Hotel de Crillon',
        'Paris, France',
        '10 Place de la Concorde, 75008 Paris',
        4.8,
        5030,
        82,
        roomimage1,
      ),
      Hotel(
        '11',
        'The Oberoi',
        'Mumbai, India',
        'Nariman Point, Mumbai',
        4.7,
        3900,
        40,
        roomimage1,
      ),
      Hotel(
        '12',
        'Aman Tokyo',
        'Tokyo, Japan',
        '1-5-6 Otemachi, Chiyoda-ku',
        4.9,
        4105,
        95,
        roomimage1,
      ),
      Hotel(
        '13',
        'Four Seasons',
        'Florence, Italy',
        'Borgo Pinti, 99, Florence',
        4.8,
        4400,
        70,
        roomimage1,
      ),
      Hotel(
        '14',
        'Belmond Copacabana',
        'Rio, Brazil',
        'Av. Atlântica, 1702, Rio de Janeiro',
        4.6,
        3200,
        55,
        roomimage2,
      ),
      Hotel(
        '15',
        'Taj Lake Palace',
        'Udaipur, India',
        'Pichola Lake, Udaipur',
        4.9,
        3450,
        50,
        roomimage2,
      ),
      Hotel(
        '16',
        'Shangri-La Hotel',
        'Singapore',
        '22 Orange Grove Rd, Singapore',
        4.7,
        5800,
        88,
        roomimage2,
      ),
      Hotel(
        '17',
        'The Langham',
        'Melbourne, Australia',
        '1 Southgate Ave, Southbank VIC',
        4.5,
        3100,
        48,
        roomimage3,
      ),
      Hotel(
        '18',
        'Raffles Hotel',
        'Singapore',
        '1 Beach Rd, Singapore',
        4.9,
        5650,
        100,
        roomimage3,
      ),
      Hotel(
        '19',
        'Hotel Sacher',
        'Vienna, Austria',
        'Philharmonikerstrasse 4, Vienna',
        4.8,
        4700,
        77,
        roomimage3,
      ),
      Hotel(
        '20',
        'Rosewood',
        'Hong Kong',
        '18 Salisbury Rd, Tsim Sha Tsui',
        4.8,
        5100,
        89,
        roomimage1,
      ),
    ]);
  }

  @action
  void removeRecentSearch(String query) {
    recentSearches.removeWhere((item) => item == query);
  }
}
