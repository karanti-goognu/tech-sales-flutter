

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/KittyBagsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/PendingSupplyDetails.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteVisitRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/provider/sites_provider.dart';

class MyRepositorySites {
  final MyApiClientSites apiClient;

  MyRepositorySites({required this.apiClient}) ;

  getFilterData(String accessKey) {
    return apiClient.getFilterData(accessKey);
  }

  getSitesData(String? accessKey, String securityKey, String url) {
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


  getSitedetailsData(
      String? accessKey, String? userSecurityKey, int? siteId, String? empID) {
    return apiClient.getSiteDetailsData(
        accessKey, userSecurityKey, siteId, empID);
  }
  getSiteFloorList(String accessKey, String userSecurityKey, int stageId,dynamic siteId){
    return apiClient.getSiteFloorList(accessKey, userSecurityKey, stageId, siteId);
  }


  updateSiteData(accessKey, String? userSecurityKey, updateDataRequest,
      List<File> list, BuildContext context, int? siteId) {
    return apiClient.updateVersion2SiteData(
        accessKey, userSecurityKey, updateDataRequest, list, context, siteId);
  }

  Future<SitesListModel?> getSearchDataNew(String? accessKey,
      String? userSecurityKey, String? empID, String searchText) {
    return apiClient.getSearchDataNew(
        accessKey, userSecurityKey, empID, searchText);
  }

  Future<SiteVisitResponseModel?>siteVisitSave(String? accessKey,
      String? userSecretKey, SiteVisitRequestModel siteVisitRequestModel) async {
    return apiClient.siteVisitSave(
        accessKey, userSecretKey, siteVisitRequestModel);
  }

  getPendingSupplyData(String? accessKey, String securityKey, String url) {
    return apiClient.getPendingSupplyData(accessKey, securityKey, url);
  }

  getPendingSupplyDetails(String? accessKey, String securityKey, String url) {
    return apiClient.getPendingSupplyDetails(accessKey, securityKey, url);
  }

  Future<PendingSuppliesDetailsModel?> getPendingSupplyDetailsNew(
      String accessKey, String? userSecretKey, String url) async {
    return apiClient.getPendingSupplyDetailsNew(accessKey, userSecretKey, url);
  }

  updatePendingSupplyDetails(String? accessKey, String securityKey, String url,Map<String, dynamic> jsonData) {
    return apiClient.updatePendingSupplyDetails(accessKey, securityKey, url,jsonData);
  }

  Future<SiteDistrictListModel?> getSiteDistList(String? accessKey, String? userSecretKey, String empID) async {
    return apiClient.getSiteDistList(accessKey, userSecretKey, empID);
  }


  Future<KittyBagsListModel?> getKittyBagsList(String? accessKey, String? partyCode, String? userSecretKey) async {
    return apiClient.getKittyBagsList(accessKey, partyCode, userSecretKey);
  }


}