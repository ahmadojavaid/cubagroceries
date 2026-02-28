// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

part of 'theme_store.dart';

// **************************************************************************//
// StoreGenerator
// **************************************************************************//

mixin _$ThemeStore on _ThemeStore, Store {
  late final _$themeModeAtom =
  Atom(name: '_ThemeStore.themeMode', context: context);

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$_ThemeStoreActionController =
  ActionController(name: '_ThemeStore', context: context);

  @override
  void toggleTheme() {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
        name: '_ThemeStore.toggleTheme');
    try {
      return super.toggleTheme();
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }
}
