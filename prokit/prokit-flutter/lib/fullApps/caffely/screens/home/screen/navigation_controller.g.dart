

part of 'navigation_controller.dart';



mixin _$NavigationController on _NavigationController, Store {
  late final _$selectedIndexAtom =
      Atom(name: '_NavigationController.selectedIndex', context: context);

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

  late final _$_NavigationControllerActionController =
      ActionController(name: '_NavigationController', context: context);

  @override
  void setSelectedIndex(int index) {
    final _$actionInfo = _$_NavigationControllerActionController.startAction(
        name: '_NavigationController.setSelectedIndex');
    try {
      return super.setSelectedIndex(index);
    } finally {
      _$_NavigationControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedIndex: $selectedIndex
    ''';
  }
}
