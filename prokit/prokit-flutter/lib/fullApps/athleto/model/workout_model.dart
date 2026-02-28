import '../utils/image.dart';

class Workout {
  String imagePath;
  String title;
  String description;

  Workout({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

List<Workout> getWorkoutList() {
  List<Workout> workouts = [];

  workouts.add(Workout(
    imagePath: challengeImage1,
    title: "Cycling Challenge",
    description: "Push your limits with an intense cycling workout designed to boost endurance and burn calories fast",
  ));

  workouts.add(Workout(
    imagePath: challengeImage2,
    title: "Power Squat",
    description: "Build lower body strength and improve muscle definition with this powerful squat routine",
  ));

  workouts.add(Workout(
    imagePath: challengeImage3,
    title: "Press Leg Ultimate",
    description: "Lorem Ipsum Dolor Sit Amet Consectetur. Magins Pellentesque Felis Ullamcorper Imperdiet.",
  ));

  workouts.add(Workout(
    imagePath: challengeImage4,
    title: "Cycling",
    description: "Enhance your leg power and stamina with this ultimate leg press workout, perfect for strength training.",
  ));

  return workouts;
}

List<Workout> getArticleList() {
  List<Workout> Workouts = [];

  Workouts.add(Workout(
    imagePath: articleImage1,
    title: "Strength Training Tips",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
  ));

  Workouts.add(Workout(
    imagePath: articleImage2,
    title: "Healthy Weight Loss",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit...",
  ));

  Workouts.add(Workout(
    imagePath: articleImage3,
    title: "Unlock Your Gym Potential",
    description: "Experience a high-energy cycling session that strengthens your legs and improves cardiovascular fitness",
  ));

  Workouts.add(Workout(
    imagePath: articleImage4,
    title: "From Beginner To Buff",
    description: "Experience a high-energy cycling session that strengthens your legs and improves cardiovascular fitness",
  ));

  Workouts.add(Workout(
    imagePath: articleImage5,
    title: "Strategies For Gym Success",
    description: "Experience a high-energy cycling session that strengthens your legs and improves cardiovascular fitness",
  ));

  return Workouts;
}
