// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers, non_constant_identifier_names

part of 'gender_selection.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$GenderSelection on _GenderSelection, Store {
  final _$selectedGenderAtom = Atom(name: '_GenderSelection.selectedGender');

  @override
  String get selectedGender {
    _$selectedGenderAtom.reportRead();
    return super.selectedGender;
  }

  @override
  set selectedGender(String value) {
    _$selectedGenderAtom.reportWrite(value, super.selectedGender, () {
      super.selectedGender = value;
    });
  }

  final _$_GenderSelectionActionController = ActionController(name: '_GenderSelection');

  @override
  void setGender(String value) {
    final _$actionInfo = _$_GenderSelectionActionController.startAction(name: '_GenderSelection.setGender');
    try {
      return super.setGender(value);
    } finally {
      _$_GenderSelectionActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedGender: ${selectedGender}
    ''';
  }
}
