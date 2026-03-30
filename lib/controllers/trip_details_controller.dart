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

class TripDetailsController extends GetxController {
  late TripModel trip;

  @override
  void onInit() {
    super.onInit();
    trip = Get.arguments;
  }

  void deleteTrip() {
    TripManager.deleteTrip(trip.id);
    Get.back(result: true);
  }
}