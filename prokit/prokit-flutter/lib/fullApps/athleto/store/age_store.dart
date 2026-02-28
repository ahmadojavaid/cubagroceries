import 'package:mobx/mobx.dart';

part 'age_store.g.dart';

class AgeStore = _AgeStore with _$AgeStore;

abstract class _AgeStore with Store {
  @observable
  double selectedHeight = 18.0;

  @action
  void setSelectedHeight(double value) {
    selectedHeight = value;
  }
}
