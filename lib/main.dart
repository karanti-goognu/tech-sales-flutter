import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/bindings/splash_binding.dart';
import 'package:flutter_tech_sales/core/services/connectivity_service.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/enums/connectivity_status.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'utils/constants/app_theme.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
        builder: (context) => ConnectivityService().connectionStatusController,
        child: new GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: SplashBinding(),
          initialRoute: Routes.INITIAL,
          defaultTransition: Transition.fade,
          getPages: AppPages.pages,
          home: SplashScreen(),
          title: 'TSO App',
          theme: appThemeData,
        ));
  }
}
