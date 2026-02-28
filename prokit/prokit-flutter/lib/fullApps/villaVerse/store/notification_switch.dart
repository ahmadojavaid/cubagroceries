// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'notification_switch.g.dart';

class NotificationSwitch = _NotificationSwitch with _$NotificationSwitch;

abstract class _NotificationSwitch with Store {
  @observable
  bool generalNotification = false;

  @observable
  bool sound = false;

  @observable
  bool vibrate = false;

  @observable
  bool specialOffers = false;

  @observable
  bool promoDiscount = false;

  @observable
  bool payment = false;

  @observable
  bool cashback = false;

  @observable
  bool appUpdates = false;

  @observable
  bool newService = false;

  @observable
  bool newTipAvailable = false;

  @observable
  bool rememberMe = false;

  @observable
  bool faceId = false;

  @observable
  bool biometricId = false;
}
