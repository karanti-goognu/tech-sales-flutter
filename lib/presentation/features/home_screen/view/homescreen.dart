import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/controller/home_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/DraftLeadListScreen.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/leadScreen.dart';
import 'package:flutter_tech_sales/presentation/features/login/controller/login_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart' as splashModel;
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/app_shared_preference.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  HomeController _homeController = Get.find();
  LoginController _loginController = Get.find();
  SplashController _splashController = Get.find();

  List<menuDetailsModel> list = [
    new menuDetailsModel("Leads", "assets/images/img2.png"),
    new menuDetailsModel("Sites", "assets/images/img3.png"),
    new menuDetailsModel("Influencers", "assets/images/img4.png"),
    new menuDetailsModel("My Team", "assets/images/img1.png"),
    new menuDetailsModel("My Plan", "assets/images/img1.png"),
    new menuDetailsModel("Service ", "assets/images/img1.png")
  ];

  String _status = StringConstants.checkIn;

  String employeeName = "empty";

  //Login Otp Response :: {"user-security-key":"eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJFTVAwMDAxMjM0IiwibW9iaWxlTnVtYmVyIjoiODg2MDA4MDA2NyIsImV4cCI6MTYwNTE5ODI1MywiaWF0IjoxNjA1MTk2NDUzLCJyZWZlcmVuY2VJZCI6IkVNUDAwMDEyMzQifQ.D14bPNxOQ6g5zbxsHaUVv6RNz0jdUTj_HoHtwS9f3ZuiDlDMnhjILrKfwQTrjFRqiiZMB-yQKJ8v6OVbClaaXQ",
  // "resp-code":"DM1011","resp-msg":"Request completed successfully",
  // "employee-details":{"reference-id":"EMP0001234","mobile-number":"8860080067","employee-name":"ANIL","employee-first-name":"ANIL"},
  // "user-menu":[{"menu-id":1,"menu-text":"LEADS"},{"menu-id":2,"menu-text":"SITES"},{"menu-id":3,"menu-text":"INFLUENCERS"},{"menu-id":4,"menu-text":"MY TEAM"},{"menu-id":5,"menu-text":"JOURNEY"}],
  // "journey-details":{"journey-date":null,"journey-start-time":null,"journey-start-lat":null,"journey-start-long":null,"journey-end-time":null,"journey-end-lat":null,"journey-end-long":null,"employee-id":null}}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (_loginController != null) {
      if (_loginController.validateOtpResponse != null) {
        if (_loginController.validateOtpResponse.journeyDetails != null) {
          _splashController.splashDataModel.journeyDetails =
              _loginController.validateOtpResponse.journeyDetails ;
        } else {
          print('Journey Details in validate is null');
        }
      } else {
        print('Validate Otp response is null');
      }
    } else {
      print('Login Controller is null');
    }
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      _homeController.employeeName =
          prefs.getString(StringConstants.employeeName);
      _status = prefs.getString(StringConstants.checkInStatus);
      print('Status is :: $_status');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _homeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Status is :: $_status');
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
              centerTitle: false,
              title: Text(
                "Home",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 34,
                    color: Colors.white,
                    fontFamily: "Muli"),
              ),
              automaticallyImplyLeading: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 25.0, top: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print("Notification");
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 0.0),
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
                      Text(
                        "Notification",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )
                    ],
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          "Hello , ${_homeController.employeeName}",
                          style: TextStyle(
                              // color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Muli"),
                        ),
                      ),
                      Text("Here are today's",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              //  color: Colors.white.withOpacity(0.7),
                              fontSize: 15,
                              fontFamily: "Muli")),
                      Text("recommended actions for you",
                          style: TextStyle(
                              // color: Colors.white.withOpacity(0.7),
                              fontSize: 15,
                              fontFamily: "Muli")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(() => (_splashController
                            .splashDataModel.journeyDetails.journeyDate ==
                        null)
                    ? checkInSliderButton()
                    : (_splashController.splashDataModel.journeyDetails
                                .journeyEndTime ==
                            null)
                        ? checkOutSliderButton()
                        : journeyEnded()),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: userMenuWidget(),
                ))
              ],
            ),
            floatingActionButton: Container(
              height: 68.0,
              width: 68.0,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    gv.fromLead=false;
                    Get.toNamed(Routes.ADD_LEADS_SCREEN);
                  },
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              color: ColorConstants.appBarColor,
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            setState(() {
                              // currentScreen =
                              //     Dashboard(); // if user taps on this dashboard tab will be active
                              // currentTab = 0;
                              Get.toNamed(Routes.HOME_SCREEN);
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.white60,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Right Tab bar icons

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            Navigator.push(
                                context,
                                new CupertinoPageRoute(
                                    builder: (BuildContext context) => DraftLeadListScreen()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.drafts,
                                color: Colors.white60,
                              ),
                              Text(
                                'Drafts',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          minWidth: 40,
                          onPressed: () {
                            Get.toNamed(Routes.SEARCH_SCREEN);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.search,
                                color: Colors.white60,
                              ),
                              Text(
                                'Search',
                                style: TextStyle(
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  Widget checkInSliderButton() {
    return SliderButton(
      action: () {
        /*setState(() {
          _status = StringConstants.checkOut;
          _prefs.then((SharedPreferences prefs) {
            prefs.setString(
                StringConstants.checkInStatus, StringConstants.checkOut);
          });
        });*/
        _homeController.getAccessKey(RequestIds.CHECK_IN);
      },

      ///Put label over here
      label: Text(
        "Slide to Check-In !",
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
      action: () {
        /*setState(() {
          _status = StringConstants.journeyEnded;
          _prefs.then((SharedPreferences prefs) {
            prefs.setString(
                StringConstants.checkInStatus, StringConstants.journeyEnded);
          });
        });*/
        _homeController.getAccessKey(RequestIds.CHECK_OUT);

        ///Do something here OnSlide
      },

      ///Put label over here
      label: Text(
        "Slide to Check-Out !",
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
      onTap: () {
        /*setState(() {
          _status = StringConstants.checkIn;
          _prefs.then((SharedPreferences prefs) {
            prefs.setString(
                StringConstants.checkInStatus, StringConstants.checkIn);
          });
        });*/
      },
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
        // childAspectRatio: ( 2),
        //  padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.9,
            crossAxisSpacing: 1,
            mainAxisSpacing: 2),
        // itemExtent: 125.0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(list[index].value + " Page");
              if (list[index].value == "Leads") {
                Get.toNamed(Routes.LEADS_SCREEN);
              }
              if (list[index].value == "Sites") {
                Get.toNamed(Routes.SITES_SCREEN);
              }
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              //shadowColor: colornew,
              elevation: 20,
              margin: EdgeInsets.all(10.0),
              color: Colors.white,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          // height: 60,
                          //                         // width: 60,
                          margin: EdgeInsets.only(left: 10),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            // border: Border.all(color: Colors.black, width: 0.0),
                            // borderRadius: new BorderRadius.all(Radius.circular(70)),
                          ),
                          child: Image.asset(
                            list[index].imgURL,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        // Icon(
                        //   Icons.no_photography_outlined,
                        //   size: 90,
                        //   color: Colors.black12,
                        // ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          list[index].value,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.bold
                              //fontWeight: FontWeight.normal
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class menuDetailsModel {
  String value;
  String imgURL;

  menuDetailsModel(this.value, this.imgURL);
}
