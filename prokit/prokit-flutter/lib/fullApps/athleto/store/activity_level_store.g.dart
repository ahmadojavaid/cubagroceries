// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_level_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ActivityLevelStore on _ActivityLevelStore, Store {
  late final _$selectedLevelAtom =
      Atom(name: '_ActivityLevelStore.selectedLevel', context: context);

  @override
  String get selectedLevel {
    _$selectedLevelAtom.reportRead();
    return super.selectedLevel;
  }

  @override
  set selectedLevel(String value) {
    _$selectedLevelAtom.reportWrite(value, super.selectedLevel, () {
      super.selectedLevel = value;
    });
  }

  late final _$_ActivityLevelStoreActionController =
      ActionController(name: '_ActivityLevelStore', context: context);

  @override
  void setSelectedLevel(String level) {
    final _$actionInfo = _$_ActivityLevelStoreActionController.startAction(
        name: '_ActivityLevelStore.setSelectedLevel');
    try {
      return super.setSelectedLevel(level);
    } finally {
      _$_ActivityLevelStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedLevel: ${selectedLevel}
    ''';
  }
}
