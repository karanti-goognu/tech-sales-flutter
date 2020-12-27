import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/CalendarPlanModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/TargetVsActualModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
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
  final _targetVsActual = TargetVsActualModel().obs;

  final _isLoading = false.obs;
  final _action = "SAVE".obs;
  final _selectedMonth = StringConstants.empty.obs;

  set isLoading(value) => this._isLoading.value = value;

  set action(value) => this._action.value = value;

  get action => this._action.value;

  set targetVsActual(value) => this._targetVsActual.value = value;

  get targetVsActual => this._targetVsActual.value;

  get isLoading => this._isLoading.value;

  get calendarPlanResponse => this._calendarPlanResponse.value;

  set calendarPlanResponse(value) => this._calendarPlanResponse.value = value;

  set selectedMonth(value) => this._selectedMonth.value = value;

  get selectedMonth => this._selectedMonth.value;

  getCalendarEvent(String accessKey) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.getCalendarEventData +
          "referenceID=$empId&" +
          "monthYear=${this.selectedMonth}";
      print('$url');
      repository.getCalenderPlan(accessKey, userSecurityKey, url).then((data) {
        this.isLoading = false;
        if (data == null) {
          debugPrint('MWP Data Response is null');
        } else {
          debugPrint('MWP Data Response is not null');
          this.calendarPlanResponse = data;
          this.isLoading = false;
          if (calendarPlanResponse.respCode == "MWP2013") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            print('${calendarPlanResponse.respMsg}');
            //SitesDetailWidget();
          } else {
            Get.dialog(
                CustomDialogs().errorDialog(calendarPlanResponse.respMsg));
          }
        }
      });
    });
  }
  getTargetVsActualEvent(String accessKey) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.getTargetVsActualData +
          "$empId";
      print('$url');
      repository.getTargetVsActualPlan(accessKey, userSecurityKey, url).then((data) {
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
