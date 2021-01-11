import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/controller/home_controller.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/DraftLeadListScreen.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';
import 'package:flutter_tech_sales/widgets/test.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController _homeController = Get.find();
  SplashController _splashController = Get.find();

  List<MenuDetailsModel> list = [
    new MenuDetailsModel("Leads", "assets/images/img2.png"),
    new MenuDetailsModel("Sites", "assets/images/img3.png"),
    new MenuDetailsModel("Influencers", "assets/images/img4.png"),
    new MenuDetailsModel("My Team", "assets/images/img1.png"),
    new MenuDetailsModel("MWP", "assets/images/img1.png"),
    new MenuDetailsModel("Service\nRequests", "assets/images/img1.png")
  ];

  String employeeName = "empty";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      _homeController.employeeName =
          prefs.getString(StringConstants.employeeName);
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
                      GestureDetector(
                        onTap: () {
                          Get.dialog(CustomDialogs()
                              .errorDialog("Page Coming Soon .... "));
                        },
                        child: Container(
                          height: 40,
                          width: 40,
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
                              fontSize: 24,
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
                Obx(() =>
                    (_homeController.checkInStatus == StringConstants.checkIn)
                        ? checkInSliderButton()
                        : (_homeController.checkInStatus ==
                                StringConstants.checkOut)
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
                    // gv.fromLead = false;
                    // Get.toNamed(Routes.ADD_LEADS_SCREEN);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Test()
                    ));

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
                                    builder: (BuildContext context) =>
                                        DraftLeadListScreen()));
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
              switch (index) {
                case 0:
                  Get.toNamed(Routes.LEADS_SCREEN);
                  break;
                case 1:
                  Get.toNamed(Routes.SITES_SCREEN);
                  break;
                case 2:
                case 3:
                  Get.dialog(
                      CustomDialogs().errorDialog(" Page Coming Soon .... "));
                  break;
                case 4:
                  Get.toNamed(Routes.ADD_MWP_SCREEN);
                  break;
                case 5:
                  Get.toNamed(Routes.SERVICE_REQUESTS);
                  break;
              }
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              borderOnForeground: true,
              //shadowColor: colornew,
              elevation: 20,
              margin: EdgeInsets.all(10.0),
              color:
                  ((index == 0) || (index == 1) || (index == 4) || (index == 5))
                      ? Colors.white
                      : Colors.white60,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index].value,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.bold
                                  //fontWeight: FontWeight.normal
                                  ),
                            ),
                            (index == 2 || index == 3)
                                ? Text(
                                    "Coming Soon",
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: ColorConstants.inputBoxHintColor,
                                        fontSize: 12,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.bold
                                        //fontWeight: FontWeight.normal
                                        ),
                                  )
                                : Container(),
                          ],
                        )
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

class MenuDetailsModel {
  String value;
  String imgURL;

  MenuDetailsModel(this.value, this.imgURL);
}
