import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/calendar_event_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/styles/button_styles.dart';
import 'package:flutter_tech_sales/utils/styles/text_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' show DateFormat;

class AddCalenderEventPage extends StatefulWidget {
  @override
  _AddCalenderEventPageState createState() => new _AddCalenderEventPageState();
}

class _AddCalenderEventPageState extends State<AddCalenderEventPage> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime(2020, 8, 3));
  DateTime _targetDateTime = DateTime(2020, 8, 3);

  CalendarEventController _calendarEventController = Get.find();
  AppController _appController = Get.find();
  AddEventController _addEventController = Get.find();

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

  EventList<Event> _markedDateMap = new EventList<Event>();

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM-yyyy');
    final String formatted = formatter.format(now);
    _calendarEventController.selectedMonth = formatted;
    _appController.getAccessKey(RequestIds.GET_CALENDER_EVENTS);
    _appController.getAccessKey(RequestIds.TARGET_VS_ACTUAL);
    /*_calendarEventController.isLoading = true;*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        _calendarEventController.selectedDate =
            "${date.year}-${date.month}-${date.day}";
        print('${_calendarEventController.selectedDate}');
        _appController.getAccessKey(RequestIds.GET_CALENDER_EVENTS_OF_DAY);
        _calendarEventController.isLoading = true;
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
      markedDateMoreCustomDecoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
        color: Colors.grey,
      ),
//      firstDayOfWeek: 4,
      /*markedDatesMap: _calendarEventController.markedDateMap,*/
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
        final DateFormat formatter = DateFormat('MMMM-yyyy');
        print('$date');
        final String formatted = formatter.format(date);
        _calendarEventController.selectedMonth = formatted;
        _appController.getAccessKey(RequestIds.GET_CALENDER_EVENTS);
        //_calendarEventController.isLoading = true;

        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          print('$_currentMonth');
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return WillPopScope(
        onWillPop: () async {
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            //resizeToAvoidBottomInset: true,
            extendBody: true,
            appBar: new AppBar(
              title: new Text("Add Calender"),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _settingModalBottomSheet(context);
                        },
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "ADD",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
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
                    Obx(
                      () => (_calendarEventController.isLoading == false)
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              child: _calendarCarousel,
                            )
                          : Container(),
                    ),
                    // This trailing comma makes auto-formatting nicer for build methods.
                    //custom icon without header
                    Obx(
                      () => (_calendarEventController.isLoading == false)
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16.0),
                              child: _calendarCarouselNoHeader,
                            )
                          : Container(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _settingModalBottomSheetTVP(context);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorConstants.lineColorFilter)),
                            child: Text(
                              'TARGET VS ACTUAL/PLAN',
                              style: ButtonStyles.buttonStyleWhiteBold,
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
                                    color: ColorConstants.lineColorFilter)),
                            child: Text(
                              'MWP STATUS',
                              style: ButtonStyles.buttonStyleWhiteBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(() => (_calendarEventController
                                .calendarPlanResponse.listOfEventDetails ==
                            null)
                        ? Container()
                        : (_calendarEventController.calendarPlanResponse
                                    .listOfEventDetails.length ==
                                0)
                            ? Container()
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (BuildContext context,
                                        int index) =>
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(),
                                    ),
                                itemCount: _calendarEventController
                                    .calendarPlanResponse
                                    .listOfEventDetails
                                    .length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: (){
                                      print('${_calendarEventController
                                          .calendarPlanResponse
                                          .listOfEventDetails[index].eventType}');

                                      if(_calendarEventController
                                          .calendarPlanResponse
                                          .listOfEventDetails[index].eventType == 'VISIT'){
                                        _addEventController.visitId = _calendarEventController
                                            .calendarPlanResponse
                                            .listOfEventDetails[index].id;
                                        Get.toNamed(Routes.VISIT_VIEW_SCREEN);
                                      }else{
                                        _addEventController.visitId = _calendarEventController
                                            .calendarPlanResponse
                                            .listOfEventDetails[index].id;
                                        Get.toNamed(Routes.VIEW_MEET_SCREEN);
                                      }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(16, 4, 16, 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          new Container(
                                            width: 18,
                                            height: 18,
                                            decoration: new BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  _calendarEventController
                                                      .calendarPlanResponse
                                                      .listOfEventDetails[index]
                                                      .eventType,
                                                  style:
                                                      TextStyles.mulliRegular14,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "${_calendarEventController.calendarPlanResponse.listOfEventDetails[index].displayMessage2}",
                                                  style: TextStyles.robotoBold16,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "${_calendarEventController.calendarPlanResponse.listOfEventDetails[index].displayMessage1}",
                                                  style:
                                                      TextStyles.mulliRegular14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                  ],
                ),
              ),
            )));
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: addPlanBody(),
          );
        });
  }

  void _settingModalBottomSheetTVP(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: addTVsPBody(),
          );
        });
  }

  Widget addTVsPBody() {
    List<String> mwpNames = [
      "Sites Conv.(Total Sites)",
      "Sites visit(Total)",
      "Counter Meet",
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TARGET VS ACTUAL",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[],
                ),
                flex: 5,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "Tgt.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.lightGreyColor,
                    ),
                  ),
                ),
                flex: 2,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    //_mwpPlanController.getMWPResponse.respCode,
                    "Act.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.lightGreyColor,
                    ),
                  ),
                ),
                flex: 2,
              ),
            ],
          ),
          Obx(
            () => (_calendarEventController.isLoading)
                ? Container()
                : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 2),
                    //  padding: const EdgeInsets.all(8.0),
                    itemCount: mwpNames.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 56,
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    mwpNames[index],
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      color: ColorConstants.lightGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                              flex: 5,
                            ),
                            Flexible(
                              child: Container(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1,
                                        color:
                                            ColorConstants.lightOutlineColor)),
                                child: Text(
                                  (index == 0)
                                      ? "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.siteConversionCountTarget}"
                                      : (index == 1)
                                          ? "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.siteVisitsCountTarget}"
                                          : "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.counterMeetCountTarget}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ColorConstants.lightGreyColor,
                                      fontFamily: "Muli"),
                                ),
                              ),
                              flex: 2,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Obx(
                              () => Flexible(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          color: ColorConstants
                                              .lightOutlineColor)),
                                  child: Text(
                                    (index == 0)
                                        ? "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.siteConversionCountActual}"
                                        : (index == 1)
                                        ? "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.siteVisitsCountActual}"
                                        : "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.counterMeetCountActual}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: ColorConstants.lightGreyColor,
                                        fontFamily: "Muli"),
                                  ),
                                ),
                                flex: 2,
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget addPlanBody() {
    return Container(
      /*height: SizeConfig.safeBlockVertical * 50,
      width: SizeConfig.screenWidth,*/
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "ADD PLAN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
            ),
            returnContainer(StringConstants.visits),
            returnContainer(StringConstants.influencersMeet),
            returnContainer(StringConstants.services),
          ],
        ),
      ),
    );
  }

  Widget returnContainer(String title) {
    AddEventController _addEventController = Get.find();
    return GestureDetector(
      onTap: () {
        if (title == StringConstants.visits) {
          _addEventController.selectedView = 'Visit';
        } else if (title == StringConstants.influencersMeet) {
          _addEventController.selectedView = 'Influencers meet';
        } else {
          //Get.toNamed(Routes.ADD_EVENT_SCREEN);
        }
        Get.offNamed(Routes.ADD_EVENT_SCREEN);
      },
      child: Container(
        height: 60,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.robotoBold16,
            ),
            Icon(
              Icons.keyboard_arrow_right_outlined,
              size: 20,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
