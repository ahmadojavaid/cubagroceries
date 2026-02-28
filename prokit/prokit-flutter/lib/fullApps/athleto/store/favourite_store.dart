import 'package:mobx/mobx.dart';

part 'favourite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {
  @observable
  ObservableList<Map<String, String>> favoriteItems = ObservableList<Map<String, String>>();

  @action
  void toggleFavorite(Map<String, String> item) {
    int index = favoriteItems.indexWhere((fav) => fav["title"] == item["title"]);
    if (index != -1) {
      favoriteItems.removeAt(index);
    } else {
      favoriteItems.add(item);
    }
  }

  bool isFavorite(String title) {
    return favoriteItems.any((item) => item["title"] == title);
  }
}
