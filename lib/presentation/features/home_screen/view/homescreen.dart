import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/functions/convert_to_hex.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<menuDetailsModel> list = [
    new menuDetailsModel("Leads"),
    new menuDetailsModel("Sites"),
    new menuDetailsModel("Influencers"),
    new menuDetailsModel("My Team")
  ];

  String _status = "check_in";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#4973AB"),
        appBar: AppBar(
          // titleSpacing: 50,
          backgroundColor: HexColor("#22316C"),
          toolbarHeight: 100,
          centerTitle: false,
          title: Text(
            "Home",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 27, color: Colors.white),
          ),
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0, top: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("Notification");
                    },
                    child: Icon(
                      Icons.circle_notifications,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  Text(
                    "Notification",
                    style: TextStyle(color: Colors.white),
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
                        fontWeight: FontWeight.bold),
                  ),
                  Text("Here are today's",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 15,
                      )),
                  Text("recommended actions for you",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 15)),
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
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _status = "check_out";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.green,
                        child: Text("Check-in",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _status = "Journey_Ended";
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.red,
                        child: Text("Check-out",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    )
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
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
        ));
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
                      Icon(
                        Icons.no_photography_outlined,
                        size: 90,
                        color: Colors.black12,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        list[index].value,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Muli",
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

  menuDetailsModel(this.value);
}
