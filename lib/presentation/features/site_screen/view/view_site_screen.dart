import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';

class ViewSiteScreen extends StatefulWidget {
  @override
  _ViewSiteScreenState createState() => _ViewSiteScreenState();
}

class _ViewSiteScreenState extends State<ViewSiteScreen> {
  @override
  Widget build(BuildContext context) {
    //gv.selectedClass = widget.classroomId;
    return DefaultTabController(
        length: 4,

        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 180,

            title: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 210,
                    right: 0,
                    child: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/Container.png',
                              fit: BoxFit.fill,
                            ),
                          ],
                        ))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10, left: 5),
                          child: Text(
                            "Trade site details",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 25,
                                color: HexColor("#006838"),
                                fontFamily: "Muli"),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "ID: " + "XXXXX",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: "Muli",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:6.0,bottom: 8.0),
                                child: Text(
                                  "Site Score: " + "08",
                                  style: TextStyle(

                                    fontSize: 12,
                                    color: HexColor("#002A64"),
                                    fontFamily: "Muli",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            elevation: 0,
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                //  indicatorColor: Colors.black,
                labelColor: HexColor("#007CBF"),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: HexColor("#007CBF").withOpacity(0.1)),
                tabs: [
                  Tab(
                    text: "Site Data",
                  ),
                  Tab(
                    text: "Visit Data",
                  ),
                  Tab(
                    text: "Influencer",
                  ),
                  Tab(
                    text: "Past Stage History",
                  ),
                ]),
          ),
          body: TabBarView(
            children: <Widget>[
              siteDataView(),
              visitDataView(),
              influencerView(),
              pastStageHistoryview(),
            ],
          ),
          //child:Text("classroomName")
        ));
  }
}

Widget siteDataView() {
  return Container(
      child: Form(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[

                ],
              ))));
}

Widget visitDataView() {
  return Container(
    child: Text("visitDataView"),
  );
}

Widget influencerView() {
  return Container(
    child: Text("influencerView"),
  );
}

Widget pastStageHistoryview() {
  return Container(
    child: Text("pastStageHistoryview"),
  );
}
