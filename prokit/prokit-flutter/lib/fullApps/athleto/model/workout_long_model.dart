import '../utils/image.dart';

class WorkoutCardModel {
  String imagePath;
  String title;
  String duration;
  String calories;
  String exercises;
  bool isFavorite;
  bool isTrainingOfTheDay;

  WorkoutCardModel({
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.calories,
    required this.exercises,
    this.isFavorite = false,
    this.isTrainingOfTheDay = false,
  });
}

List<WorkoutCardModel> getWorkoutCardList() {
  List<WorkoutCardModel> workouts = [];

  // Training of the day
  workouts.add(WorkoutCardModel(
    imagePath: workoutImage3,
    title: "Functional Training",
    duration: "45 Minutes",
    calories: "1450 ",
    exercises: "5 Exercises",
    isFavorite: false,
    isTrainingOfTheDay: true,
  ));

  workouts.add(WorkoutCardModel(
    imagePath: resourceImage3,
    title: "Upper Body",
    duration: "60 Minutes",
    calories: "1320 ",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  workouts.add(WorkoutCardModel(
    imagePath: workoutImage1,
    title: "Full Body Stretching",
    duration: "45 Minutes",
    calories: "1450 ",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  // workouts.add(WorkoutCardModel(
  //   imagePath: "assets/images/r3.png",
  //   title: "Glutes & Abs",
  //   duration: "50 Minutes",
  //   calories: "1400 Kcal",
  //   exercises: "5 Exercises",
  //   isFavorite: true,
  // ));

  return workouts;
}

List<WorkoutCardModel> getIntermediateWorkouts() {
  List<WorkoutCardModel> intermediateWorkouts = [];

  // Training of the day
  intermediateWorkouts.add(WorkoutCardModel(
    imagePath: intermediateImage1,
    title: "Cardio Fitness",
    duration: "45 Minutes",
    calories: "120 ",
    exercises: "5 Exercises",
    isFavorite: false,
    isTrainingOfTheDay: true,
  ));

  intermediateWorkouts.add(WorkoutCardModel(
    imagePath: intermediateImage2,
    title: "Circuit Training",
    duration: "50 Minutes",
    calories: "1300 ",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  intermediateWorkouts.add(WorkoutCardModel(
    imagePath: intermediateImage3,
    title: "Split Strength Training",
    duration: "12 Minutes",
    calories: "1250 ",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  return intermediateWorkouts;
}

List<WorkoutCardModel> getAdvancedWorkouts() {
  List<WorkoutCardModel> advancedWorkouts = [];

  // Training of the day
  advancedWorkouts.add(WorkoutCardModel(
    imagePath: advanceImage1,
    title: "Upper Body Strength",
    duration: "60 Minutes",
    calories: "120 ",
    exercises: "5 Exercises",
    isFavorite: false,
    isTrainingOfTheDay: true,
  ));

  advancedWorkouts.add(WorkoutCardModel(
    imagePath: advanceImage2,
    title: "Cardio Boxing",
    duration: "50 Minutes",
    calories: "1300 ",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  advancedWorkouts.add(WorkoutCardModel(
    imagePath: advanceImage3,
    title: "Hypertrophy - Legs",
    duration: "12 Minutes",
    calories: "1250 ",
    exercises: "5 Exercises",
    isFavorite: true,
  ));

  return advancedWorkouts;
}
