// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'age_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AgeStore on _AgeStore, Store {
  late final _$selectedHeightAtom =
      Atom(name: '_AgeStore.selectedHeight', context: context);

  @override
  double get selectedHeight {
    _$selectedHeightAtom.reportRead();
    return super.selectedHeight;
  }

  @override
  set selectedHeight(double value) {
    _$selectedHeightAtom.reportWrite(value, super.selectedHeight, () {
      super.selectedHeight = value;
    });
  }

  late final _$_AgeStoreActionController =
      ActionController(name: '_AgeStore', context: context);

  @override
  void setSelectedHeight(double value) {
    final _$actionInfo = _$_AgeStoreActionController.startAction(
        name: '_AgeStore.setSelectedHeight');
    try {
      return super.setSelectedHeight(value);
    } finally {
      _$_AgeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedHeight: ${selectedHeight}
    ''';
  }
}
