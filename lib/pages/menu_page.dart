import 'dart:ui';

import 'package:flutter/cupertino.dart' hide MenuController;
import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quick_trip/utils/app_colors.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../controllers/home_controller.dart';
import '../utils/app_images.dart';
import '../utils/app_menus.dart';
import '../utils/app_strings.dart';

class MenuPage extends GetView<HomeController> {

  final VoidCallback onPressed;

  const MenuPage({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 220,
              width: double.maxFinite,
              // color: colors.containerColor,
              child: Stack(
                children: [
                  Positioned(left: 0, bottom: 0 ,child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image(image: AssetImage(AppImages.appLogo), height: 60, width: 60, fit: BoxFit.fill,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(AppStrings.appName, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                        ),
                        _buildProfile(context)
                      ],
                    ),
                  ))
                ],
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() => CustomSwitch(
                value: themeController.themeMode.value == ThemeMode.dark,
                onChanged: (value) {
                  themeController.toggleTheme(value);
                },
              )),
            ),*/
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: AppMenus.drawerMenuList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, position) {
                        var item = AppMenus.drawerMenuList[position];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            color: position == 0 ? AppColors.backgroundColor.withOpacity(0.2) : AppColors.secondaryColor,
                            child: Obx(() => ListTile(
                              selected: controller.selectedDrawerMenuIndex.value==position,
                              title: Text(item.title, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.normal, fontSize: 16),),
                              leading: Image(image: AssetImage(item.icon), height: 24, width: 24, color: AppColors.white,),
                              dense: true,
                              onTap: () {
                                controller.selectedDrawerMenuIndex.value = position;
                                controller.toggleDrawer();
                              },
                            )),
                          ),
                        );
                      },
                    ),
                    /*Visibility(
                      visible: *//*ref.watch(userProvider.notifier).getUser().isLoggedIn==true*//*true,
                      child: Padding(padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          children: [

                            const SizedBox(width: 16),

                            Expanded(child: OutlinedButton(
                              onPressed: () {
                                controller.logoutUser();
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.primaryColor, width: 2), // Border color and width
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2), // Padding for button size
                              ),
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white, // Text color
                                ),
                              ),
                            ),),

                            SizedBox(width: MediaQuery.of(context).size.width*0.2,)
                          ],
                        ),),
                    )*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.all(16), child: _buildVersionCode(context),),
    );
  }

  Widget _buildProfile(
      BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child:
      Text("Hello !", style: TextStyle(color: Colors.white70),),
    );
  }

  FutureBuilder<PackageInfo?> _buildVersionCode(
      BuildContext context) {
    return FutureBuilder<PackageInfo?>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          try {
            final PackageInfo data = snapshot.data!;

            return Text("Version ${data.version}", style: TextStyle(color: Colors.white),);
          }
          catch (e) {
            return const Text("Version 1.0.1", style: TextStyle(color: Colors.white));
          }
        } else {
          return const Center(
            child: LinearProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}