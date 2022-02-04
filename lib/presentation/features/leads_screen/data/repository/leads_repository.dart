import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteDistrictListModel.dart';

class MyRepositoryLeads {
  final MyApiClientLeads apiClient;

  MyRepositoryLeads({@required this.apiClient}) : assert(apiClient != null);

  Future getAccessKeyNew() {
    return apiClient.getAccessKeyNew();
  }

  getFilterData(String accessKey) {
    return apiClient.getFilterData(accessKey);
  }

  getLeadsData(String accessKey, String securityKey, String url) {
    return apiClient.getLeadsData(accessKey, securityKey, url);
  }

  getSearchData(String accessKey, String securityKey, String url) {
    return apiClient.getSearchData(accessKey, securityKey, url);
  }

  Future<LeadsListModel>getSearchDataNew(String accessKey, String userSecurityKey,
      String empID, String searchText) {
    return apiClient.getSearchDataNew(accessKey, userSecurityKey, empID, searchText);
  }

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getSecretKey(String empId, String mobileNumber) {
    return apiClient.getSecretKey(empId, mobileNumber);
  }

  getAddLeadsData(String accessKey, String userSecurityKey) {
    //  print("dhawan : "+userSecurityKey);
    return apiClient.getAddLeadsData(accessKey, userSecurityKey);
  }

  getInflDetailsData(accessKey, String userSecurityKey, phoneNumber) {
    return apiClient.getInflDetailsData(
        accessKey, userSecurityKey, phoneNumber);
  }

  saveLeadsData( accessKey,  String userSecurityKey, SaveLeadRequestModel saveLeadRequestModel, List<File> imageList,   BuildContext context) {
    return apiClient.saveLeadsData(
        accessKey, userSecurityKey, saveLeadRequestModel, imageList, context);
  }

  getLeadData(String accessKey, String userSecurityKey, int leadId, String empId) {
    return apiClient.getLeadData(accessKey, userSecurityKey, leadId, empId);
  }

  getLeadDataNew(String accessKey, String userSecurityKey, int leadId, String empId) {
    return apiClient.getLeadDataNew(accessKey, userSecurityKey, leadId, empId);
  }

  updateLeadsData(accessKey, String userSecurityKey, var updateRequestModel,
      List<File> imageList, BuildContext context, int leadId, int from) {
    return apiClient.updateLeadsData(accessKey, userSecurityKey,
        updateRequestModel, imageList, context, leadId,from);
  }

  getInflNewDetailsData(String accessKey, String userSecurityKey, phoneNumber) {
    return apiClient.getInfNewData(
        accessKey, userSecurityKey, phoneNumber);
  }

  Future<SiteDistrictListModel> getLeadDistList(String accessKey, String userSecretKey, String empID) async {
    return apiClient.getLeadDistList(accessKey, userSecretKey, empID);
  }


}
