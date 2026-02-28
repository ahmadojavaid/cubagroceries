import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'page_store.g.dart';

// ignore: library_private_types_in_public_api
class PageStore = _PageStore with _$PageStore;

abstract class _PageStore with Store {
  final PageController controller = PageController();
  @observable
  int lastPage = 2;

  @observable
  int currentPage = 0;

  @action
  void setPage(int index) {
    currentPage = index;
  }

  @action
  void nextPage() {
    if (currentPage < lastPage) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @action
  void skipToLastPage() {
    controller.animateToPage(
      lastPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
