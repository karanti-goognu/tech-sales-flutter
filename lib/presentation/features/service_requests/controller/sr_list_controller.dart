import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SRListController extends GetxController{
  @override
  void onInit() {
    super.onInit();
  }
  final SrRepository repository;
  SRListController({@required this.repository}) : assert(repository != null);

  final _srListData = ServiceRequestComplaintListModel().obs;
  get srListData => _srListData.value;
  set srListData(value) =>
      _srListData.value = value;

final _siteListData = ServiceRequestComplaintListModel().obs;
  get siteListData => _siteListData.value;
  set siteListData(value) =>
      _siteListData.value = value;

  var _filteredListData = ServiceRequestComplaintListModel();
  get filteredListData => _filteredListData;
  set filteredListData(value) =>
      _filteredListData = value;
//*****
  final _complaintListData  = ComplaintViewModel().obs;

  get complaintListData => _complaintListData.value;

  set complaintListData(value) {
    _complaintListData.value = value;
  }
//*****



  Future<AccessKeyModel> getAccessKey(){
    return repository.getAccessKey();

  }

  Future<ServiceRequestComplaintListModel> getSrListData(String accessKey) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      srListData = await repository.getSrListData(accessKey,userSecurityKey, empID);
    });
    return srListData;
  }

  Future<ServiceRequestComplaintListModel> getSrListDataWithFilters(String accessKey,String resolutionStatusId,String severity, String typeOfReqId) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      filteredListData = await repository.getSrListDataWithFilters(accessKey,userSecurityKey, empID, resolutionStatusId,severity, typeOfReqId);
    });
    return filteredListData;
  }

  Future<ServiceRequestComplaintListModel> getSiteListData(String accessKey, String siteID) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      siteListData = await repository.getSiteListData(accessKey,userSecurityKey, empID, siteID);
    });
    return siteListData;
  }

  //*****
  Future  getComplaintViewData(String accessKey, String id) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        empID = prefs.getString(StringConstants.employeeId);
        complaintListData = await repository.getComplaintViewData(accessKey,userSecurityKey, empID, id);
      });
      print(complaintListData.runtimeType);
      return complaintListData;

  }
  //*****

}




