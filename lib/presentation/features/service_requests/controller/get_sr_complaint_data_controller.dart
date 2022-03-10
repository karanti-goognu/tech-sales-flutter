import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/AddSrComplaintModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/RequestorDetailsModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/SiteAreaDetailsModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SrFormDataController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final SrRepository repository;

  SrFormDataController({@required this.repository})
      : assert(repository != null);
  final _srFormData = SrComplaintModel().obs;
  get srFormDaa => _srFormData.value;
  set srFormDaa(value) => _srFormData.value = value;

  final _requestorData = RequestorDetailsModel().obs;
  get requestorData => _requestorData.value;
  set requestorData(value) => _requestorData.value = value;

  final _siteLocationData = SiteAreaModel().obs;

  get siteLocationData => _siteLocationData.value;

  set siteLocationData(value) {
    _siteLocationData.value = value;
  }


  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
  }

  Future<SrComplaintModel> getSrComplaintFormData(String accessKey) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      srFormDaa = await repository.getSrFormData(accessKey, userSecurityKey,empID);
    });
    return srFormDaa;
  }

  Future<RequestorDetailsModel> getRequestorDetails(
      String accessKey, String requestorType,String siteId) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      requestorData = await repository.getRequestorDetails(
          accessKey, userSecurityKey, empID, requestorType,siteId);
    });
    return requestorData;
  }

  Future<SiteAreaModel> getSiteAreaDetails(String siteId) async {
    String userSecurityKey = "";
    String empID = "";
    String accessKey = "";
    await getAccessKey().then((value) async {
      accessKey = value.accessKey;
    });
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      siteLocationData = await repository.getSiteAreaDetails(
          accessKey, userSecurityKey, empID, siteId);
    });
    return siteLocationData;
  }



}
