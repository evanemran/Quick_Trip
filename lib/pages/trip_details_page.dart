import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quick_trip/controllers/trip_details_controller.dart';
import 'package:quick_trip/utils/app_menus.dart';

import '../app_routes.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';

class TripDetailsPage extends GetView<TripDetailsController> {
  const TripDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppStrings.tripDetails,
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
        actions: [
          PopupMenuButton<String>(
            color: AppColors.white,
            iconColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == 'edit') {
                print("Edit clicked");
              } else if (value == 'delete') {
                controller.deleteTrip();
              } else if (value == 'share') {
                print("Share clicked");
              } else if (value == 'add_new_person') {
                print("Share clicked");
              } else if (value == 'change_image') {
                print("Share clicked");
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'add_new_person',
                child: Row(
                  children: [
                    Icon(Icons.person_add, size: 18),
                    SizedBox(width: 8),
                    Text("Add New Person"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'change_image',
                child: Row(
                  children: [
                    Icon(Icons.image, size: 18),
                    SizedBox(width: 8),
                    Text("Change Image"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 18),
                    SizedBox(width: 8),
                    Text("Edit Trip"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 18),
                    SizedBox(width: 8),
                    Text("Delete Trip"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, size: 18),
                    SizedBox(width: 8),
                    Text("Share Trip Data"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              color: AppColors.primaryColor,
              child: Stack(
                children: [
                  Image.network(
                    controller.trip.image,
                    height: 120,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.trip.name,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black54,
                              ),
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 6,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          controller.trip.date,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            shadows: [
                              Shadow(
                                offset: Offset(1, 1),
                                blurRadius: 3,
                                color: Colors.black54,
                              ),
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 6,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: AppColors.white,
              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.trip.tripDetailModel.members.length,
                  itemBuilder: (context, position) {
                    var member =
                        controller.trip.tripDetailModel.members[position];

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      horizontalTitleGap: 8,
                      minLeadingWidth: 0,
                      onTap: () {},
                      title: Text(member.name),
                      subtitle: Row(
                        children: [
                          Text(
                            member.amountSpent.toStringAsFixed(2),
                            style: TextStyle(color: AppColors.black),
                          ),
                          SizedBox(width: 8),
                          Text(
                            member.dueOrRefund.toStringAsFixed(2),
                            style: TextStyle(
                              color: member.dueOrRefund >= 0
                                  ? AppColors.green
                                  : AppColors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 36,
                          width: 36,
                          color:
                              Colors.primaries[member.name.hashCode %
                                  Colors.primaries.length], // random color
                          alignment: Alignment.center,
                          child: Text(
                            member.name.isNotEmpty
                                ? member.name[0].toUpperCase()
                                : "?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            AppRoutes.addExpensePage,
                            arguments: {
                              "trip": controller.trip,
                              "member": member,
                            },
                          );
                        },
                        icon: Icon(Icons.add, color: AppColors.primaryColor),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.backgroundColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Card(
              color: AppColors.white,
              margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: AppMenus.detailMenu.length,
                  itemBuilder: (context, position) {
                    var menu =
                    AppMenus.detailMenu[position];

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      horizontalTitleGap: 8,
                      minLeadingWidth: 0,
                      onTap: () {},
                      title: Text(menu.name),
                      subtitle: Row(
                        children: [
                          Text(
                            "data",
                            style: TextStyle(color: AppColors.black),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "data",
                            style: TextStyle(color:  AppColors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      /*leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 36,
                          width: 36,
                          color:
                          Colors.primaries[member.name.hashCode %
                              Colors.primaries.length], // random color
                          alignment: Alignment.center,
                          child: Text(
                            member.name.isNotEmpty
                                ? member.name[0].toUpperCase()
                                : "?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),*/
                      trailing: IconButton(
                        onPressed: () {
                          // Get.toNamed(
                          //   AppRoutes.addExpensePage,
                          //   arguments: {
                          //     "trip": controller.trip,
                          //     "member": member,
                          //   },
                          // );
                        },
                        icon: Icon(Icons.add, color: AppColors.primaryColor),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.backgroundColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
