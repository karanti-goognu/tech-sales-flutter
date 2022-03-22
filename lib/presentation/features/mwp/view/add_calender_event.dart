

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tech_sales/bindings/event_binding.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_event.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/detail_view_pending.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/view/end_event.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/calendar_event_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/global.dart';
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
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

  CalendarEventController _calendarEventController = Get.find();
  AppController _appController = Get.find();
  AddEventController _addEventController = Get.find();



  @override
  void initState() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM-yyyy');
    final String formatted = formatter.format(now);
    _calendarEventController.selectedMonth = formatted;

    internetChecking().then((result) => {
      if (result == true)
        {
          print(1),
        _appController.getAccessKey(RequestIds.GET_CALENDER_EVENTS),
          print(2),

          _appController.getAccessKey(RequestIds.TARGET_VS_ACTUAL),
          _calendarEventController.selectedDate = "${_currentDate2.year}-${_currentDate2.month}-${_currentDate2.day}",
          print(3),

          _appController.getAccessKey(RequestIds.GET_CALENDER_EVENTS_OF_DAY),
        }else{
        Get.snackbar(
            "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM),
        // fetchSiteList()
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 690),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return WillPopScope(
        onWillPop: () async {
          // You can do some work here.
          // Returning true allows the pop to happen, returning false prevents it.
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            appBar: new AppBar(
              backgroundColor: ColorConstants.backgroundColorBlue,
              title: new Text("My Plan"),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
                  child: GestureDetector(
                      onTap: () {
                        _settingModalBottomSheet(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Add",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      )),
                ),
              ],
            ),
            body: calender(),
            // body: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     Container(
            //         color: Colors.white,
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 16.0),
            //           child: Obx(() => CalendarCarousel<Event>(
            //                 todayButtonColor: Colors.green,
            //                 height: 360.0,
            //                 selectedDateTime: _currentDate2,
            //                 headerMargin: EdgeInsets.zero,
            //                 selectedDayButtonColor:
            //                     Colors.grey.withOpacity(0.1),
            //                 selectedDayTextStyle:
            //                     TextStyle(color: Colors.black),
            //                 weekdayTextStyle: TextStyle(
            //                     color: Colors.grey,
            //                     fontWeight: FontWeight.w400),
            //                 dayPadding: 4,
            //                 weekendTextStyle: TextStyle(color: Colors.black),
            //                 onDayLongPressed: (DateTime date) {
            //                   print('long pressed date $date');
            //                 },
            //                 onDayPressed:
            //                     (DateTime date, List<Event> events) {
            //                   this.setState(() {
            //                     _currentDate2 = date;
            //                   });
            //                   _calendarEventController.selectedDate =
            //                       "${date.year}-${date.month}-${date.day}";
            //                   // print('${_calendarEventController.selectedDate}');
            //                   _appController.getAccessKey(
            //                       RequestIds.GET_CALENDER_EVENTS_OF_DAY);
            //                   _calendarEventController.isDayEventLoading =
            //                       true;
            //                   /*this.setState(() => _currentDate2 = date);*/
            //                 },
            //                 markedDateMoreCustomDecoration: new BoxDecoration(
            //                   borderRadius: new BorderRadius.circular(10.0),
            //                   color: Colors.grey,
            //                 ),
            //                 markedDatesMap:
            //                     _calendarEventController.markedDateMap,
            //                 targetDateTime: _targetDateTime,
            //                 customGridViewPhysics:
            //                     NeverScrollableScrollPhysics(),
            //                 minSelectedDate:
            //                     _currentDate.subtract(Duration(days: 360)),
            //                 maxSelectedDate:
            //                     _currentDate.add(Duration(days: 360)),
            //                 inactiveDaysTextStyle: TextStyle(
            //                   color: Colors.tealAccent,
            //                   fontSize: 16,
            //                 ),
            //             childAspectRatio: 1,
            //                 onCalendarChanged: (DateTime date) {
            //                   final DateFormat formatter =
            //                       DateFormat('MMMM-yyyy');
            //                   final String formatted = formatter.format(date);
            //                   _calendarEventController.selectedMonth =
            //                       formatted;
            //                   _appController.getAccessKey(
            //                       RequestIds.GET_CALENDER_EVENTS);
            //                   //_calendarEventController.isLoading = true;
            //
            //                   this.setState(() {
            //                     _targetDateTime = date;
            //                     _currentMonth =
            //                         DateFormat.yMMM().format(_targetDateTime);
            //                   });
            //                 },
            //               )),
            //         )),
            //     SizedBox(
            //       height: 12,
            //     ),
            //     returnRow(),
            //     Expanded(
            //       child: Container(
            //         child: SingleChildScrollView(
            //           child: Column(
            //             children: [
            //               SizedBox(
            //                 height: 12,
            //               ),
            //               returnEventsList(),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // )
        ));
  }

  Widget calender(){
    return ListView(
              children: <Widget>[
                Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Obx(() => CalendarCarousel<Event>(
                        todayButtonColor: Colors.green,
                        height: 360.0,
                        selectedDateTime: _currentDate2,
                        headerMargin: EdgeInsets.zero,
                        selectedDayButtonColor:
                        Colors.grey.withOpacity(0.1),
                        selectedDayTextStyle:
                        TextStyle(color: Colors.black),
                        weekdayTextStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                        dayPadding: 4,
                        weekendTextStyle: TextStyle(color: Colors.black),
                        onDayLongPressed: (DateTime date) {
                          print('long pressed date $date');
                        },
                        onDayPressed:
                            (DateTime date, List<Event> events) {
                          this.setState(() {
                            _currentDate2 = date;
                          });
                          _calendarEventController.selectedDate =
                          "${date.year}-${date.month}-${date.day}";
                          // print('${_calendarEventController.selectedDate}');
                          _appController.getAccessKey(
                              RequestIds.GET_CALENDER_EVENTS_OF_DAY);
                          _calendarEventController.isDayEventLoading =
                          true;
                          /*this.setState(() => _currentDate2 = date);*/
                        },
                        markedDateMoreCustomDecoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(10.0),
                          color: Colors.grey,
                        ),
                        markedDatesMap:
                        _calendarEventController.markedDateMap,
                        targetDateTime: _targetDateTime,
                        customGridViewPhysics:
                        NeverScrollableScrollPhysics(),
                        minSelectedDate:
                        _currentDate.subtract(Duration(days: 360)),
                        maxSelectedDate:
                        _currentDate.add(Duration(days: 360)),
                        inactiveDaysTextStyle: TextStyle(
                          color: Colors.tealAccent,
                          fontSize: 16,
                        ),
                        childAspectRatio: 1,
                        onCalendarChanged: (DateTime date) {
                          final DateFormat formatter =
                          DateFormat('MMMM-yyyy');
                          final String formatted = formatter.format(date);
                          _calendarEventController.selectedMonth =
                              formatted;
                          _appController.getAccessKey(
                              RequestIds.GET_CALENDER_EVENTS);
                          //_calendarEventController.isLoading = true;

                          this.setState(() {
                            _targetDateTime = date;
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      )),
                    )),
                SizedBox(
                  height: 12,
                ),
                returnRow(),
                Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          returnEventsList(),
                        ],
                      ),

                  ),
                ),
              ],
            );
  }

  Widget returnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            _settingModalBottomSheetTVP(context);
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.lineColorFilter)),
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
                border: Border.all(color: ColorConstants.lineColorFilter)),
            child: Text(
              'MWP STATUS',
              style: ButtonStyles.buttonStyleWhiteBold,
            ),
          ),
        ),
      ],
    );
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

  Widget returnEventsList() {
    return Obx(() => (_calendarEventController.listOfEvents == null)
        ? Container()
        : (_calendarEventController.listOfEvents.length == 0)
            ? Container()
            : Obx(() => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.fromLTRB(32.0, 0, 16.0, 0),
                      child: SizedBox(height: 3, child: Divider()),
                    ),
                itemCount: _calendarEventController.listOfEvents.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // print('${_calendarEventController.listOfEvents[index].eventType}');
                      if (_calendarEventController
                              .listOfEvents[index].eventType == 'VISIT') {
                        _addEventController.visitId = _calendarEventController.listOfEvents[index].id;
                        Get.toNamed(Routes.VISIT_VIEW_SCREEN);
                      }else if (_calendarEventController.listOfEvents[index].eventType == 'EVENT'){
                        _addEventController.visitId = _calendarEventController.listOfEvents[index].id;
                        Color eventColor;
                        _calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.pendingApproval?eventColor = ColorConstants.eventPending:
                        _calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.rejectedEvent?  eventColor = ColorConstants.eventRejected:
                        _calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.notSubmitted? eventColor = ColorConstants.eventNotSubmited: eventColor = ColorConstants.blackColor;

                        // _calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.approved ||
                        //     _calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.completed ||
                        //     _calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.cancelled?
                        // Get.to(() => DetailViewEvent(_calendarEventController.listOfEvents[index].id),
                        //     binding: EGBinding()):Get.to(() => DetailPending(_calendarEventController.listOfEvents[index].id,eventColor),
                        //     binding: EGBinding());

                        if(_calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.completed ){
                          Get.to(() => EndEvent(_calendarEventController.listOfEvents[index].id,1),
                              binding: EGBinding());
                        }else if(_calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.approved || _calendarEventController.listOfEvents[index].displayMessage1 == StringConstants.cancelled){
                          Get.to(() => DetailViewEvent(_calendarEventController.listOfEvents[index].id),
                              binding: EGBinding());
                        }else{
                          Get.to(() => DetailPending(_calendarEventController.listOfEvents[index].id,eventColor),
                              binding: EGBinding());
                        }
                      } else {
                        _addEventController.visitId =
                            _calendarEventController.listOfEvents[index].id;
                        Get.toNamed(Routes.VIEW_MEET_SCREEN);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Container(
                            width: 18,
                            height: 18,
                            decoration: new BoxDecoration(
                              color: (_calendarEventController
                                              .listOfEvents[index]
                                              .meetingType ==
                                          'RETENTION SITE' ||
                                      _calendarEventController
                                              .listOfEvents[index]
                                              .meetingType ==
                                          'CONVERSION OPPORTUNITY')
                                  ? HexColor('#52B6E2')
                                  : _calendarEventController.listOfEvents[index]
                                              .meetingType ==
                                          'LEADS'
                                      ? HexColor('#52E2BB')
                                      : _calendarEventController
                                                  .listOfEvents[index]
                                                  .meetingType ==
                                              'SR'
                                          ? HexColor('#7F39FB')
                                          : _calendarEventController
                                                      .listOfEvents[index]
                                                      .meetingType ==
                                                  'COMPLAINT'
                                              ? HexColor('#9E3A0D')
                                              : (_calendarEventController.listOfEvents[index].meetingType ==
                                                          'MASSON MEET' ||
                                                      _calendarEventController.listOfEvents[index].meetingType ==
                                                          'CONTRACTOR MEET' ||
                                                      _calendarEventController
                                                              .listOfEvents[
                                                                  index]
                                                              .meetingType ==
                                                          'ENGINEER MEET' ||
                                                      _calendarEventController
                                                              .listOfEvents[
                                                                  index]
                                                              .meetingType ==
                                                          'MINI CONTRACTOR')
                                                  ? HexColor('#FD4066')
                                                  : _calendarEventController
                                                              .listOfEvents[index]
                                                              .meetingType ==
                                                          'CONSUMER MEET'
                                                      ? HexColor('#F6A902')
                                                      : _calendarEventController.listOfEvents[index].meetingType == 'COUNTER'
                                                          ? HexColor('#F6A902')
                                                          : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  _calendarEventController
                                      .listOfEvents[index].eventType,
                                  style: TextStyles.mulliRegular14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${_calendarEventController.listOfEvents[index].displayMessage2}",
                                  style: TextStyles.robotoBold16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "${_calendarEventController.listOfEvents[index].displayMessage1}",

                                  style: _calendarEventController.listOfEvents[index].displayMessage1=="Not Submitted"|| _calendarEventController.listOfEvents[index].displayMessage1=="Draft"?TextStyles.mulliRegular14Italic : TextStyles.mulliRegular14,

                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })));
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
          _calendarEventController.targetVsActual.mwpPlanTargetVsActualModel !=
                  null
              ? Obx(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          mwpNames[index],
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color:
                                                ColorConstants.lightGreyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    flex: 5,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 8, 16, 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color: ColorConstants
                                                  .lightOutlineColor)),
                                      child: Text(
                                        (index == 0)
                                            ? "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.siteConversionCountTarget}"
                                            : (index == 1)
                                                ? "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.siteVisitsCountTarget}"
                                                : "${_calendarEventController.targetVsActual.mwpPlanTargetVsActualModel.counterMeetCountTarget}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                ColorConstants.lightGreyColor,
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
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 8, 16, 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(2),
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
                                              color:
                                                  ColorConstants.lightGreyColor,
                                              fontFamily: "Muli"),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  )
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                              ),
                            );
                          },
                        ),
                )
              : Container(),
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
            returnContainer(StringConstants.influencersEvents),
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
          Get.offNamed(Routes.ADD_EVENT_SCREEN);
        } else if (title == StringConstants.influencersMeet) {
          _addEventController.selectedView = 'Influencers meet';
          Get.offNamed(Routes.ADD_EVENT_SCREEN);
        }  else if (title == StringConstants.influencersEvents) {
          _addEventController.selectedView = 'Influencers Events';
          Get.offNamed(Routes.ADD_EVENTS);
        } else if (title == StringConstants.services) {
          Get.toNamed(Routes.SERVICE_REQUEST_CREATION);
        }
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
