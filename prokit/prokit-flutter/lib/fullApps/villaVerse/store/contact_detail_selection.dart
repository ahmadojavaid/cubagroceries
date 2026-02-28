// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'contact_detail_selection.g.dart';

class ContactDetailSelection = _ContactDetailSelection with _$ContactDetailSelection;

class _ContactDetailSelection with Store {
  @observable
  int index = 0;
}
