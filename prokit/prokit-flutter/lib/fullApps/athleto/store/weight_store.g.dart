// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$WeightStore on _WeightStore, Store {
  late final _$selectedUnitAtom =
      Atom(name: '_WeightStore.selectedUnit', context: context);

  @override
  String get selectedUnit {
    _$selectedUnitAtom.reportRead();
    return super.selectedUnit;
  }

  @override
  set selectedUnit(String value) {
    _$selectedUnitAtom.reportWrite(value, super.selectedUnit, () {
      super.selectedUnit = value;
    });
  }

  late final _$selectedWeightAtom =
      Atom(name: '_WeightStore.selectedWeight', context: context);

  @override
  double get selectedWeight {
    _$selectedWeightAtom.reportRead();
    return super.selectedWeight;
  }

  @override
  set selectedWeight(double value) {
    _$selectedWeightAtom.reportWrite(value, super.selectedWeight, () {
      super.selectedWeight = value;
    });
  }

  late final _$_WeightStoreActionController =
      ActionController(name: '_WeightStore', context: context);

  @override
  void updateUnit(String unit) {
    final _$actionInfo = _$_WeightStoreActionController.startAction(
        name: '_WeightStore.updateUnit');
    try {
      return super.updateUnit(unit);
    } finally {
      _$_WeightStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateWeight(double weight) {
    final _$actionInfo = _$_WeightStoreActionController.startAction(
        name: '_WeightStore.updateWeight');
    try {
      return super.updateWeight(weight);
    } finally {
      _$_WeightStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedUnit: ${selectedUnit},
selectedWeight: ${selectedWeight}
    ''';
  }
}
