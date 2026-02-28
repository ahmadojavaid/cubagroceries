// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on _FavoriteStore, Store {
  late final _$favoriteItemsAtom =
      Atom(name: '_FavoriteStore.favoriteItems', context: context);

  @override
  ObservableList<Map<String, String>> get favoriteItems {
    _$favoriteItemsAtom.reportRead();
    return super.favoriteItems;
  }

  @override
  set favoriteItems(ObservableList<Map<String, String>> value) {
    _$favoriteItemsAtom.reportWrite(value, super.favoriteItems, () {
      super.favoriteItems = value;
    });
  }

  late final _$_FavoriteStoreActionController =
      ActionController(name: '_FavoriteStore', context: context);

  @override
  void toggleFavorite(Map<String, String> item) {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction(
        name: '_FavoriteStore.toggleFavorite');
    try {
      return super.toggleFavorite(item);
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoriteItems: ${favoriteItems}
    ''';
  }
}
