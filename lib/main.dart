import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/bindings/splash_binding.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:get/get.dart';
//import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'helper/database/sitelist_db_helper.dart';
import 'utils/constants/app_theme.dart';

void main() async {
  runZonedGuarded(() {
    runApp(MyApp());
    WidgetsFlutterBinding.ensureInitialized();
  }, (error, stackTrace) {
  //  print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  SitesDBProvider appModel = SitesDBProvider();
 // final MoEngageFlutter _moengagePlugin = MoEngageFlutter();

  Future<void> initPlatformState() async {
    if (!mounted) return;
    //Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    //_moengagePlugin.initialise();
    //_moengagePlugin.enableSDKLogs();
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModel<SitesDBProvider>(
        model: appModel,
        child:GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: SplashBinding(),
      initialRoute: Routes.INITIAL,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      home: SplashScreen(),
      title: 'TSO App',
      theme: appThemeData,
        )
    );
  }
}
