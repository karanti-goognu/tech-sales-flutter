import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/app_shared_preference.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenPageState();
  }
}

// Toggle this to cause an async error to be thrown during initialization
// and to test that runZonedGuarded() catches the error
final _kShouldTestAsyncErrorOnInit = false;

// Toggle this for testing Crashlytics in your app locally.
final _kTestingCrashlytics = true;

Future<void> _initializeFlutterFireFuture;

Future<void> _testAsyncErrorOnInit() async {
  Future<void>.delayed(const Duration(seconds: 2), () {
    final List<int> list = <int>[];
    print(list[100]);
  });
}

// Define an async function to initialize FlutterFire
Future<void> _initializeFlutterFire() async {
  // Wait for Firebase to initialize
  await Firebase.initializeApp();

  if (_kTestingCrashlytics) {
    // Force enable crashlytics collection enabled if we're testing it.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    // Else only enable it in non-debug builds.
    // You could additionally extend this to allow users to opt-in.
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  // Pass all uncaught errors to Crashlytics.
  Function originalOnError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    // Forward to original handler.
    originalOnError(errorDetails);
  };

  if (_kShouldTestAsyncErrorOnInit) {
    await _testAsyncErrorOnInit();
  }
}

class SplashScreenPageState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeFlutterFireFuture = _initializeFlutterFire();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String isUserLoggedIn =
          prefs.getString(StringConstants.isUserLoggedIn) ?? "false";
      print('$isUserLoggedIn');
      (isUserLoggedIn == "false")
          ? Get.offNamed(Routes.LOGIN)
          : Get.offNamed(Routes.HOME_SCREEN);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Container(
          child: Center(
              child: Text(
        "TSO App",
        style: TextStyle(
            color: ColorConstants.blackColor,
            fontSize: 32,
            fontFamily: "Raleway"),
      ))),
    );
  }
}
