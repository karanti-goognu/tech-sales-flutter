import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/view/leadScreen.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_button/slider_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<menuDetailsModel> list = [
    new menuDetailsModel("Leads", "assets/images/img2.png"),
    new menuDetailsModel("Sites", "assets/images/img3.png"),
    new menuDetailsModel("Influencers", "assets/images/img4.png"),
    new menuDetailsModel("My Team", "assets/images/img1.png")
  ];

  String _status = "check_in";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey =prefs.getString(StringConstants.userSecurityKey);
      print('User Security Key :: $userSecurityKey');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          Get.dialog(CustomDialogs().errorDialog("Do uou want to exit?"));
          return true;
        },
        child: Scaffold(
            backgroundColor: ColorConstants.backgroundColorBlue,
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

                        // Icon(
                        //   Icons.circle_notifications,
                        //
                        //   color: Colors.white,
                        //   size: 50,
                        // ),
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
                      Text(
                        "Hello , Bhupinder",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                            fontFamily: "Muli"),
                      ),
                      Text("Here are today's",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 15,
                              fontFamily: "Muli")),
                      Text("recommended actions for you",
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 15,
                              fontFamily: "Muli")),
                    ],
                  ),
                ),
                Expanded(child: userMenuWidget())
                // ListView.builder(
                //     itemCount: list.length,
                //     padding: const EdgeInsets.only(top: 10.0),
                //     itemExtent: 25.0,
                //     itemBuilder: (context, index) {})
              ],
            ),
            bottomNavigationBar: Container(
              height: 60,
              width: 100,
              child: _status == "check_in" || _status == "check_out"
                  ? _status == "check_in"
                      ? SliderButton(
                          action: () {
                            setState(() {
                              _status = "check_out";
                            });

                            ///Do something here OnSlide
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
                        )
                      // GestureDetector(
                      //             onTap: () {
                      //               setState(() {
                      //                 _status = "check_out";
                      //               });
                      //             },
                      //             child: Container(
                      //               alignment: Alignment.center,
                      //               color: ColorConstants.checkinColor,
                      //               child: Text("CHECK-IN",
                      //                   style: TextStyle(
                      //                       color: Colors.white,
                      //                       fontFamily: "Muli",
                      //                       fontSize: 18)),
                      //             ),
                      //           )
                      : SliderButton(
                          action: () {
                            setState(() {
                              _status = "Journey_Ended";
                            });

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
                        )
                  // GestureDetector(
                  //             onTap: () {
                  //               setState(() {
                  //                 _status = "Journey_Ended";
                  //               });
                  //             },
                  //             child: Container(
                  //               alignment: Alignment.center,
                  //               color: Colors.red,
                  //               child: Text("CHECK-OUT",
                  //                   style: TextStyle(
                  //                       color: Colors.white,
                  //                       fontFamily: "Muli",
                  //                       fontSize: 18)),
                  //             ),
                  //           )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _status = "check_in";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey,
                        child: Text("Journey-Ended",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Muli",
                                fontSize: 18)),
                      ),
                    ),
            )));
  }

  Widget userMenuWidget() {
    return ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        itemExtent: 125.0,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            borderOnForeground: true,
            //shadowColor: colornew,
            elevation: 6,
            margin: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        margin: EdgeInsets.only(left: 10),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: Colors.black, width: 0.0),
                          // borderRadius: new BorderRadius.all(Radius.circular(70)),
                        ),
                        child: Image.asset(list[index].imgURL),
                      ),
                      // Icon(
                      //   Icons.no_photography_outlined,
                      //   size: 90,
                      //   color: Colors.black12,
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        list[index].value,
                        style: TextStyle(
                            fontSize: 25,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.bold
                            //fontWeight: FontWeight.normal
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      print(list[index].value + " Page");
                      if (list[index].value == "Leads") {
                        Navigator.push(
                            context,
                            new CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    LeadScreen()));
                      }
                    },
                    child: Icon(
                      Icons.navigate_next,
                      size: 30,
                    ),
                  ),
                )
              ],
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
