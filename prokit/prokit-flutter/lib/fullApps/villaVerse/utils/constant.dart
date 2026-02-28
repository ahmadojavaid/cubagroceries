import '../models/chat_model.dart';
import '../models/friens.dart';
import '../models/product_model.dart';
import '../models/rating_model.dart';
import '../store/invite_friend_store.dart';
import '../store/notification_switch.dart';
import '../store/theme_store.dart';

const BaseUrl = '';

// language enum
enum Language {
  englishUS,
  englishUK,
  hindi,
  spanish,
  french,
  arabic,
  bengali,
  russian,
  indonesia,
  gujarati,
  urdu,
  marathi,
}

// store Objects
final notiStore = NotificationSwitch();
final themeStore = ThemeStore();
final inviteFriendStore = InviteFriendStore();

// get list of models
List<RatingModel> ratingList = getRatingList();
List<ProductModel> featuredList = getFeaturedList();
List<ProductModel> recommended = getFeaturedList();
List<Friends> inviteFriendsList = getFriendsList();
List<ProductModel> favoriteProducts = getFavoriteProductList();
List<ChatModel> chatList = getChatList();
List<ChatModel> callList = getCallList();

var image;
