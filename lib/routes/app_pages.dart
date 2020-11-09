
import 'package:flutter_tech_sales/bindings/login_binding.dart';
import 'package:flutter_tech_sales/bindings/splash_binding.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/view/homescreen.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/leadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login_otp_screen.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:get/get.dart';
part './app_routes.dart';


class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page:()=> SplashScreen(),binding: SplashBinding()),
    GetPage(name: Routes.LOGIN, page:()=> LoginScreen(),binding: LoginBinding()),
    GetPage(name: Routes.HOME_SCREEN, page:()=> HomeScreen()),
    GetPage(name: Routes.VERIFY_OTP, page:()=> LoginOtpScreen(), binding: LoginBinding()),
    GetPage(name: Routes.LEADS_SCREEN, page:()=> LeadScreen()),
  ];
}
