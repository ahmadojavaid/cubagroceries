// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  @observable
  ThemeMode themeMode = ThemeMode.light;


  @action
  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}