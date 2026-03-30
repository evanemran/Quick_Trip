import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_routes.dart';
import 'app_images.dart';
import 'app_strings.dart';


class AppMenus {
  static const List<Menu> drawerMenuList = [
    Menu.home,
    Menu.reports,
    Menu.alarms,
    Menu.settings,
    Menu.policy,
  ];

// static const List<Menu> bottomMenuList = [
//   Menu.home,
//   Menu.savings,
//   Menu.notifications,
//   Menu.profile,
// ];
}

enum Menu{
  home(AppStrings.home, AppImages.homeLogo, AppRoutes.homePage),
  reports(AppStrings.report, AppImages.reportLogo, AppRoutes.homePage),
  policy(AppStrings.policy, AppImages.policyLogo, AppRoutes.homePage),
  settings(AppStrings.settings, AppImages.settingsLogo, AppRoutes.homePage),
  alarms(AppStrings.alarms, AppImages.notificationsLogo, AppRoutes.homePage);


  final String title;
  final String icon;
  final String route;

  const Menu(this.title, this.icon, this.route);
}