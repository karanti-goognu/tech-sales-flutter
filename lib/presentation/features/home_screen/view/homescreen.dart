import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/helper/siteListDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/dashboard.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/controller/home_controller.dart';
import 'package:flutter_tech_sales/presentation/features/notification/controller/notification_controller.dart';
import 'package:flutter_tech_sales/presentation/features/notification/model/moengage_inbox.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import 'package:moengage_flutter/push_campaign.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppController _appController = Get.find();
  HomeController _homeController = Get.find();
  SplashController _splashController = Get.find();
  SiteController _siteController = Get.find();
  // DashboardController _dashboardController =Get.find();


  List<MenuDetailsModel> list = [
    new MenuDetailsModel("Leads", "assets/images/img2.png"),
    new MenuDetailsModel("Sites", "assets/images/img3.png"),
    new MenuDetailsModel("Dashboard", "assets/images/img4.png"),
    new MenuDetailsModel("MWP", "assets/images/mwp.png"),
    new MenuDetailsModel("SR & Complaint", "assets/images/sr.png"),
    new MenuDetailsModel("Video Tutorial", "assets/images/tutorial.png"),
  ];

  final MoEngageFlutter _moengagePlugin = MoEngageFlutter();
  String employeeName = "empty";
  MoEngageInbox _moEngageInbox;
  int unReadMessageCount = 0;

  Future<int> unReadMessageCoun() async {
    int unReadMessageCount = await _moEngageInbox.getUnClickedCount();
    return unReadMessageCount;
  }



  Future<void> initPlatformState() async {
    if (!mounted) return;
    //Push.getTokenStream.listen(_onTokenEvent, onError: _onTokenError);
  }

  void _onPushClick(PushCampaign message) {
    print("This is a push click callback from native to flutter. Payload " +
        message.toString());
  }

  @override
  void initState() {
    print("homescreen.dart :::::: initState()");
    super.initState();
    initPlatformState();
    _moengagePlugin.initialise();
    _moengagePlugin.enableSDKLogs();
    _moengagePlugin.setUpPushCallbacks(_onPushClick);

    if (_splashController.splashDataModel.journeyDetails.journeyDate == null) {
      print('Check In');
      _homeController.checkInStatus = StringConstants.checkIn;
    } else {
      if (_splashController.splashDataModel.journeyDetails.journeyEndTime ==
          null) {
        print('Check Out');
        _homeController.checkInStatus = StringConstants.checkOut;
      } else {
        print('Journey Ended');
        _homeController.checkInStatus = StringConstants.journeyEnded;
      }
    }
//    _homeController.getAccessKey(RequestIds.HOME_DASHBOARD);

    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      _homeController.employeeName =
          prefs.getString(StringConstants.employeeName);

      // MoEngage implementation done here ....
      _moengagePlugin.setUniqueId(prefs.getString(StringConstants.employeeId));
      _moengagePlugin
          .setFirstName(prefs.getString(StringConstants.employeeName));
      _moengagePlugin
          .setPhoneNumber(prefs.getString(StringConstants.mobileNumber));
    });

    _moEngageInbox = MoEngageInbox();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
      unReadMessageCoun().then((value) => {
        setState(() {
          unReadMessageCount = value;
        }),
      })
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("homescreen.dart :::::: dispose()");
    super.dispose();
    // _homeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // You can do some work here.
        // Returning true allows the pop to happen, returning false prevents it.
        Get.dialog(CustomDialogs().appExitDialog("Do you want to exit?"));
        return true;
      },
      child: Scaffold(
          backgroundColor: ColorConstants.backgroundColorGrey,
          appBar: AppBar(
            // titleSpacing: 50,
            backgroundColor: ColorConstants.appBarColor,
            toolbarHeight: 100,
            title: Image.asset(
              "assets/images/Logo(Bluebg).png",
              height: 48,
            ),
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 25.0, top: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ADD_CALENDER_SCREEN);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(4),
                        // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 0.0),
                          borderRadius:
                          new BorderRadius.all(Radius.circular(70)),
                        ),
                        child: Icon(
                          Icons.calendar_today_sharp,
                          color: HexColor("#FFCD00"),
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "My Calendar",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25.0, top: 20),
                child: Column(
                  children: [
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 0.0, right: 3),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.NOTIFICATION);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                border:
                                Border.all(color: Colors.black, width: 0.0),
                                borderRadius:
                                new BorderRadius.all(Radius.circular(70)),
                              ),
                              child: Icon(
                                Icons.notifications_none_outlined,
                                color: HexColor("#FFCD00"),
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 10,
                          child: Container(
                            height: 17,
                            width: 17,
                            decoration: new BoxDecoration(
                              color: Colors.redAccent,
                              border:
                              Border.all(color: Colors.redAccent, width: 0.0),
                              borderRadius:
                              new BorderRadius.all(Radius.circular(70)),
                            ),
                            child: Text(
                              (unReadMessageCount >= 0
                                  ? unReadMessageCount.toString()
                                  : ""),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Notifications",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 25.0, top: 20),
              //   child: Column(
              //     children: [
              //       GestureDetector(
              //         onTap: () async {
              //           _appController.getAccessKey(RequestIds.GET_SITES_LIST);
              //           storeOfflineSiteData();
              //         },
              //         child: Container(
              //           height: 40,
              //           width: 40,
              //           // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
              //           decoration: new BoxDecoration(
              //             color: Colors.white,
              //             border: Border.all(color: Colors.black, width: 0.0),
              //             borderRadius:
              //                 new BorderRadius.all(Radius.circular(70)),
              //           ),
              //           child: Icon(
              //             Icons.sync,
              //             color: HexColor("#FFCD00"),
              //             size: 30,
              //           ),
              //         ),
              //       ),
              //
              //       SizedBox(
              //         height: 8,
              //       ),
              //
              //       Text(
              //         "Sync Data",
              //         style: TextStyle(color: Colors.white, fontSize: 12),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10.0, top: 20, bottom: 10),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     // mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Obx(
                  //         () => Text(
                  //           "Hello , ${_homeController.employeeName}",
                  //           style: TextStyle(
                  //               // color: Colors.white,
                  //               fontSize: 24,
                  //               fontWeight: FontWeight.normal,
                  //               fontFamily: "Muli"),
                  //         ),
                  //       ),
                  //       Text("Here are today's",
                  //           textAlign: TextAlign.start,
                  //           style: TextStyle(
                  //               //  color: Colors.white.withOpacity(0.7),
                  //               fontSize: 15,
                  //               fontFamily: "Muli")),
                  //       Text("recommended actions for you",
                  //           style: TextStyle(
                  //               // color: Colors.white.withOpacity(0.7),
                  //               fontSize: 15,
                  //               fontFamily: "Muli")),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),

                  Obx(() {
                    if (_homeController.disableSlider != true) {
                      return (_homeController.checkInStatus ==
                          StringConstants.checkIn)
                          ? checkInSliderButton()
                          : (_homeController.checkInStatus ==
                          StringConstants.checkOut)
                          ? checkOutSliderButton()
                          : journeyEnded();
                    } else {
                      return disabledSliderButton();
                    }
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    borderOnForeground: true,
                    //shadowColor: colornew,
                    elevation: 20,
                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                    color: Colors.white,
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/desktop.svg',
                                color: Color(0xfff9a61a),
                                width: 30,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Key Metrics',
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Icon(
                                Icons.info_outline_rounded,
                                color: Color(0xfff9a61a),
                                size: 20,
                              ),
                            ],
                          ),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width - 24,
                            child: GridView.count(
                              shrinkWrap: true,
                              // itemCount: 4,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              // gridDelegate:
                              //     SliverGridDelegateWithFixedCrossAxisCount(

                              childAspectRatio: 3.4,
                              // ),
                              //   new HomeScreenDashboardModel("New Influencers", _homeController.newInfl),
                              //   new HomeScreenDashboardModel("DSP Slabs Converted", _homeController.dspSlabsConverted),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    // color: Colors.red,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 4),
                                          padding: const EdgeInsets.all(6.0),
                                          child:

                                          Obx(()=>Text(
                                            _homeController.sitesConverted,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: HexColor('39B54A'),
                                                  width: 1.6),
                                              shape: BoxShape.circle),
                                        ),
                                        Flexible(child: Text('Sites converted'))
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    // color: Colors.red,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 4),
                                          padding: const EdgeInsets.all(6.0),
                                          child:
                                          Obx(()=>Text(
                                            _homeController.volumeConverted,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: HexColor('39B54A'),
                                                  width: 1.6),
                                              shape: BoxShape.circle),
                                        ),
                                        Flexible(
                                            child: Text('Volume Converted (MT)'))
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    // color: Colors.red,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 4),
                                          padding: const EdgeInsets.all(6.0),
                                          child:
                                          Obx(()=> Text(
                                            _homeController.newInfl,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: HexColor('39B54A'),
                                                  width: 1.6),
                                              shape: BoxShape.circle),
                                        ),
                                        Flexible(
                                            child: Text('New Influencers'))
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    // color: Colors.red,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 4),
                                          padding: const EdgeInsets.all(6.0),
                                          child:
                                          Obx(()=>Text(
                                            _homeController.dspSlabsConverted,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: HexColor('39B54A'),
                                                  width: 1.6),
                                              shape: BoxShape.circle),
                                        ),
                                        Flexible(
                                            child: Text('DSP Slabs Converted'))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: userMenuWidget(),
                      ))
                ],
              ),

              Positioned(
                right: -10,
                top: 30,
                child:
                UrlConstants.baseUrl.contains('mobileqacloud')?
                Chip(
                  backgroundColor: ColorConstants.appBarColor,
                  label: Text('QA     ', style: TextStyle(color: Colors.white),),
                ):
                UrlConstants.baseUrl.contains('mobiledevcloud')?
                Chip(
                  backgroundColor: ColorConstants.appBarColor,
                  label: Text('Dev     ', style: TextStyle(color: Colors.white),),
                ):Container(),
              ),
            ],
          ),
          floatingActionButton:
          SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigator()),
    );
  }

  Widget disabledSliderButton() {
    return SliderButton(
      ///Put label over here
      label: Text(
        "Disabled ",
        style: TextStyle(
            color: Color(0xff4a4a4a),
            fontWeight: FontWeight.w500,
            fontSize: 17),
      ),
      icon: Center(
          child: Icon(
            Icons.play_disabled,
            color: Colors.white,
            size: 40.0,
            //  semanticLabel: 'Text to announce in accessibility modes',
          )),

      ///Change All the color and size from here.
      alignLabel: Alignment.center,
      width: MediaQuery.of(context).size.width,
      radius: 10,
      buttonColor: ColorConstants.buttonDisableColor,
      backgroundColor: ColorConstants.buttonDisableColor,
      highlightedColor: Colors.grey,
      baseColor: Colors.white,
      vibrationFlag: true,

      dismissible: false, action: null,
    );
  }

  Widget checkInSliderButton() {
    return SliderButton(

      action: () async {
        if (await Permission.location.request().isGranted) {
          _homeController.getAccessKey(RequestIds.CHECK_IN);
        } else {
          print('permission denied');
        }
      },
      ///Put label over here
      label: Text(
        "Swipe to start your day ",
        style: TextStyle(
            color: Color(0xff4a4a4a),
            fontWeight: FontWeight.w500,
            fontSize: 17),
      ),
      icon: Center(
          child: Icon(
            Icons.play_circle_filled_outlined,
            color: Colors.white,
            size: 40.0,
            //  semanticLabel: 'Text to announce in accessibility modes',
          )),

      ///Change All the color and size from here.
      alignLabel: Alignment.center,
      width: MediaQuery.of(context).size.width,
      radius: 10,
      buttonColor: ColorConstants.checkinColor,
      backgroundColor: ColorConstants.checkinColor,
      highlightedColor: Colors.grey,
      baseColor: Colors.white,
      vibrationFlag: true,
      dismissible: false,
    );
  }

  Widget checkOutSliderButton() {
    return SliderButton(
      action: () async {
        if (await Permission.location.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          _homeController.getAccessKey(RequestIds.CHECK_OUT);
        } else {
          print('permission not granted');
        }

        ///Do something here OnSlide
      },

      ///Put label over here
      label: Text(
        "Slide to Check-Out!",
        style: TextStyle(
            color: Color(0xff4a4a4a),
            fontWeight: FontWeight.w500,
            fontSize: 17),
      ),
      icon: Center(
          child: Icon(
            Icons.arrow_forward_outlined,
            color: Colors.white,
            size: 40.0,
            //  semanticLabel: 'Text to announce in accessibility modes',
          )),

      ///Change All the color and size from here.
      alignLabel: Alignment.center,
      width: MediaQuery.of(context).size.width,
      radius: 10,
      buttonColor: HexColor("#F9A61A"),
      backgroundColor: HexColor("#F9A61A"),
      highlightedColor: Colors.grey,
      baseColor: Colors.white,
      vibrationFlag: true,
      dismissible: false,
    );
  }

  Widget journeyEnded() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 70,
        alignment: Alignment.center,
        color: Colors.grey,
        child: Text("Journey-Ended",
            style: TextStyle(
                color: Colors.white, fontFamily: "Muli", fontSize: 18)),
      ),
    );
  }

  Widget userMenuWidget() {
    return GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 2),
        // itemExtent: 125.0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              switch (index) {
                case 0:
                  Get.toNamed(Routes.LEADS_SCREEN);
                  break;
                case 1:
                // storeOfflineSiteData();
                  Get.toNamed(Routes.SITES_SCREEN);
                  break;
                case 2:
                  Get.toNamed(Routes.DASHBOARD);
                  break;
                case 3:
                  Get.toNamed(Routes.ADD_MWP_SCREEN);
                  break;
                case 4:
                  Get.toNamed(Routes.SERVICE_REQUESTS);
                  break;
                case 5:
                  Get.toNamed(Routes.VIDEO_TUTORIAL);
                  break;
              }
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              elevation: 20,
              margin: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        list[index].imgURL,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Flexible(
                      child: Text(
                        list[index].value,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class MenuDetailsModel {
  String value;
  String imgURL;

  MenuDetailsModel(this.value, this.imgURL);
}

class HomeScreenDashboardModel {
  String text;
  String value;

  HomeScreenDashboardModel(this.text, this.value);
}
