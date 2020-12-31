import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_calendar_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/model/TargetVSActualModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

class AddCalenderEventPage extends StatefulWidget {
  @override
  _AddCalenderEventPageState createState() => new _AddCalenderEventPageState();
}


class _AddCalenderEventPageState extends State<AddCalenderEventPage> {
  DateTime _currentDate = DateTime(2020, 8, 3);
  DateTime _currentDate2 = DateTime(2020, 8, 4);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2020, 8, 3));
  DateTime _targetDateTime = DateTime(2020, 8, 3);
  TargetVsActualModel targetVsActualModel;

  AddCalendarEventController eventController = Get.find();
  List calendarEventTitle = [
    'Site Conv. (No. of sites)',
    'Site Visits (Total)',
    'Counter Meet'
  ];
  // List calendarTargetData=[];

  Future<dynamic> showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2.5,
            color: Colors.white,
            child: targetVsActualModel.siteConversionCountTarget != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.5, 16.5, 16.5, 0),
                        child: Text(
                          'Target Vs Actual',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(),
                            flex: 5,
                          ),
                          Expanded(
                            child: Text('Tgt.'),
                          ),
                          Expanded(
                            child: Text('Act.'),
                          ),
                        ],
                      ),
                      // SizedBox(height: 24,),
                      Expanded(
                        child: Column(children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(calendarEventTitle[0]),
                                  flex: 4,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: ColorConstants
                                                  .lightOutlineColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          targetVsActualModel
                                              .siteConversionCountTarget
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  ColorConstants.lightGreyColor,
                                              fontFamily: "Muli"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: ColorConstants
                                                  .lightOutlineColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          targetVsActualModel
                                              .siteConversionCountActual
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  ColorConstants.lightGreyColor,
                                              fontFamily: "Muli"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(calendarEventTitle[1]),
                                  flex: 4,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: ColorConstants
                                                  .lightOutlineColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          targetVsActualModel
                                              .siteVisitsCountTarget
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  ColorConstants.lightGreyColor,
                                              fontFamily: "Muli"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: ColorConstants
                                                  .lightOutlineColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          targetVsActualModel
                                              .siteVisitsCountActual
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  ColorConstants.lightGreyColor,
                                              fontFamily: "Muli"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(calendarEventTitle[2]),
                                  flex: 4,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: ColorConstants
                                                  .lightOutlineColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          targetVsActualModel
                                              .counterMeetCountTarget
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  ColorConstants.lightGreyColor,
                                              fontFamily: "Muli"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: ColorConstants
                                                  .lightOutlineColor)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          targetVsActualModel
                                              .counterMeetCountActual
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  ColorConstants.lightGreyColor,
                                              fontFamily: "Muli"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      )
                    ],
                  )
                : Center(
                    child: Text(
                      targetVsActualModel.respMsg,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
          );
        });
  }

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2020, 8, 5): [
        new Event(
          date: new DateTime(2020, 8, 5),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.green,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2020, 8, 5),
          title: 'Event 2',
          icon: _eventIcon,
        ),
      ],
    },
  );

  getBottomSheetData() async {
    eventController.getAccessKey().then((data) async {
      targetVsActualModel =
          await eventController.getTargetVsActualData(data.accessKey);
      print(targetVsActualModel.toJson());
    });
  }

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    getBottomSheetData();
    // getBottomSheetData();
    /* _markedDateMap.addAll(new DateTime(2020, 8, 13), [
      new Event(
        date: new DateTime(2020, 8, 13),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 13),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 13),
        title: 'Event 3',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2020, 8, 13),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: true,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      /*markedDatesMap: _markedDateMap,*/
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),

      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),

      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("My Plan"),
          actions: [
            MaterialButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, color: Colors.white),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //custom icon
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarousel,
                ),
                // This trailing comma makes auto-formatting nicer for build methods.
                //custom icon without header
                /*Container(
                  margin: EdgeInsets.only(
                    top: 30.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            _currentMonth,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          )),
                      FlatButton(
                        child: Text('PREV'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month -1);
                            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      ),
                      FlatButton(
                        child: Text('NEXT'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year, _targetDateTime.month +1);
                            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      )
                    ],
                  ),
                ),*/
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarouselNoHeader,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => showBottomSheet(context),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstants.lightGeyColor)),
                        child: Text(
                          'TARGET VS ACTUAL/PLAN',
                          style: ButtonStyles.buttonStyleWhite,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ADD_MWP_SCREEN);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstants.lightGeyColor)),
                        child: Text(
                          'MWP STATUS',
                          style: ButtonStyles.buttonStyleWhite,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
