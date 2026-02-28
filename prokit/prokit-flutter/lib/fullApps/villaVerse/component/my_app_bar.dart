import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../utils/colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final TabController? tabController;
  final List<Tab>? tabs;

  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.tabController,
    this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    final hasTabs = tabController != null && tabs != null;
    return AppBar(
      backgroundColor: appStore.isDarkModeOn ? darkColor : lightColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(title, style: boldTextStyle(size: 18)),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
        statusBarBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark,
      ),
      leading: showBackButton
          ? SizedBox(
              child: InkWell(
                onTap: () => finish(context),
                child: Icon(Icons.arrow_back,
                    color: appStore.isDarkModeOn ? lightColor : darkColor),
              ),
            )
          : null,
      actions: actions,
      bottom: hasTabs
          ? TabBar(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 3, color: primaryBlueColor, strokeAlign: 50),
                  insets: EdgeInsets.symmetric(horizontal: 100)),
              padding: EdgeInsets.symmetric(horizontal: 20),
              labelColor: primaryBlueColor,
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              dividerColor: Colors.transparent,
              controller: tabController,
              tabs: tabs!,
            )
          : null,
    );
  }

  @override
  Size get preferredSize {
    final hasTabs = tabController != null && tabs != null;
    return Size.fromHeight(kToolbarHeight + (hasTabs ? kTextTabBarHeight : 0));
  }
}
