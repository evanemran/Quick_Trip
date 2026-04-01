import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:quick_trip/controllers/total_controller.dart';

import '../models/trip_detail_model.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,8,8,0),
              child: Material(
                color: AppColors.white,
                elevation: 8,
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
                padding: EdgeInsets.fromLTRB(8,0,8,8),

              child: FutureBuilder<List<Expense>>(
                future: controller.getExpensesList(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Something went wrong"));
                  }

                  final expenses = snapshot.data ?? [];

                  if (expenses.isEmpty) {
                    return Center(child: Text("No expenses found"));
                  }

                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, position) {
                        var expense = expenses[position];
                        return Material(
                          elevation: 8,
                          color: AppColors.white,
                          child: ListTile(
                            title: Text(expense.description),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(expense.date),
                                Text("Category: ${expense.category}"),
                                Text("Expense By: "),
                                Text("Shared By: ${expense.sharedMembers}"),
                              ],
                            ),
                            trailing: Text(expense.expenseAmount.toStringAsFixed(2)),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 1, thickness: 1,); // separator widget
                      },
                      itemCount: expenses.length
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }
}
