import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../account/screen/accoount_home_screen.dart';
import '../../order/screen/order_home_screen.dart';
import '../../shop/screen/shop_home.dart';
import '../../wallet/screen/wallet_home_screen.dart';
import 'home_content_screen.dart';

part 'navigation_controller.g.dart';

class NavigationController = _NavigationController with _$NavigationController;

abstract class _NavigationController with Store {
  @observable
  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeContentScreen(),
    const ShopHomeScreen(),
    const OrderHomeScreen(),
    const WalletHomeScreen(),
    const AccountHomeScreen(),
  ];

  @action
  void setSelectedIndex(int index) {
    selectedIndex = index;
  }
}
