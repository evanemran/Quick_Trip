import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import 'package:quick_trip/db/trip_manager.dart';
import 'package:quick_trip/models/trip_model.dart';
import 'package:quick_trip/utils/app_toast.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {

  var tripList = <TripModel>[].obs;
  var selectedDrawerMenuIndex = 0.obs;

  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  void onInit() {
    super.onInit();
    loadAllTrips();
    // askPermissions(); // Will add Later
  }

  toggleDrawer() {
    zoomDrawerController.toggle!();
  }

  void loadAllTrips() async {
    final trips = await TripManager.getTrips();
    tripList.assignAll(trips);
    print("Total: ${trips.length}");
  }

  /*void askPermissions() async {
    final isNotificationGranted = await NotificationService.requestNotificationPermission();
    final isAlarmGranted = await NotificationService.requestExactAlarmPermission();

    if (isNotificationGranted && isAlarmGranted) {
      loadAllMedications();
    }
    else {
      AppToast.showToast("Permission Required!");
    }
  }*/
}