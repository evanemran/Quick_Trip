import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quick_trip/utils/app_colors.dart';

import '../controllers/home_controller.dart';
import 'home_page.dart';
import 'menu_page.dart';

class DrawerPage extends GetView<HomeController> {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {

    return ZoomDrawer(
      controller: controller.zoomDrawerController,
      style: DrawerStyle.defaultStyle,
      // Change drawer animation style
      menuScreen: MenuPage(onPressed: () {}),
      mainScreen: HomePage(onDrawerClicked: controller.toggleDrawer,),
      borderRadius: 24.0,
      // Adjust corner radius
      showShadow: true,
      // Enable shadow for the main screen
      angle: 0.0,
      // Adjust the tilt angle of the main screen
      slideWidth: MediaQuery
          .of(context)
          .size
          .width * 0.75,
      // Width of the drawer
      menuBackgroundColor: AppColors.secondaryColor,
      // shadowLayer1Color: Colors.grey.shade50,
      // shadowLayer2Color: Colors.grey.shade100,
      // Background color of the menu
      androidCloseOnBackTap: true,
      mainScreenTapClose: true,
    );
  }
}