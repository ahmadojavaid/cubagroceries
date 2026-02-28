import '../utils/image.dart';

class Meal {
  final String imagePath;
  final String title;
  final String duration;
  final String calories;
  final bool isFavorite;

  Meal({
    required this.imagePath,
    required this.title,
    required this.duration,
    required this.calories,
    this.isFavorite = false,
  });

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      imagePath: map["imagePath"] ?? "",
      title: map["title"] ?? "",
      duration: map["duration"] ?? "N/A",
      calories: map["calories"] ?? "N/A",
      isFavorite: map["isFavorite"] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "imagePath": imagePath,
      "title": title,
      "duration": duration,
      "calories": calories,
      "isFavorite": isFavorite,
    };
  }
}

class FeaturedRecipe extends Meal {
  final String tag;

  FeaturedRecipe({
    required String imagePath,
    required String title,
    required String duration,
    required String calories,
    required this.tag,
    bool isFavorite = false,
  }) : super(
          imagePath: imagePath,
          title: title,
          duration: duration,
          calories: calories,
          isFavorite: isFavorite,
        );
}

// Featured Recipe (Upper Side)
FeaturedRecipe featuredRecipe = FeaturedRecipe(
  imagePath: breakfastImage1,
  title: "Spinach And Tomato Omelette",
  duration: "10 Minutes",
  calories: "220 Cal",
  tag: "Recipe Of The Day",
);

// Recommended Recipes
List<Meal> getRecommendedMeals() {
  List<Meal> recommendedMeals = [];

  recommendedMeals.add(Meal(
    imagePath: breakfastImage2,
    title: "Fruit Smoothie",
    duration: "12 Minutes",
    calories: "120 Cal",
  ));

  recommendedMeals.add(Meal(
    imagePath: breakfastImage3,
    title: "Green Celery Juice",
    duration: "12 Minutes",
    calories: "120 Cal",
  ));

  return recommendedMeals;
}

List<Meal> getRecipesForYou() {
  List<Meal> recipesForYou = [];

  recipesForYou.add(Meal(
    imagePath: breakfastImage4,
    title: "Delights With Greek Yogurt",
    duration: "6 Minutes",
    calories: "200 Cal",
  ));

  recipesForYou.add(Meal(
    imagePath: breakfastImage5,
    title: "Avocado And Egg Toast",
    duration: "15 Minutes",
    calories: "150 Cal",
  ));

  recipesForYou.add(Meal(
    imagePath: breakfastImage4,
    title: "Delights With Greek Yogurt",
    duration: "6 Minutes",
    calories: "200 Cal",
  ));

  recipesForYou.add(Meal(
    imagePath: breakfastImage5,
    title: "Avocado And Egg Toast",
    duration: "15 Minutes",
    calories: "150 Cal",
  ));

  return recipesForYou;
}

Meal featuredDinnerMeal = Meal(
  imagePath: dinnerImage1,
  title: "Grilled Chicken Salad",
  duration: "20 Minutes",
  calories: "240 Cal",
);

// Recommended Meals (Grid View)
List<Meal> getRecommendedDinnerMeals() {
  List<Meal> recommendedDinnerMeals = [];

  recommendedDinnerMeals.add(Meal(
    imagePath: dinnerImage2,
    title: "Chickpea Salad",
    duration: "20 Minutes",
    calories: "300 Cal",
  ));

  recommendedDinnerMeals.add(Meal(
    imagePath: dinnerImage3,
    title: "Lentil Soup",
    duration: "30 Minutes",
    calories: "200 Cal",
  ));

  return recommendedDinnerMeals;
}

// Recipes For You (List View)
List<Meal> getDinnerRecipesForYou() {
  List<Meal> recipesForYouDinner = [];

  recipesForYouDinner.add(Meal(
    imagePath: dinnerImage4,
    title: "Turkey And Avocado Wrap",
    duration: "15 Minutes",
    calories: "230 Cal",
  ));

  recipesForYouDinner.add(Meal(
    imagePath: dinnerImage5,
    title: "Chicken Breast Stuffed With Spinach",
    duration: "30 Minutes",
    calories: "250 Cal",
  ));

  return recipesForYouDinner;
}

// Lunch
// Featured Lunch Meal (Top Card)
Meal getFeaturedLunchMeal() {
  return Meal(
    imagePath: lunchImage1,
    title: "Salmon And Avocado Salad",
    duration: "15 Minutes",
    calories: "300 Cal",
  );
}

// Recommended Lunch Meals (Grid View)
List<Meal> getRecommendedLunchMeals() {
  List<Meal> recommendedLunchMeals = [];

  recommendedLunchMeals.add(Meal(
    imagePath: lunchImage2,
    title: "Quinoa Salad",
    duration: "25 Minutes",
    calories: "300 Cal",
  ));

  recommendedLunchMeals.add(Meal(
    imagePath: lunchImage3,
    title: "Burrito With Vegetables",
    duration: "20 Minutes",
    calories: "250 Cal",
  ));

  return recommendedLunchMeals;
}

// Recipes For You (List View)
List<Meal> getRecipesForYouLunch() {
  List<Meal> recipesForYouLunch = [];

  recipesForYouLunch.add(Meal(
    imagePath: lunchImage4,
    title: "Teriyaki Chicken Rice",
    duration: "45 Minutes",
    calories: "375 Cal",
  ));

  recipesForYouLunch.add(Meal(
    imagePath: lunchImage5,
    title: "Baked Salmon",
    duration: "30 Minutes",
    calories: "350 Cal",
  ));

  return recipesForYouLunch;
}

// plan
List<Meal> getBreakfastPlanMeals() {
  List<Meal> recommendedMeals = [];

  recommendedMeals.add(Meal(
    imagePath: breakfastImage4,
    title: "Delights With Greek Yogurt",
    duration: "6 Minutes",
    calories: "200 Cal",
  ));

  recommendedMeals.add(Meal(
    imagePath: breakfastImage1,
    title: "Spinach And Tomato Omelette",
    duration: "10 Minutes",
    calories: "220 Cal",
  ));

  recommendedMeals.add(Meal(
    imagePath: lunchImage1,
    title: "Avocado And Egg Toast",
    duration: "15 Minutes",
    calories: "150 Cal",
  ));

  recommendedMeals.add(Meal(
    imagePath: breakfastImage4,
    title: "Protein Shake With Fruits",
    duration: "9 Minutes",
    calories: "180 Cal",
  ));

  return recommendedMeals;
}

List<Meal> getMainRecommendList() {
  List<Meal> workouts = [];

  workouts.add(Meal(
    imagePath: resourceImage1,
    title: "Loop Band Exercises",
    duration: "45 Min",
    calories: "120",
    isFavorite: true,
  ));
  workouts.add(Meal(
    imagePath: resourceImage3,
    title: "Full Body Stretch",
    duration: "45 Min",
    calories: "120",
    isFavorite: true,
  ));
  workouts.add(Meal(
    imagePath: resourceImage1,
    title: "Loop Band Exercises",
    duration: "45 Min",
    calories: "120",
    isFavorite: true,
  ));
  workouts.add(Meal(
    imagePath: resourceImage3,
    title: "Full Body Stretch",
    duration: "45 Min",
    calories: "120",
    isFavorite: true,
  ));
  return workouts;
}
