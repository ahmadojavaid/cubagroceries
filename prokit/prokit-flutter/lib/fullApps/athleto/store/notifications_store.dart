import 'package:mobx/mobx.dart';

part 'notifications_store.g.dart';

class NotificationsStore = _NotificationsStore with _$NotificationsStore;

abstract class _NotificationsStore with Store {
  @observable
  int selectedIndex = 0;

  @observable
  bool generalNotification = false;

  @observable
  bool sound = false;

  @observable
  bool doNotDisturb = false;

  @observable
  bool vibrate = false;

  @observable
  bool lockScreen = false;

  @observable
  bool reminders = false;

  @action
  void setSelectedIndex(int index) {
    selectedIndex = index;
  }

  @action
  void setGeneralNotification(bool value) => generalNotification = value;

  @action
  void setSound(bool value) => sound = value;

  @action
  void setDoNotDisturb(bool value) => doNotDisturb = value;

  @action
  void setVibrate(bool value) => vibrate = value;

  @action
  void setLockScreen(bool value) => lockScreen = value;

  @action
  void setReminders(bool value) => reminders = value;
}
