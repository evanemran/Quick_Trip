import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:quick_trip/controllers/add_trip_controller.dart';
import 'package:quick_trip/controllers/splash_controller.dart';
import 'package:quick_trip/controllers/trip_details_controller.dart';

class TripDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripDetailsController>(() => TripDetailsController());
  }
}