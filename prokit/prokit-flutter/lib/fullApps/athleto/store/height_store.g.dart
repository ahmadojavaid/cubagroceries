// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'height_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HeightStore on _HeightStore, Store {
  late final _$selectedHeightAtom =
      Atom(name: '_HeightStore.selectedHeight', context: context);

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

  late final _$_HeightStoreActionController =
      ActionController(name: '_HeightStore', context: context);

  @override
  void updateHeight(double height) {
    final _$actionInfo = _$_HeightStoreActionController.startAction(
        name: '_HeightStore.updateHeight');
    try {
      return super.updateHeight(height);
    } finally {
      _$_HeightStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedHeight: ${selectedHeight}
    ''';
  }
}
