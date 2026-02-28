import '../utils/image.dart';

class RecomendedModel {
  String imagePath;
  String title;
  String duration;
  String exercises;
  bool isFavorite;

  RecomendedModel({
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.exercises,
    this.isFavorite = false,
  });
}

List<RecomendedModel> getRecommendList() {
  List<RecomendedModel> workouts = [];

  workouts.add(RecomendedModel(
    imagePath: resourceImage1,
    title: "Loop Band Exercises",
    duration: "45 Min",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  workouts.add(RecomendedModel(
    imagePath: resourceImage2,
    title: "Workouts For Beginners",
    duration: "45 Min",
    exercises: "5 Exercises",
    isFavorite: false,
  ));

  workouts.add(RecomendedModel(
    imagePath: resourceImage3,
    title: "Full Body Stretch",
    duration: "45 Min",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  workouts.add(RecomendedModel(
    imagePath: resourceImage4,
    title: "Low Impact Workouts",
    duration: "45 Min",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  workouts.add(RecomendedModel(
    imagePath: resourceImage5,
    title: "Strength Training",
    duration: "45 Min",
    exercises: "5 Exercises",
    isFavorite: false,
  ));

  workouts.add(RecomendedModel(
    imagePath: resourceImage6,
    title: "Split Squats Vs Lunges",
    duration: "45 Min",
    exercises: "5 Exercises",
    isFavorite: false,
  ));
  workouts.add(RecomendedModel(
    imagePath: resourceImage1,
    title: "Loop Band Exercises",
    duration: "45 Min",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  workouts.add(RecomendedModel(
    imagePath: resourceImage2,
    title: "Workouts For Beginners",
    duration: "45 Min",
    exercises: "5 Exercises",
    isFavorite: false,
  ));

  return workouts;
}
