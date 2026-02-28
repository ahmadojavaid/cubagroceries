// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************//
// StoreGenerator
// **************************************************************************//

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, 
// prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, 
// avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on _ThemeStore, Store {
  late final _$isLightThemeAtom =
      Atom(name: '_ThemeStore.isLightTheme', context: context);

  @override
  bool get isLightTheme {
    _$isLightThemeAtom.reportRead();
    return super.isLightTheme;
  }

  @override
  set isLightTheme(bool value) {
    _$isLightThemeAtom.reportWrite(value, super.isLightTheme, () {
      super.isLightTheme = value;
    });
  }

  late final _$isDarkModeAtom =
      Atom(name: '_ThemeStore.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$setDarkModeAsyncAction =
      AsyncAction('_ThemeStore.setDarkMode', context: context);

  @override
  Future<void> setDarkMode(bool val) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(val));
  }

  late final _$_ThemeStoreActionController =
      ActionController(name: '_ThemeStore', context: context);

  @override
  void toggleTheme() {
    final $actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.toggleTheme');
    try {
      return super.toggleTheme();
    } finally {
      _$_ThemeStoreActionController.endAction($actionInfo);
    }
  }
}
