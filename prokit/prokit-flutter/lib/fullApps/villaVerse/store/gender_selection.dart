// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'gender_selection.g.dart';

class GenderSelection = _GenderSelection with _$GenderSelection;

abstract class _GenderSelection with Store {
  @observable
  String selectedGender = "Gender";

  @action
  void setGender(String value) {
    selectedGender = value;
  }
}
