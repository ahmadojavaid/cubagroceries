// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationsStore on _NotificationsStore, Store {
  late final _$selectedIndexAtom =
      Atom(name: '_NotificationsStore.selectedIndex', context: context);

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  late final _$generalNotificationAtom =
      Atom(name: '_NotificationsStore.generalNotification', context: context);

  @override
  bool get generalNotification {
    _$generalNotificationAtom.reportRead();
    return super.generalNotification;
  }

  @override
  set generalNotification(bool value) {
    _$generalNotificationAtom.reportWrite(value, super.generalNotification, () {
      super.generalNotification = value;
    });
  }

  late final _$soundAtom =
      Atom(name: '_NotificationsStore.sound', context: context);

  @override
  bool get sound {
    _$soundAtom.reportRead();
    return super.sound;
  }

  @override
  set sound(bool value) {
    _$soundAtom.reportWrite(value, super.sound, () {
      super.sound = value;
    });
  }

  late final _$doNotDisturbAtom =
      Atom(name: '_NotificationsStore.doNotDisturb', context: context);

  @override
  bool get doNotDisturb {
    _$doNotDisturbAtom.reportRead();
    return super.doNotDisturb;
  }

  @override
  set doNotDisturb(bool value) {
    _$doNotDisturbAtom.reportWrite(value, super.doNotDisturb, () {
      super.doNotDisturb = value;
    });
  }

  late final _$vibrateAtom =
      Atom(name: '_NotificationsStore.vibrate', context: context);

  @override
  bool get vibrate {
    _$vibrateAtom.reportRead();
    return super.vibrate;
  }

  @override
  set vibrate(bool value) {
    _$vibrateAtom.reportWrite(value, super.vibrate, () {
      super.vibrate = value;
    });
  }

  late final _$lockScreenAtom =
      Atom(name: '_NotificationsStore.lockScreen', context: context);

  @override
  bool get lockScreen {
    _$lockScreenAtom.reportRead();
    return super.lockScreen;
  }

  @override
  set lockScreen(bool value) {
    _$lockScreenAtom.reportWrite(value, super.lockScreen, () {
      super.lockScreen = value;
    });
  }

  late final _$remindersAtom =
      Atom(name: '_NotificationsStore.reminders', context: context);

  @override
  bool get reminders {
    _$remindersAtom.reportRead();
    return super.reminders;
  }

  @override
  set reminders(bool value) {
    _$remindersAtom.reportWrite(value, super.reminders, () {
      super.reminders = value;
    });
  }

  late final _$_NotificationsStoreActionController =
      ActionController(name: '_NotificationsStore', context: context);

  @override
  void setSelectedIndex(int index) {
    final _$actionInfo = _$_NotificationsStoreActionController.startAction(
        name: '_NotificationsStore.setSelectedIndex');
    try {
      return super.setSelectedIndex(index);
    } finally {
      _$_NotificationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGeneralNotification(bool value) {
    final _$actionInfo = _$_NotificationsStoreActionController.startAction(
        name: '_NotificationsStore.setGeneralNotification');
    try {
      return super.setGeneralNotification(value);
    } finally {
      _$_NotificationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSound(bool value) {
    final _$actionInfo = _$_NotificationsStoreActionController.startAction(
        name: '_NotificationsStore.setSound');
    try {
      return super.setSound(value);
    } finally {
      _$_NotificationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDoNotDisturb(bool value) {
    final _$actionInfo = _$_NotificationsStoreActionController.startAction(
        name: '_NotificationsStore.setDoNotDisturb');
    try {
      return super.setDoNotDisturb(value);
    } finally {
      _$_NotificationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVibrate(bool value) {
    final _$actionInfo = _$_NotificationsStoreActionController.startAction(
        name: '_NotificationsStore.setVibrate');
    try {
      return super.setVibrate(value);
    } finally {
      _$_NotificationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLockScreen(bool value) {
    final _$actionInfo = _$_NotificationsStoreActionController.startAction(
        name: '_NotificationsStore.setLockScreen');
    try {
      return super.setLockScreen(value);
    } finally {
      _$_NotificationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReminders(bool value) {
    final _$actionInfo = _$_NotificationsStoreActionController.startAction(
        name: '_NotificationsStore.setReminders');
    try {
      return super.setReminders(value);
    } finally {
      _$_NotificationsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: ${selectedIndex},
generalNotification: ${generalNotification},
sound: ${sound},
doNotDisturb: ${doNotDisturb},
vibrate: ${vibrate},
lockScreen: ${lockScreen},
reminders: ${reminders}
    ''';
  }
}
