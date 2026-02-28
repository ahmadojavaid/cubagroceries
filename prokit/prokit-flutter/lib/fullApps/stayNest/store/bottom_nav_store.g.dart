// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'bottom_nav_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$BottomNavStore on _BottomNavStore, Store {
  late final _$selectedIndexAtom = Atom(name: '_BottomNavStore.selectedIndex', context: context);

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

  late final _$_BottomNavStoreActionController = ActionController(name: '_BottomNavStore', context: context);

  @override
  void changeTab(int index) {
    final $actionInfo = _$_BottomNavStoreActionController.startAction(name: '_BottomNavStore.changeTab');
    try {
      return super.changeTab(index);
    } finally {
      _$_BottomNavStoreActionController.endAction($actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: $selectedIndex
    ''';
  }
}
