import 'package:mobx/mobx.dart';

part 'weight_store.g.dart';

class WeightStore = _WeightStore with _$WeightStore;

abstract class _WeightStore with Store {
  @observable
  String selectedUnit = 'KG';

  @observable
  double selectedWeight = 70.0;

  @action
  void updateUnit(String unit) {
    selectedUnit = unit;
  }

  @action
  void updateWeight(double weight) {
    selectedWeight = weight;
  }
}
