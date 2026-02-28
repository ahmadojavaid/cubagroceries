

import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';

class MainPageView {
  String movieImage;
  String movieName;
  String movieDuration;
  String language;
  String releaseYear;
  double rating;
  List<String> movieTypes;

  MainPageView({
    required this.movieImage,
    required this.movieName,
    required this.movieDuration,
    required this.language,
    required this.releaseYear,
    required this.rating,
    required this.movieTypes,
  });
}

class Personality {
  final String name;
  final String image;

  Personality({required this.name, required this.image});
}

class ContinueWatchingModel {
  final String imagePath;
  final String title;
  final String duration;

  ContinueWatchingModel({
    required this.imagePath,
    required this.title,
    required this.duration,
  });
}

class TopMovies {
  final String images;
  TopMovies({required this.images});
}

List<TopMovies> topMovies = [
  TopMovies(images: streamITAppImages.topMovie1),
  TopMovies(images: streamITAppImages.topMovie2),
  TopMovies(images: streamITAppImages.topMovie3),
  TopMovies(images: streamITAppImages.topMovie4),
  TopMovies(images: streamITAppImages.topMovie5),
  TopMovies(images: streamITAppImages.topMovie6),
  TopMovies(images: streamITAppImages.topMovie7),
  TopMovies(images: streamITAppImages.topMovie8),
  TopMovies(images: streamITAppImages.topMovie9),
  TopMovies(images: streamITAppImages.topMovie10),
];

List<TopMovies> latestMovies = [
  TopMovies(images: streamITAppImages.latest1),
  TopMovies(images: streamITAppImages.latest2),
  TopMovies(images: streamITAppImages.latest3),
  TopMovies(images: streamITAppImages.latest4),
  TopMovies(images: streamITAppImages.latest5),
  TopMovies(images: streamITAppImages.latest6),
  TopMovies(images: streamITAppImages.latest7),
  TopMovies(images: streamITAppImages.latest8),
];

List<TopMovies> popularMovies = [
  TopMovies(images: streamITAppImages.popular1),
  TopMovies(images: streamITAppImages.popular2),
  TopMovies(images: streamITAppImages.popular3),
  TopMovies(images: streamITAppImages.popular4),
  TopMovies(images: streamITAppImages.popular5),
  TopMovies(images: streamITAppImages.popular6),
  TopMovies(images: streamITAppImages.popular7),
  TopMovies(images: streamITAppImages.popular8),
  TopMovies(images: streamITAppImages.popular9),
];
List<TopMovies> popularVideos = [
  TopMovies(images: streamITAppImages.popularV1),
  TopMovies(images: streamITAppImages.popularV2),
  TopMovies(images: streamITAppImages.popularV3),
  TopMovies(images: streamITAppImages.popularV4),
  TopMovies(images: streamITAppImages.popularV5),
  TopMovies(images: streamITAppImages.popularV6),
  TopMovies(images: streamITAppImages.popularV7),
  TopMovies(images: streamITAppImages.popularV8),

];

List<MainPageView> dummyMovies = [
  MainPageView(
    movieImage: streamITAppImages.movie1,
    movieName: 'Unbeatable Superhero',
    movieDuration: '2h 32m',
    language: 'English',
    releaseYear: '2024',
    rating: 4.3,
    movieTypes: ["Action", "Comedy"],
  ),
  MainPageView(
    movieImage: streamITAppImages.movie2,
    movieName: 'Superhero',
    movieDuration: '2h 32m',
    language: 'English',
    releaseYear: '2024',
    rating: 4.3,
    movieTypes: ["Action", "Comedy"],
  ),
  MainPageView(
    movieImage: streamITAppImages.movie3,
    movieName: 'Loerm',
    movieDuration: '2h 32m',
    language: 'English',
    releaseYear: '2024',
    rating: 4.3,
    movieTypes: ["Action", "Comedy"],
  ),
  MainPageView(
    movieImage: streamITAppImages.movie4,
    movieName: 'Realm of Enchantment',
    movieDuration: '2h 32m',
    language: 'English',
    releaseYear: '2024',
    rating: 4.3,
    movieTypes: ["Action", "Comedy"],
  ),
];

final List<ContinueWatchingModel> continueWatchingList = [
  ContinueWatchingModel(
    imagePath: streamITAppImages.movie1,
    title: 'An Epic journey begins',
    duration: '2 hour 40 min',
  ),
  ContinueWatchingModel(
    imagePath: streamITAppImages.movie2,
    title: 'The Final Battle',
    duration: '1 hour 55 min',
  ),
  ContinueWatchingModel(
    imagePath: streamITAppImages.movie3,
    title: 'Secrets Unveiled',
    duration: '2 hour 10 min',
  ),
];

final List<Personality> personalities = [
  Personality(name: 'John', image: streamITAppImages.jhone),
  Personality(name: 'Lorina', image: streamITAppImages.lorina),
  Personality(name: 'Smith', image: streamITAppImages.smith),
  Personality(name: 'Leena', image: streamITAppImages.leena),
  Personality(name: 'Jcob', image: streamITAppImages.kai),
];

final List<Personality> tvCategories = [
  Personality(name: 'Comedy', image: streamITAppImages.comedy),
  Personality(name: 'Reality', image: streamITAppImages.reality),
  Personality(name: 'Drama', image: streamITAppImages.drama),
  Personality(name: 'Thriller', image: streamITAppImages.thriller),
  Personality(name: 'Romance', image: streamITAppImages.romance),
];

List<Personality> movieGenres = [
  Personality(name: "Adventure", image: streamITAppImages.adventure),
  Personality(name: "Romance", image: streamITAppImages.romance),
  Personality(name: "Action", image: streamITAppImages.action),
  Personality(name: "Animation", image: streamITAppImages.animation),
];
