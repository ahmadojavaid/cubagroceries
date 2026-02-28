import 'package:mobx/mobx.dart';

part 'activity_level_store.g.dart';

class ActivityLevelStore = _ActivityLevelStore with _$ActivityLevelStore;

abstract class _ActivityLevelStore with Store {
  @observable
  String selectedLevel = "";

  @action
  void setSelectedLevel(String level) {
    selectedLevel = level;
  }
}
