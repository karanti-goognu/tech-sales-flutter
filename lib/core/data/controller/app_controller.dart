import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/core/data/models/SecretKeyModel.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/core/security/encryt_and_decrypt.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/add_event__controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/calendar_event_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/mwp_plan_controller.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/controller/update_sr_controller.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/controller/site_controller.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  final SiteController _siteController = Get.find();
  final MWPPlanController _mwpPlanController = Get.find();
  final CalendarEventController _calendarEventController = Get.find();
  final AddEventController _addEventController = Get.find();
  // final UpdateServiceRequestController _updateServiceRequestController = Get.find();

  AppController({@required this.repository}) : assert(repository != null);

  final _accessKeyResponse = AccessKeyModel().obs;
  final _secretKeyResponse = SecretKeyModel().obs;

  final _phoneNumber = "8860080067".obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  get secretKeyResponse => this._secretKeyResponse.value;

  get phoneNumber => this._phoneNumber.value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set secretKeyResponse(value) => this._secretKeyResponse.value = value;

  //set filterDataResponse(value) => this._filterDataResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  getSecretKey(int requestId) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    String empId = "empty";
    String mobileNumber = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      String empIdEncrypted =
          encryptString(empId, StringConstants.encryptedKey);
      String mobileNumberEncrypted =
          encryptString(mobileNumber, StringConstants.encryptedKey);
      repository
          .getSecretKey(empIdEncrypted, mobileNumberEncrypted)
          .then((data) {
        Get.back();
        this.secretKeyResponse = data;
        if (data != null) {
          prefs.setString(StringConstants.userSecurityKey,
              this.secretKeyResponse.secretKey);
          getAccessKey(requestId);
        } else {
          print('Secret key response is null');
        }
      });
    });
  }

   getAccessKey(int requestId) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();
      this.accessKeyResponse = data;
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        String userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
        // print('User Security key is :: $userSecurityKey');
        if (userSecurityKey != "empty") {
          //Map<String, dynamic> decodedToken = JwtDecoder.decode(userSecurityKey);
          bool hasExpired = JwtDecoder.isExpired(userSecurityKey);
          if (hasExpired) {
            print('Has expired');
            getSecretKey(requestId);
          } else {
            // print('Not expired');
            switch (requestId) {
              case RequestIds.GET_SITES_LIST:
                _siteController.getSitesData(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.SEARCH_SITES:
                _siteController.searchSites(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.SAVE_MWP_PLAN:
                _mwpPlanController
                    .saveMWPPlan(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.GET_MWP_PLAN:
                _mwpPlanController.getMWPPlan(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.GET_MWP_PLAN:
                _addEventController.saveVisit(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.GET_CALENDER_EVENTS:
                _calendarEventController
                    .getCalendarEvent(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.GET_CALENDER_EVENTS_OF_DAY:
                _calendarEventController
                    .getCalendarEventOfDay(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.TARGET_VS_ACTUAL:
                _calendarEventController
                    .getTargetVsActualEvent(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.GET_DEALERS_LIST:
                _addEventController
                    .getDealersList(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.SAVE_VISIT:
                _addEventController
                    .saveVisit(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.SAVE_MEET:
                _addEventController
                    .saveMeet(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.VIEW_VISIT:
                _addEventController
                    .viewVisitData(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.VIEW_MEET:
                _addEventController
                    .viewMeetData(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.UPDATE_VISIT:
                _addEventController
                    .updateVisit(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.UPDATE_MEET:
                _addEventController
                    .updateMeet(this.accessKeyResponse.accessKey);
                break;
              // case RequestIds.UPDATE_SR_REQUEST:
              //   _addEventController
              //       .updateMeet(this.accessKeyResponse.accessKey);
              //   break;
            }
          }
        }
      });
    });
  }
}
