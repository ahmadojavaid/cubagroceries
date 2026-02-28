import '../utils/image.dart';

class RatingModel {
  final String name;
  final String imageUrl;
  final double rating;
  final String comment;
  final int likes;
  final DateTime time;
  final bool isLiked;

  RatingModel({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.comment,
    required this.likes,
    required this.time,
    required this.isLiked,
  });
}

List<RatingModel> getRatingList() {
  return [
    RatingModel(
      name: "Alice Johnson",
      imageUrl: friend1,
      rating: 4.8,
      comment: "Absolutely loved it!",
      likes: 12,
      time: DateTime.now().subtract(Duration(hours: 1)),
      isLiked: true,
    ),
    RatingModel(
      name: "Michael Smith",
      imageUrl: friend2,
      rating: 4.2,
      comment: "Nice place and clean.",
      likes: 8,
      time: DateTime.now().subtract(Duration(days: 1)),
      isLiked: true,
    ),
    RatingModel(
      name: "Jessica Lee",
      imageUrl: friend3,
      rating: 3.5,
      comment: "It was okay, could be better.",
      likes: 5,
      time: DateTime.now().subtract(Duration(days: 2)),
      isLiked: false,
    ),
    RatingModel(
      name: "David Kim",
      imageUrl: friend4,
      rating: 4.9,
      comment: "Excellent service!",
      likes: 15,
      time: DateTime.now().subtract(Duration(minutes: 30)),
      isLiked: false,
    ),
    RatingModel(
      name: "Emma Watson",
      imageUrl: friend5,
      rating: 5.0,
      comment: "Perfect stay! Highly recommend.",
      likes: 25,
      time: DateTime.now().subtract(Duration(hours: 4)),
      isLiked: true,
    ),
    RatingModel(
      name: "John Wick",
      imageUrl: friend3,
      rating: 3.8,
      comment: "Good overall.",
      likes: 10,
      time: DateTime.now().subtract(Duration(days: 3)),
      isLiked: true,
    ),
    RatingModel(
      name: "Olivia Brown",
      imageUrl: friend2,
      rating: 4.6,
      comment: "Very comfortable and well located.",
      likes: 13,
      time: DateTime.now().subtract(Duration(days: 4)),
      isLiked: false,
    ),
    RatingModel(
      name: "Chris Evans",
      imageUrl: friend1,
      rating: 2.9,
      comment: "Not worth the price.",
      likes: 3,
      time: DateTime.now().subtract(Duration(hours: 5)),
      isLiked: true,
    ),
    RatingModel(
      name: "Sophia Turner",
      imageUrl: friend2,
      rating: 4.3,
      comment: "Lovely decor and vibe.",
      likes: 9,
      time: DateTime.now().subtract(Duration(days: 6)),
      isLiked: true,
    ),
    RatingModel(
      name: "Daniel Craig",
      imageUrl: friend3,
      rating: 3.0,
      comment: "Too noisy at night.",
      likes: 4,
      time: DateTime.now().subtract(Duration(days: 7)),
      isLiked: false,
    ),
    RatingModel(
      name: "Lily Collins",
      imageUrl: friend4,
      rating: 4.7,
      comment: "Very cozy and peaceful.",
      likes: 11,
      time: DateTime.now().subtract(Duration(hours: 8)),
      isLiked: true,
    ),
    RatingModel(
      name: "Tom Holland",
      imageUrl: friend5,
      rating: 4.4,
      comment: "Everything went smoothly.",
      likes: 7,
      time: DateTime.now().subtract(Duration(days: 8)),
      isLiked: true,
    ),
    RatingModel(
      name: "Natalie Portman",
      imageUrl: friend3,
      rating: 4.1,
      comment: "Great host and amenities.",
      likes: 6,
      time: DateTime.now().subtract(Duration(days: 9)),
      isLiked: false,
    ),
    RatingModel(
      name: "Robert Downey Jr.",
      imageUrl: friend5,
      rating: 3.6,
      comment: "It was average but okay for a night.",
      likes: 2,
      time: DateTime.now().subtract(Duration(days: 10)),
      isLiked: true,
    ),
    RatingModel(
      name: "Zendaya",
      imageUrl: friend1,
      rating: 5.0,
      comment: "Luxury experience!",
      likes: 30,
      time: DateTime.now().subtract(Duration(hours: 10)),
      isLiked: true,
    ),
  ];
}
