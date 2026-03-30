import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quick_trip/controllers/total_controller.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';

class TotalPage extends GetView<TotalController> {
  const TotalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppStrings.total,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            AppImages.backLogo,
            color: AppColors.white,
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: AppColors.white,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "BDT 25,750",
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8),
            child: ListView.separated(
                itemBuilder: (context, position) {

                },
                separatorBuilder: (context, index) {
                  return Divider(height: 1, thickness: 1,); // separator widget
                },
                itemCount: 10
            ),
          ),
        ],
      ),
    );
  }
}
