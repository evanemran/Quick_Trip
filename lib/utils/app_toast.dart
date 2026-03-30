import 'package:fluttertoast/fluttertoast.dart';
import 'package:quick_trip/utils/app_colors.dart';

class AppToast {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.backgroundColor,
      textColor: AppColors.black,
      fontSize: 14.0,
    );
  }
}