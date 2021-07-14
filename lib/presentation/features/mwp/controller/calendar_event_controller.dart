import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/CalendarDataByDay.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/CalendarPlanModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/ListOfEventDetails.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/TargetVsActualModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  CalendarEventController({@required this.repository})
      : assert(repository != null);

  final _calendarPlanResponse = CalendarPlanModel().obs;
  final _calendarDataByDay = CalendarDataByDay().obs;
  final _targetVsActual = TargetVsActualModel().obs;
  final _listOfEvents = List<ListOfEventDetails>().obs;

  var _markedDateMap = EventList<Event>().obs;
  final _dateList = List<String>().obs;
  final _testMap = Map<DateTime, List<Event>>().obs;

  final _isLoading = false.obs;
  final _isCalenderLoading = false.obs;
  final _isDayEventLoading = false.obs;
  final _action = "SAVE".obs;
  final _selectedMonth = StringConstants.empty.obs;
  final _selectedDate = StringConstants.empty.obs;

  get testMap => this._testMap.value;

  set testMap(value) => this._testMap.value = value;


  set isLoading(value) => this._isLoading.value = value;

  set isDayEventLoading(value) => this._isDayEventLoading.value = value;

  get isDayEventLoading => this._isDayEventLoading.value;

  set isCalenderLoading(value) => this._isCalenderLoading.value = value;

  get isCalenderLoading => this._isCalenderLoading.value;

  set listOfEvents(value) => this._listOfEvents.value = value;

  get listOfEvents => this._listOfEvents;

  set selectedDate(value) => this._selectedDate.value = value;

  get selectedDate => this._selectedDate.value;

  set markedDateMap(value) => this._markedDateMap.value = value;

  get markedDateMap => this._markedDateMap.value;

  set action(value) => this._action.value = value;

  get action => this._action.value;

  set targetVsActual(value) => this._targetVsActual.value = value;

  get targetVsActual => this._targetVsActual.value;

  set calendarDataByDay(value) => this._calendarDataByDay.value = value;

  get calendarDataByDay => this._calendarDataByDay.value;

  get isLoading => this._isLoading.value;

  get calendarPlanResponse => this._calendarPlanResponse.value;

  set calendarPlanResponse(value) => this._calendarPlanResponse.value = value;

  set selectedMonth(value) => this._selectedMonth.value = value;

  get selectedMonth => this._selectedMonth.value;

  set dateList(value) => this._dateList.value = value;

  get dateList => this._dateList;

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 10.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

 Future getCalendarEvent(String accessKey) async {
    this.isCalenderLoading = true;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.getCalendarEventData +
          "referenceID=$empId&" +
          "monthYear=${this.selectedMonth}";
      print('$url');
      repository.getCalenderPlan(accessKey, userSecurityKey, url).then((data) {
        this.isCalenderLoading = false;
        // print('@${json.encode(data)}');
        /*this.isLoading = false;*/
        if (data == null) {
          debugPrint('MWP Data Response is null');
        } else {
          debugPrint('MWP Data Response is not null');
          this.calendarPlanResponse = data;
          this.listOfEvents = this.calendarPlanResponse.listOfEventDetails;
          markedDateMap.clear();
          if (this.calendarPlanResponse.listOfEventDates.length > 0) {
            var temp = EventList<Event>();
            for (int i = 0;
            i < this.calendarPlanResponse.listOfEventDates.length;
            i++) {
              String date = this.calendarPlanResponse.listOfEventDates[i];
              DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(date);
              var key = DateTime(tempDate.year, tempDate.month, tempDate.day);
              testMap[key] = [
                new Event(
                  date: new DateTime(
                      tempDate.year, tempDate.month, tempDate.day),
                  title: 'Event 5',
                )
              ];
              temp.add(
                  new DateTime(tempDate.year, tempDate.month, tempDate.day),
                  new Event(
                    date: new DateTime(
                        tempDate.year, tempDate.month, tempDate.day),
                    // date: new DateTime(tempDate.year, tempDate.month, tempDate.day),
                    title: 'Event 5',
                    icon: _eventIcon,
                    /* dot: Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      color: Colors.red,
                      height: 5.0,
                      width: 5.0,
                    ),*/
                  ));
            }
            markedDateMap = temp;
          }

          if (calendarPlanResponse.respCode == "MWP2013") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            print('${calendarPlanResponse.respMsg}');
            //SitesDetailWidget();
          } else {
            /*Get.dialog(
                CustomDialogs().errorDialog(calendarPlanResponse.respMsg));*/
          }
       // }
      }
      });
    });
  }

  getCalendarEventOfDay(String accessKey) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.getCalendarEventDataByDay +
          "referenceID=$empId&" +
          "&date=${this.selectedDate}";
      print('---++---$url');
      repository
          .getCalenderPlanByDay(accessKey, userSecurityKey, url)
          .then((data) {
        if (data == null) {
          this.isDayEventLoading = false;
          debugPrint('MWP Data Response is null');
        } else {
          debugPrint('MWP Data Response is not null');
          this.calendarDataByDay = data;
          this.listOfEvents =
              this.calendarDataByDay.listOfEventDetails;
          this.isDayEventLoading = false;
          if (calendarDataByDay.respCode == "MWP2019") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            print('${calendarDataByDay.respMsg}');
            //SitesDetailWidget();
          } else {
            this.isLoading = false;
            Get.dialog(CustomDialogs().errorDialog(calendarDataByDay.respMsg));
          }
        }
        //}
      });
    });
  }

  getTargetVsActualEvent(String accessKey) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.getTargetVsActualData + "$empId";
      print('$url');
      repository
          .getTargetVsActualPlan(accessKey, userSecurityKey, url)
          .then((data) {
        this.isLoading = false;
        if (data == null) {
          debugPrint('Target vs Actual Response is null');
        } else {
          debugPrint('Target vs Actual Response is not null');
          this.targetVsActual = data;
          this.isLoading = false;
          if (targetVsActual.respCode == "MWP2023") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            print('${targetVsActual.respMsg}');
            //SitesDetailWidget();
          } else {
            Get.dialog(
                CustomDialogs().errorDialog(calendarPlanResponse.respMsg));
          }
        }
      });
    });
  }
}
