import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quick_trip/bindings/add_expense_binding.dart';
import 'package:quick_trip/bindings/add_trip_binding.dart';
import 'package:quick_trip/bindings/trip_details_binding.dart';
import 'package:quick_trip/pages/add_expense_page.dart';
import 'package:quick_trip/pages/add_trip_page.dart';
import 'package:quick_trip/pages/drawer_page.dart';
import 'package:quick_trip/pages/home_page.dart';
import 'package:quick_trip/pages/splash_page.dart';
import 'package:quick_trip/pages/trip_details_page.dart';

import 'bindings/home_binding.dart';
import 'bindings/splash_binding.dart';

class AppRoutes {
  static const String splashPage = '/splash_page';
  static const String logInPage = '/login_page';
  static const String homePage = '/home_page';
  static const String drawerPage = '/drawer_page';
  static const String addNewPage = '/add_new_page';
  static const String tripDetailsPage = '/trip_details_page';
  static const String addExpensePage = '/add_expense_page';


  static List<GetPage> pages = [
    GetPage(name: splashPage, page: () => SplashPage(), bindings: [SplashBinding()]),
    // GetPage(name: logInPage, page: () => LoginPage(), bindings: [LoginBinding()]),
    GetPage(name: homePage, page: () => HomePage(), bindings: [HomeBinding()]),
    GetPage(name: drawerPage, page: () => DrawerPage(), bindings: [HomeBinding()]),
    GetPage(name: addNewPage, page: () => AddTripPage(), bindings: [AddTripBinding()]),
    GetPage(name: tripDetailsPage, page: () => TripDetailsPage(), bindings: [TripDetailsBinding()]),
    GetPage(name: addExpensePage, page: () => AddExpensePage(), bindings: [AddExpenseBinding()]),
  ];
}