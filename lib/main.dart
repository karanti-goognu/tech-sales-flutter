import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/bindings/splash_binding.dart';
import 'package:flutter_tech_sales/presentation/features/splash/view/splash_screen.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/routes/notification_routes.dart';
import 'package:flutter_tech_sales/utils/constants/moengage_util.dart';
import 'package:get/get.dart';
import 'package:moengage_flutter/inapp_campaign.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/push_campaign.dart';
import 'package:moengage_flutter/push_token.dart';
import 'utils/constants/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  final MoEngageFlutter _moengagePlugin = MoEngageFlutter();
  /* _moengagePlugin.setUpPushCallbacks((pushCampaign) {
      });*/
  _moengagePlugin.setUpPushCallbacks(_onPushClick);
  _moengagePlugin.enableSDKLogs();
  _moengagePlugin.initialise();
  _moengagePlugin.registerForPushNotification();

  runZonedGuarded(
        () {
      /** Kp Changes*/
      runApp(MyApp());
    },
        (error, stackTrace) {
      print('runZonedGuarded: Caught error in my root zone.');
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));

}

void _onPushClick(PushCampaign message) {
  print("This is a push click callback from native to flutter. Payload " +
      message.toString());
  Map<String, dynamic> payload = message.payload;
  String gcmWebUrl = payload["gcm_webUrl"];
  String gcmActivityName = payload["gcm_activityName"];
  print("_onPushClick   gcmWebUrl   $gcmWebUrl");
  if (gcmWebUrl != null) {
    String screenName= gcmWebUrl.split('/').last;
    print("_onPushClick   screenName   $screenName");
    handleDynamicLink(navigationScreenName:screenName,payloadData: payload);
  }
}

handleDynamicLink({String navigationScreenName, Map<String, dynamic>  payloadData}) {
  print("handleDynamicLink    $navigationScreenName");
  NotificationRoutes.navigateAfterResponse(screenName: navigationScreenName, payloadData: payloadData);

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MoEngageFlutter _moengagePlugin = MoEngageFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _moengagePlugin.setUpPushCallbacks(_onPushClick);
    _moengagePlugin.setUpInAppCallbacks(
        onInAppClick: _onInAppClick,
        onInAppShown: _onInAppShown,
        onInAppDismiss: _onInAppDismiss,
        onInAppCustomAction: _onInAppCustomAction,
        onInAppSelfHandle: _onInAppSelfHandle);
    _moengagePlugin.setUpPushTokenCallback(_onPushTokenGenerated);
  }

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

  /// Kp Changes*/

  Future<void> initPlatformState() async {
    if (!mounted) return;
    // Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
  }

void _onPushClick(PushCampaign message) {
  print(
      "Main : _onPushClick(): This is a push click callback from native to flutter. Payload " +
          message.toString());
}

void _onInAppClick(InAppCampaign message) {
  print(
      "Main : _onInAppClick() : This is a inapp click callback from native to flutter. Payload " +
          message.toString());
}

void _onInAppShown(InAppCampaign message) {
  print(
      "Main : _onInAppShown() : This is a callback on inapp shown from native to flutter. Payload " +
          message.toString());
}

void _onInAppDismiss(InAppCampaign message) {
  print(
      "Main : _onInAppDismiss() : This is a callback on inapp dismiss from native to flutter. Payload " +
          message.toString());
}

void _onInAppCustomAction(InAppCampaign message) {
  print(
      "Main : _onInAppCustomAction() : This is a callback on inapp custom action from native to flutter. Payload " +
          message.toString());
}

void _onInAppSelfHandle(InAppCampaign message) async {
  print(
      "Main : _onInAppSelfHandle() : This is a callback on inapp self handle from native to flutter. Payload " +
          message.toString());

  final SelfHandledActions action =
  await asyncSelfHandledDialog(context);
  switch (action) {
    case SelfHandledActions.Shown:
      _moengagePlugin.selfHandledShown(message);
      break;
    case SelfHandledActions.PrimaryClicked:
      _moengagePlugin.selfHandledPrimaryClicked(message);
      break;
    case SelfHandledActions.Clicked:
      _moengagePlugin.selfHandledClicked(message);
      break;
    case SelfHandledActions.Dismissed:
      _moengagePlugin.selfHandledDismissed(message);
      break;
  }
}

void _onPushTokenGenerated(PushToken pushToken) {
  print("Main : _onPushTokenGenerated() : This is callback on push token generated from native to flutter: PushToken: " +
          pushToken.toString());
}
}
