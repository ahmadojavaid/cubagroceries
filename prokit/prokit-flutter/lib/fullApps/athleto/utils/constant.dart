import '../model/meal_model.dart';
import '../model/recomended_model.dart';
import '../model/workout_long_model.dart';
import '../model/workout_model.dart';
import '../store/favourite_store.dart';
import '../store/height_store.dart';
import '../store/weight_store.dart';

const BaseUrl = '';

//breakfast
List<Meal> recommendationMeal = getRecommendedMeals();
List<Meal> recipesForYou = getRecipesForYou();
// dinner

List<Meal> recommendationDinnerMeal = getRecommendedDinnerMeals();
List<Meal> recipesForYouDinner = getDinnerRecipesForYou();
//Lunch
Meal featuredLunchMeal = getFeaturedLunchMeal();
List<Meal> recommendationLunchMeal = getRecommendedLunchMeals();
List<Meal> recipesForYouLunch = getRecipesForYouLunch();
// breakfast plan
List<Meal> breakfastPlanMeals = getBreakfastPlanMeals();
// challenges
List<Workout> workoutList = getWorkoutList();
//Article
List<Workout> articleList = getArticleList();
List<RecomendedModel> recommendedList = getRecommendList();
// Workout card
List<WorkoutCardModel> workoutCardList = getWorkoutCardList();
List<WorkoutCardModel> intermediateWorkouts = getIntermediateWorkouts();
List<WorkoutCardModel> advancedWorkout = getAdvancedWorkouts();
List<Meal> mainWorkout = getMainRecommendList();

final FavoriteStore favoriteStore = FavoriteStore();
final HeightStore heightStore = HeightStore();
final WeightStore weightStore = WeightStore();
