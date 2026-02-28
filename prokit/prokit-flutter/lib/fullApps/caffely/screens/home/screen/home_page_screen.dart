import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/colors.dart';
import '../../../utils/constant.dart';
import 'navigation_controller.dart';

class HomePageScreen extends StatelessWidget {
  final String? imagePath;

  const HomePageScreen({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    final navigationController = NavigationController();

    return Scaffold(
      body: Observer(
        builder: (_) => navigationController.screens[navigationController.selectedIndex],
      ),
      bottomNavigationBar: Observer(
        builder: (_) => NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: PickColor.blackTransparent,
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
              return TextStyle(
                color: states.contains(WidgetState.selected) ? PickColor.brownColor : PickColor.greyColor,
                fontWeight: states.contains(WidgetState.selected) ? FontWeight.bold : null,
              );
            }),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
              return IconThemeData(
                color: states.contains(WidgetState.selected) ? PickColor.brownColor : PickColor.greyColor,
              );
            }),
          ),
          child: NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: navigationController.selectedIndex,
            onDestinationSelected: navigationController.setSelectedIndex,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: BottomNavigationText.home,
              ),
              NavigationDestination(
                icon: Icon(Icons.shopify_outlined),
                label: BottomNavigationText.shop,
              ),
              NavigationDestination(
                icon: Icon(Icons.list),
                label: BottomNavigationText.order,
              ),
              NavigationDestination(
                icon: Icon(Icons.wallet),
                label: BottomNavigationText.wallet,
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: BottomNavigationText.account,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
