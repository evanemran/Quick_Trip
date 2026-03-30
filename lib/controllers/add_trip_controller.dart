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

class AddTripController extends GetxController {

  var tripNameController = TextEditingController();
  var tripDescriptionController = TextEditingController();
  var tripDateController = TextEditingController();
  var tripCurrencyController = TextEditingController();

  var memberList = <Person>[].obs;

  void addNewMember(Person person) {
    memberList.add(person);
  }

  Future<TripModel?> createNewTrip() async {
    if(memberList.isNotEmpty && tripNameController.text.isNotEmpty && tripDateController.text.isNotEmpty) {
      final tripDetails = TripDetailModel(
          id: Uuid().v4(), members: memberList
      );

      final newTrip = TripModel(
          id: Uuid().v4(),
          name: tripNameController.text,
          date: tripDateController.text,
          budget: 0,
          image: "https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          tripDetailModel: tripDetails);

      await TripManager.saveTrip(newTrip);

      return newTrip;
    }
    else {
      return null;
    }
  }

}