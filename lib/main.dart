import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/bindings/splash_binding.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/DraftLeadListScreen.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/view/view_site_detail_screen.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:get/get.dart';

import 'utils/constants/app_theme.dart';

void main() async {
  runZonedGuarded(() {
    runApp(MyApp());
    WidgetsFlutterBinding.ensureInitialized();
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: SplashBinding(),
      initialRoute: Routes.INITIAL,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      home: SplashScreen(),
      title: 'TSO App',
      theme: appThemeData,
    );
  }
}
