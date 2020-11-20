import 'package:flutter_tech_sales/bindings/add_leads_binding.dart';
import 'package:flutter_tech_sales/bindings/home_binding.dart';
import 'package:flutter_tech_sales/bindings/leads__filter_binding.dart';
import 'package:flutter_tech_sales/bindings/login_binding.dart';
import 'package:flutter_tech_sales/bindings/search_binding.dart';
import 'package:flutter_tech_sales/bindings/splash_binding.dart';
import 'package:flutter_tech_sales/bindings/view_old_lead_binding.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/view/homescreen.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/AddNewLeadForm.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/ViewOldLeadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/leadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login_otp_screen.dart';
import 'package:flutter_tech_sales/presentation/features/search/view/search_screen.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:get/get.dart';

part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.INITIAL,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: Routes.SEARCH_SCREEN,
        page: () => SearchScreen(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: Routes.HOME_SCREEN,
        page: () => HomeScreen(),
        binding: HomeScreenBinding()),
    GetPage(
        name: Routes.VERIFY_OTP,
        page: () => LoginOtpScreen(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.LEADS_SCREEN,
        page: () => LeadScreen(),
        binding: LeadsFilterBinding()),
    GetPage(
        name: Routes.ADD_LEADS_SCREEN,
        page: () => AddNewLeadForm(),
        binding: AddLeadsBinding()),
    GetPage(
        name: Routes.VIEW_OLD_LEAD_SCREEN,
        page: () => ViewOldLeadScree(),
        binding: ViewOldLeadsBinding()),
  ];
}