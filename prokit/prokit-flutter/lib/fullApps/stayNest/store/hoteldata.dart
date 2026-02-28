// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

part 'hoteldata.g.dart';

class HotelStorecard = _HotelStore with _$HotelStore;

abstract class _HotelStore with Store {
  @observable
  int currentPage = 0;

  @action
  void changePage(int page) {
    currentPage = page;
  }



}
