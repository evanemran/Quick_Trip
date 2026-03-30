import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quick_trip/app_routes.dart';
import 'package:quick_trip/models/trip_model.dart';

class TotalController extends GetxController {

  late TripModel trip;

  @override
  void onInit() {
    super.onInit();
    trip = Get.arguments;
  }

}