import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quick_trip/app_routes.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    Get.offNamed(AppRoutes.homePage);
  }

  @override
  void onInit() {
    super.onInit();
    Get.offNamed(AppRoutes.homePage);
  }

  @override
  void onClose() {
    super.onClose();
  }

}