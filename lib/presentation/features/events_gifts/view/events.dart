import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/controller/all_events_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/all_events.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/approved_events.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/widgets/events_filter.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';


class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  String empID;
  int _tabNumber = 0;
AllEventController _eventController=Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(Routes.HOME_SCREEN);
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "EVENTS",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: "Muli"),
                  ),
                  _tabNumber==0?Container(): Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        onPressed: () {
                           _settingModalBottomSheet(context);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.white)),
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              //  Icon(Icons.exposure_zero_outlined),
                              Container(
                                  height: 18,
                                  width: 18,
                                  // margin: EdgeInsets.only(top: 40, left: 40, right: 40),
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 0.0),
                                    borderRadius:
                                        new BorderRadius.all(Radius.circular(3)),
                                  ),
                                  child: Center(
                                      child:
                                      Obx(() =>
                                          Text(
                                          "${_eventController.selectedFilterCount}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              //fontFamily: 'Raleway',
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal))
                                      )
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'FILTER',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  FlatButton(
                    onPressed: () {
//                      Get.to(()=>GiftsView(), binding: GiftsBinding());
                      Get.toNamed(Routes.GIFTS_VIEW);

                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white)),
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Container(
                              height: 18,
                              width: 18,
                              decoration: new BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.0),
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(3)),
                              ),
                              child: Center(
                                  child:Icon(Icons.card_giftcard, color: Colors.orange,)
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'GIFTS',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
//            centerTitle: true,

              backgroundColor: ColorConstants.appBarColor,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Container(
                  color: ColorConstants.appBarColor,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(
                            text: "APPROVED",
                          ),
                          Tab(
                            text: "ALL",
                          ),
                        ],
                        indicatorColor: Colors.white,
                        onTap: (i) {
                          setState(() {
                            _tabNumber = i;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton:
            SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigator(searchType: "event",),
            body: TabBarView(
              children: [
                ApprovedEvents(),
                AllEvents(),
              ],
            )),
        // ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return EventsFilterWidget();
        });
  }

//  @override
//  void dispose() {
//    _dashboardController.dispose();
//    super.dispose();
//  }
}
