import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/models/JorneyModel.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/data/repository/home_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/ValidateOtpModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/get_current_location.dart';
import 'package:flutter_tech_sales/utils/tso_logger.dart';


class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryHome repository;
  SplashController _splashController = Get.find();

  HomeController({required this.repository});

  final _accessKeyResponse = AccessKeyModel().obs;
  final _validateOtpResponse = ValidateOtpModel().obs;
  final _checkInResponse = JourneyModel().obs;
  final _phoneNumber = "8860080067".obs;
  final _empId = "_empty".obs;
  final _employeeName = "_empty".obs;
  final _checkInStatus = StringConstants.empty.obs;
  final _disableSlider = false.obs;
  final _sitesConverted = '0'.obs;
  final _volumeConverted = '0'.obs;
  final _newInfl = '0'.obs;
  final _dspSlabsConverted = '0'.obs;

  get sitesConverted => this._sitesConverted.value;

  set sitesConverted(value) => this._sitesConverted.value = value;

  get volumeConverted => this._volumeConverted.value;

  set volumeConverted(value) => this._volumeConverted.value = value;

  get newInfl => this._newInfl.value;

  set newInfl(value) => this._newInfl.value = value;

  get dspSlabsConverted => this._dspSlabsConverted.value;

  set dspSlabsConverted(value) => this._dspSlabsConverted.value = value;

  get disableSlider => this._disableSlider.value;

  set disableSlider(value) => this._disableSlider.value = value;

  get accessKeyResponse => this._accessKeyResponse.value;

  get checkInStatus => this._checkInStatus.value;

  get validateOtpResponse => this._validateOtpResponse.value;

  get checkInResponse => this._checkInResponse.value;

  get phoneNumber => this._phoneNumber.value;

  get empId => this._empId.value;

  get employeeName => this._employeeName.value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set validateOtpResponse(value) => this._validateOtpResponse.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set empId(value) => this._empId.value = value;

  set employeeName(value) => this._employeeName.value = value;

  set checkInResponse(value) => this._checkInResponse.value = value;

  set checkInStatus(value) => this._checkInStatus.value = value;

  LatLng? _currentPosition;

  showNoInternetSnack() {
    Get.snackbar(
        "No internet connection.", "Please check your internet connection.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM);
  }

  disable() {
    this.disableSlider = true;
  }

  enable() {
    this.disableSlider = false;
  }

  getAccessKey(int requestId) {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      if (data != null) {
        this.accessKeyResponse = data;
        switch (requestId) {
          case RequestIds.CHECK_IN:
            getCheckInDetails(this.accessKeyResponse.accessKey);
            break;
          case RequestIds.CHECK_OUT:
            getCheckOutDetails(this.accessKeyResponse.accessKey);
            break;
          case RequestIds.HOME_DASHBOARD:
            getDashboardDetails(this.accessKeyResponse.accessKey);
            break;
        }
      }
    });
  }

  getDashboardDetails(String? accessKey) async {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      await repository.getHomeDashboardDetails(accessKey, userSecurityKey, empId).then((_) {
        Get.back();
        DashboardModel data = _;
        this.sitesConverted = data.dashBoardViewModal!.sitesConverted;
        this.dspSlabsConverted = data.dashBoardViewModal!.dspSlabsConverted;
        this.volumeConverted = data.dashBoardViewModal!.volumeConverted;
        this.newInfl = data.dashBoardViewModal!.newInfl;
      });
    });
  }

  getCheckInDetails(String? accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    String journeyStartLat = "empty";
    String journeyStartLong = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      LocationDetails result = await GetCurrentLocation.getCurrentLocation();

        _currentPosition = result.latLng;
        print('start');
        journeyStartLat = _currentPosition!.latitude.toString();
        journeyStartLong = _currentPosition!.longitude.toString();
        String url = "${UrlConstants.getCheckInDetails}";
        TsoLogger.printLog('Url is : $url');
        var date = DateTime.now();
        var formattedDate = "${date.year}-${date.month}-${(date.day)}";
        this.disableSlider = true;
        repository.getCheckInDetails(url, accessKey, userSecurityKey, empId, formattedDate, date.toString(), journeyStartLat, journeyStartLong, null, null, null)
            .then((data) async {
          if (data == null) {
            debugPrint('Check in  Data Response is null');
          } else {
            this.checkInResponse = data;
            checkInStatus = StringConstants.checkOut;
            _splashController.splashDataModel.journeyDetails.journeyStartLat =
                this.checkInResponse.journeyEntity.journeyStartLat;
            _splashController.splashDataModel.journeyDetails.journeyStartLong =
                this.checkInResponse.journeyEntity.journeyStartLong;
            _splashController.splashDataModel.journeyDetails.journeyDate =
                this.checkInResponse.journeyEntity.journeyDate;
            _splashController.splashDataModel.journeyDetails.journeyStartTime =
                this.checkInResponse.journeyEntity.journeyStartTime;
            prefs.setString(StringConstants.JOURNEY_DATE, this.checkInResponse.journeyEntity.journeyDate);
            this.disableSlider = false;
          }
          Get.back();
        });


     });
  }

  getCheckOutDetails(String? accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    String? journeyStartLat = "empty";
    String? journeyStartLong = "empty";
    String journeyEndLat = "empty";
    String journeyEndLong = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async{
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      LocationDetails result = await GetCurrentLocation.getCurrentLocation();
      if (result != null) {
        _currentPosition = result.latLng;
        print('start');
        journeyStartLong = _currentPosition!.longitude.toString();
        journeyStartLat =
            _splashController.splashDataModel.journeyDetails.journeyStartLat;
        journeyStartLong =
            _splashController.splashDataModel.journeyDetails.journeyStartLong;
        journeyEndLat = _currentPosition!.latitude.toString();
        journeyEndLong = _currentPosition!.longitude.toString();
        String url = "${UrlConstants.getCheckInDetails}";
        var date = DateTime.now();
        String? journeyDate = _splashController.splashDataModel.journeyDetails
            .journeyDate;
        String? journeyStartTime = _splashController.splashDataModel
            .journeyDetails.journeyStartTime;
        repository
            .getCheckInDetails(
            url,
            accessKey,
            userSecurityKey,
            empId,
            journeyDate,
            journeyStartTime,
            journeyStartLat,
            journeyStartLong,
            date.toString(),
            journeyEndLat,
            journeyEndLong)
            .then((data) {
          if (data == null) {
            debugPrint('Check in  Data Response is null');
          } else {
            this.checkInResponse = data;
            checkInStatus = StringConstants.journeyEnded;
            prefs.setString(StringConstants.JOURNEY_END_DATE,
                this.checkInResponse.journeyEntity.journeyEndTime);
          }
        });
        Get.back();
      }
    });
  }


  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }

  openHomeScreen() {
    Get.toNamed(Routes.HOME_SCREEN);
  }

///call refresh data api for get master data if splash model have no data
  Future<bool> checkSplashMasterData() async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    await repository.getAccessKey().then((data) async {
      if (this.accessKeyResponse != null)
        await _splashController.getRefreshData(this.accessKeyResponse.accessKey,
            RequestIds.GET_MASTER_DATA_FOR_HOME);
    });
    return true;
  }
}
