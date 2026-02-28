import 'package:mobx/mobx.dart';

part 'height_store.g.dart';

class HeightStore = _HeightStore with _$HeightStore;

abstract class _HeightStore with Store {
  @observable
  double selectedHeight = 175.0;

  @action
  void updateHeight(double height) {
    selectedHeight = height;
  }
}
