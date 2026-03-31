import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quick_trip/app_routes.dart';
import 'package:quick_trip/db/trip_manager.dart';
import 'package:quick_trip/models/trip_detail_model.dart';
import 'package:quick_trip/models/trip_model.dart';
import 'package:uuid/uuid.dart';

class AddExpenseController extends GetxController {
  var expenseDescriptionController = TextEditingController();
  var expenseByController = TextEditingController();
  var expenseCategoryController = TextEditingController();
  var isExpenseSharedByAll = true.obs;
  var expenseDateController = TextEditingController();
  var expenseAmountController = TextEditingController();

  final args = Get.arguments;
  late TripModel trip;
  late Person expensePerson;

  @override
  void onInit() {
    super.onInit();
    trip = args["trip"] as TripModel;
    expensePerson = args["member"] as Person;
    expenseByController.text = expensePerson.name;
  }

  Future<bool> updateTrip() async {
    if (expenseDescriptionController.text.isNotEmpty &&
        expenseCategoryController.text.isNotEmpty &&
        expenseByController.text.isNotEmpty &&
        expenseAmountController.text.isNotEmpty) {
      final member = trip.tripDetailModel.members.firstWhere(
        (p) => p.id == expensePerson.id,
      );

      member.amountSpent += double.parse(expenseAmountController.text);
      member.amountShared += (double.parse(expenseAmountController.text)) / trip.tripDetailModel.members.length;
      member.dueOrRefund = (member.deposit + member.amountSpent) - member.amountShared;
      member.expenses.add(
        Expense(
          id: Uuid().v4(),
          description: expenseDescriptionController.text,
          category: expenseCategoryController.text,
          isSharedByAll: isExpenseSharedByAll.value,
          sharedMembers: [],
          date: expenseDateController.text,
          currency: "BDT",
          expenseAmount: double.parse(expenseAmountController.text),
        ),
      );

      TripManager.saveTrip(trip);
      return true;
    } else {
      return false;
    }
  }
}
