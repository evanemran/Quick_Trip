import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:quick_trip/controllers/add_trip_controller.dart';
import 'package:quick_trip/models/trip_detail_model.dart';
import 'package:quick_trip/models/trip_model.dart';
import 'package:uuid/uuid.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';

class AddTripPage extends GetView<AddTripController> {
  const AddTripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppStrings.addTrip,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: AppColors.white,
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Text("Trip Name"),
                    ),
                    TextField(
                      controller: controller.tripNameController,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        prefixIconColor: AppColors.primaryColor,
                        fillColor: AppColors.white,
                        // labelText: "Medicine Name",
                        hintText: "Enter a name",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Text("Trip Description (Optional)"),
                    ),
                    TextField(
                      controller: controller.tripDescriptionController,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.drive_file_rename_outline),
                        prefixIconColor: AppColors.primaryColor,
                        fillColor: AppColors.white,
                        // labelText: "Medicine Name",
                        hintText: "Enter a description",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Text("Trip Date"),
                    ),
                    TextField(
                      controller: controller.tripDateController,
                      readOnly: true,
                      style: TextStyle(color: AppColors.black, fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Starting Day",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                        ),
                        labelStyle: TextStyle(
                          color: AppColors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_today,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.primaryColor,
                                  onPrimary: Colors.white,
                                  surface: Colors.white,
                                  onSurface: Colors.black,
                                ),
                                dialogTheme: DialogThemeData(
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (picked != null) {
                          String formattedDate = DateFormat(
                            'd MMM, yyyy',
                          ).format(picked);
                          controller.tripDateController.text = formattedDate;
                        }
                      },
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Card(
              color: AppColors.white,
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),
                            child: Text("Trip Members"),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showAddPersonDialog(context);
                          },
                          icon: Icon(Icons.add, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.memberList.length,
                        itemBuilder: (context, position) {
                          var member = controller.memberList[position];

                          return ListTile(
                            title: Text(member.name),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                height: 36,
                                width: 36,
                                color:
                                    Colors.primaries[member.name.hashCode %
                                        Colors
                                            .primaries
                                            .length], // random color
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(onPressed: () {
                controller.createNewTrip().then((trip) {
                  Get.back(result: trip);
                });
              }, style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: AppColors.white,
                minimumSize: Size(double.maxFinite, 40),
              ), child: Text("Create Trip"),),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showAddPersonDialog(BuildContext context) async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text("Add New Member"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Member Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Deposit Amount (Optional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1.0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: AppColors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final amount =
                    double.tryParse(amountController.text.trim()) ?? 0;

                if (name.isEmpty) return;

                controller.addNewMember(
                  Person(
                    id: Uuid().v4(),
                    name: name,
                    isAdmin: false,
                    deposit: amount,
                  ),
                );

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: AppColors.white,
              ),
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
