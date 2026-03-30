import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl/intl.dart';
import 'package:quick_trip/controllers/add_expense_controller.dart';
import 'package:quick_trip/controllers/add_trip_controller.dart';
import 'package:quick_trip/models/trip_detail_model.dart';
import 'package:quick_trip/models/trip_model.dart';
import 'package:uuid/uuid.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';

class AddExpensePage extends GetView<AddExpenseController> {
  const AddExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppStrings.addExpense,
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
              margin: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Text("Description"),
                    ),
                    TextField(
                      controller: controller.expenseDescriptionController,
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
                      child: Text("Expense Category"),
                    ),
                    TextField(
                      controller: controller.expenseCategoryController,
                      readOnly: true, // 👈 important
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
                        hintText: "Select Description",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onTap: () async {
                        final selected = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            final items = [
                              "Food",
                              "Transport",
                              "Hotel",
                              "Shopping",
                              "Other",
                            ];

                            return AlertDialog(
                              backgroundColor: AppColors.white,
                              title: Text("Select Expense Type"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      horizontalTitleGap: 8,
                                      minLeadingWidth: 0,
                                      title: Text(items[index]),
                                      onTap: () {
                                        Navigator.pop(context, items[index]); // 👈 return value
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );

                        if (selected != null) {
                          controller.expenseCategoryController.text = selected;
                        }
                      },
                    ),
                    SizedBox(height: 8),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Row(
                        children: [
                          Expanded(child: Text("Expense Shared By All?")),
                          Obx(() => Checkbox(activeColor: AppColors.primaryColor, /*fillColor: WidgetStateProperty.all(AppColors.primaryColor)*/ checkColor: AppColors.white, value: controller.isExpenseSharedByAll.value, onChanged: (value) {
                            controller.isExpenseSharedByAll.value = value ?? false;
                          })),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Text("Trip Date"),
                    ),
                    TextField(
                      controller: controller.expenseDateController,
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
                          controller.expenseDateController.text = formattedDate;
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
              margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Text("Expense By"),
                    ),
                    TextField(
                      controller: controller.expenseByController,
                      readOnly: true, // 👈 important
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
                        hintText: "Select a Member",
                        hintStyle: TextStyle(
                          color: Colors.black26,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onTap: () async {
                        final selected = await showDialog<String>(
                          context: context,
                          builder: (context) {
                            final items = controller.trip.tripDetailModel.members.map((p) => p.name).toList();

                            return AlertDialog(
                              backgroundColor: AppColors.white,
                              title: Text("Select a Member"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      dense: true,
                                      horizontalTitleGap: 8,
                                      minLeadingWidth: 0,
                                      title: Text(items[index]),
                                      onTap: () {
                                        Navigator.pop(context, items[index]); // 👈 return value
                                      },
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );

                        if (selected != null) {
                          controller.expenseByController.text = selected;
                          ///ToDo
                          // controller.expensePerson =
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                      child: Text("Expense Amount"),
                    ),
                    TextField(
                      controller: controller.expenseAmountController,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.attach_money),
                        prefixIconColor: AppColors.primaryColor,
                        fillColor: AppColors.white,
                        hintText: "Enter Amount",
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(onPressed: () {
                controller.updateTrip().then((isUpdated) {
                  Get.back(result: isUpdated);
                });
              }, style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: AppColors.white,
                minimumSize: Size(double.maxFinite, 40),
              ), child: Text("Save Expense"),),
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

                // controller.addNewMember(
                //   Person(
                //     id: Uuid().v4(),
                //     name: name,
                //     isAdmin: false,
                //     deposit: amount,
                //   ),
                // );

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
