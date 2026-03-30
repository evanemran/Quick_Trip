import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quick_trip/controllers/home_controller.dart';
import 'package:quick_trip/models/trip_model.dart';
import 'package:quick_trip/utils/app_images.dart';

import '../app_routes.dart';
import '../controllers/splash_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key, this.onDrawerClicked});

  final VoidCallback? onDrawerClicked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppStrings.appName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            onDrawerClicked!.call();
          },
          icon: Image.asset(
            AppImages.drawerLogo,
            color: AppColors.white,
            width: 24,
            height: 24,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          controller.loadAllTrips();
        },
        child: Obx(() => GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.tripList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 👈 2 columns
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85, // adjust for card height
          ),
          itemBuilder: (context, index) {
            final trip = controller.tripList[index];

            return GestureDetector(
              onTap: () async {
                bool isDeleted = await Get.toNamed(AppRoutes.tripDetailsPage, arguments: trip);
                if(isDeleted) {
                  controller.loadAllTrips();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🖼️ Image
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: trip.image.isNotEmpty
                            ? Image.network(trip.image, fit: BoxFit.cover)
                            : Icon(Icons.image, size: 40),
                      ),
                    ),

                    // 📄 Content
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trip.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            trip.date,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Total: ${trip.budget}",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          TripModel tripModel = await Get.toNamed(AppRoutes.addNewPage);
          if (tripModel != null) {
            controller.loadAllTrips();
          }
        },
        icon: Icon(Icons.add_task, color: Colors.white),
        label: Text(
          "ADD NEW",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
