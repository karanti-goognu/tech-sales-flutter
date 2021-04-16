import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/helper/createDatabaseDB.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_tech_sales/utils/global.dart';

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
  SplashController _splashController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //below function will logout the user on app update
//    _splashController.checkAppVersion();


    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String isUserLoggedIn = prefs.getString(StringConstants.isUserLoggedIn) ?? "false";
      print('$isUserLoggedIn');
      if (isUserLoggedIn == "false") {
        Get.offNamed(Routes.LOGIN);
      } else {
        print("on splash_screen.dart");


        internetChecking().then((result){
          if(result)
            _splashController.getSecretKey(RequestIds.REFRESH_DATA);
          else{
            Future.delayed(const Duration(seconds: 3), () {
              _splashController.openNextPage();

            });

          }

        });

      }
    });
    _initializeFlutterFireFuture = _initializeFlutterFire();

    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(
        child: Container(
          margin: EdgeInsets.all(32),
          child: Image.asset(
            "assets/images/Logo(Whitebg).png",
            width: SizeConfig.blockSizeHorizontal,
            height: 160,
          ),
        ),
      ),
    );
  }

  Future<Database> initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'database.db');


    Database database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE draftLead (id INTEGER PRIMARY KEY AUTOINCREMENT, leadModel TEXT)');
          await db.execute('CREATE TABLE brandName (id INTEGER , brandName TEXT , productName TEXT)');
          await db.execute('CREATE TABLE counterListDealers (id TEXT, dealerName TEXT)');
          await db.execute('CREATE TABLE constructStage (id INTEGER PRIMARY KEY AUTOINCREMENT, constructStageEntity TEXT)');
          await db.execute('CREATE TABLE siteCompetitionStatus (id INTEGER PRIMARY KEY AUTOINCREMENT, siteCompetitionStatusEntity TEXT)');
          await db.execute('CREATE TABLE siteFloor (id INTEGER PRIMARY KEY AUTOINCREMENT, siteFloorEntity TEXT)');
          await db.execute('CREATE TABLE siteStage (id INTEGER PRIMARY KEY AUTOINCREMENT, siteStageEntity TEXT)');
          await db.execute('CREATE TABLE siteVisitHistory (id INTEGER PRIMARY KEY AUTOINCREMENT, siteVisitHistoryEntity TEXT)');
          await db.execute('CREATE TABLE siteList (id INTEGER PRIMARY KEY AUTOINCREMENT, siteId INTEGER, leadId INTEGER, siteSegment TEXT, assignedTo TEXT, siteStatusId INTEGER, siteOppertunityId INTEGER, siteStageId INTEGER, contactName TEXT, contactNumber TEXT, siteCreationDate TEXT, siteGeotag TEXT, siteGeotagLat TEXT, siteGeotagLong TEXT, sitePincode TEXT, siteState TEXT, siteDistrict TEXT, siteTaluk TEXT, siteScore DOUBLE, sitePotentialMt TEXT, reraNumber TEXT, dealerId TEXT, siteBuiltArea TEXT, noOfFloors INTEGER, productDemo TEXT, productOralBriefing TEXT, soCode TEXT, plotNumber TEXT, inactiveReasonText TEXT, nextVisitDate TEXT, closureReasonText TEXT, createdBy TEXT,  createdOn INTEGER, updatedBy TEXT, updatedOn INTEGER)');

        });
    return database;
  }
}
