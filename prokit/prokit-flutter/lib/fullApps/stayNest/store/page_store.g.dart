// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'page_store.dart';

// ************************************************************************** 
// StoreGenerator 
// ************************************************************************** 

mixin _$PageStore on _PageStore, Store {
  final _$currentPageAtom = Atom(name: '_PageStore.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$_PageStoreActionController = ActionController(name: '_PageStore');

  @override
  void setPage(int index) {
    final $actionInfo =
        _$_PageStoreActionController.startAction(name: '_PageStore.setPage');
    try {
      return super.setPage(index);
    } finally {
      _$_PageStoreActionController.endAction($actionInfo);
    }
  }

  @override
  void nextPage() {
    final $actionInfo =
        _$_PageStoreActionController.startAction(name: '_PageStore.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_PageStoreActionController.endAction($actionInfo);
    }
  }

  @override
  void skipToLastPage() {
    final $actionInfo = _$_PageStoreActionController.startAction(
        name: '_PageStore.skipToLastPage');
    try {
      return super.skipToLastPage();
    } finally {
      _$_PageStoreActionController.endAction($actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: $currentPage
    ''';
  }
}
