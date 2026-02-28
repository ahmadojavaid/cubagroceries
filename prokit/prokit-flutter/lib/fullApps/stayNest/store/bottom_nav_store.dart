// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'bottom_nav_store.g.dart';

class BottomNavStore = _BottomNavStore with _$BottomNavStore;

abstract class _BottomNavStore with Store {
  @observable
  int selectedIndex = 0;

  @action
  void changeTab(int index) {
    selectedIndex = index;
  }
}
