import 'package:flutter_tech_sales/core/data/provider/app_provider.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMeetRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveVisitRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/UpdateMeetRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/UpdateVisitModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/model/LeadVisitListModel.dart';

class MyRepositoryApp {
  final MyApiClientApp apiClient;

  MyRepositoryApp({required this.apiClient});

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getSecretKey(String empId, String mobileNumber) {
    return apiClient.getSecretKey(empId, mobileNumber);
  }

  saveMWPPlan(String? accessKey, String userSecurityKey, String url,
      SaveMWPModel saveMWPModel) {
    return apiClient.saveMWPData(accessKey, userSecurityKey, url, saveMWPModel);
  }

  saveVisitPlan(String? accessKey, String userSecurityKey, String url,
      SaveVisitRequest saveVisitRequest) {
    return apiClient.saveVisitRequest(
        accessKey, userSecurityKey, url, saveVisitRequest);
  }

  saveMeetPlan(String? accessKey, String userSecurityKey, String url,
      SaveMeetRequest saveMeetRequest) {
    return apiClient.saveMeetRequest(
        accessKey, userSecurityKey, url, saveMeetRequest);
  }

  updateVisitPlan(String? accessKey, String userSecurityKey, String url,
      UpdateVisitResponseModel updateVisitRequest) {
    return apiClient.updateVisitPlan(
        accessKey, userSecurityKey, url, updateVisitRequest);
  }

  updateMeetPlan(String? accessKey, String userSecurityKey, String url,
      UpdateMeetRequest saveMeetRequest) {
    return apiClient.updateMeetPlan(
        accessKey, userSecurityKey, url, saveMeetRequest);
  }

  getMWPPlan(String? accessKey, String? userSecurityKey, String url) {
    return apiClient.getMWPData(accessKey, userSecurityKey, url);
  }

  getDealerList(String? accessKey, String? userSecurityKey, String url) {
    return apiClient.getDealerList(accessKey, userSecurityKey, url);
  }
  Future<LeadVisitListModel?> getLeadList(String? accessKey, String? userSecurityKey) {
    return apiClient.getLeadList(accessKey, userSecurityKey);
  }

  getVisitData(String? accessKey, String? userSecurityKey, String url) {
    return apiClient.getVisitData(accessKey, userSecurityKey, url);
  }

  getMeetData(String? accessKey, String? userSecurityKey, String url) {
    return apiClient.getMeetData(accessKey, userSecurityKey, url);
  }

  getCalenderPlan(String? accessKey, String? userSecurityKey, String url) {
    return apiClient.getCalendarPlan(accessKey, userSecurityKey, url);
  }

  getCalenderPlanByDay(String? accessKey, String? userSecurityKey, String url) {
    return apiClient.getCalenderPlanByDay(accessKey, userSecurityKey, url);
  }

  getTargetVsActualPlan(String? accessKey, String? userSecurityKey, String url) {
    return apiClient.getTargetSsActualPlan(accessKey, userSecurityKey, url);
  }
}
