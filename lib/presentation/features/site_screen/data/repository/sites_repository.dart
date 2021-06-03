import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SiteVisitRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/Data/provider/sites_provider.dart';
import 'package:meta/meta.dart';

class MyRepositorySites {
  final MyApiClientSites apiClient;

  MyRepositorySites({@required this.apiClient}) : assert(apiClient != null);

  getFilterData(String accessKey) {
    return apiClient.getFilterData(accessKey);
  }

  getSitesData(String accessKey, String securityKey, String url) {
    return apiClient.getSitesData(accessKey, securityKey, url);
  }

  getSearchData(String accessKey, String securityKey, String url) {
    return apiClient.getSearchData(accessKey, securityKey, url);
  }

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getSecretKey(String empId, String mobileNumber) {
    return apiClient.getSecretKey(empId, mobileNumber);
  }

  Future getAccessKeyNew() {
    return apiClient.getAccessKeyNew();
  }

  // getSitedetailsData(String accessKey, String userSecurityKey, int siteId, String empID) {
  // return apiClient.getSiteDetailsData(accessKey, userSecurityKey, siteId, empID);
  //}
//r, String empIDeturn apiClient.getSiteDetailsData(accessKey, userSecurityKey, siteId, empID);
  // getSitedetailsData(String accessKey, String userSecurityKey, int siteId) {
  //   return apiClient.getSiteDetailsData(accessKey, userSecurityKey, siteId);
  // }

  getSitedetailsData(
      String accessKey, String userSecurityKey, int siteId, String empID) {
    return apiClient.getSiteDetailsData(
        accessKey, userSecurityKey, siteId, empID);
  }

  updateSiteData(accessKey, String userSecurityKey, updateDataRequest,
      List<File> list, BuildContext context, int siteId) {
    return apiClient.updateSiteData(
        accessKey, userSecurityKey, updateDataRequest, list, context, siteId);
  }

  Future<SitesListModel> getSearchDataNew(String accessKey,
      String userSecurityKey, String empID, String searchText) {
    return apiClient.getSearchDataNew(
        accessKey, userSecurityKey, empID, searchText);
  }

  Future<SiteVisitResponseModel>siteVisitSave(String accessKey,
      String userSecretKey, SiteVisitRequestModel siteVisitRequestModel) async {
    return apiClient.siteVisitSave(
        accessKey, userSecretKey, siteVisitRequestModel);
  }

//getSiteData(String accessKey, String userSecurityKey, int leadId) {}

}