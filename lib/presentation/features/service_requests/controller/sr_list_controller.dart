

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SRListController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final SrRepository repository;
  SRListController({required this.repository}) : assert(repository != null);

  final _offset = 0.obs;
  get offset => this._offset.value;

  set offset(value) => this._offset.value = value;

  final _srListData = ServiceRequestComplaintListModel().obs;
  get srListData => _srListData.value;
  set srListData(value) => _srListData.value = value;

  final Rx<ServiceRequestComplaintListModel?> _siteListData = ServiceRequestComplaintListModel().obs;
  get siteListData => _siteListData.value;
  set siteListData(value) => _siteListData.value = value;

  ServiceRequestComplaintListModel? _filteredListData = ServiceRequestComplaintListModel();
  get filteredListData => _filteredListData;
  set filteredListData(value) => _filteredListData = value;


  showNoInternetSnack() {
    Get.snackbar(
        "No internet connection.", "Please check your internet connection.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<AccessKeyModel?> getAccessKey() {
    return repository.getAccessKey();
  }


  Future<ServiceRequestComplaintListModel> getSrListData(
      String? accessKey, int offset) async {
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
       await repository.getSrListData(accessKey, userSecurityKey, empID!, this.offset).then((data){
         if (data == null) {
           debugPrint('SR Data Response is null');
         } else {
           if (srListData.srComplaintListModal == null ||
               srListData.srComplaintListModal.isEmpty) {
               srListData = data;
           } else {
             ServiceRequestComplaintListModel requestComplaintListModel = data;
             if (requestComplaintListModel!=null && requestComplaintListModel.srComplaintListModal!=null) {
               requestComplaintListModel.srComplaintListModal!.addAll(srListData.srComplaintListModal);
               this.srListData = requestComplaintListModel;
               this.srListData.srComplaintListModal.sort((SrComplaintListModal a, SrComplaintListModal b) => b.createdOn!.compareTo(a.createdOn!));
               Get.rawSnackbar(
                 titleText: Text("Note"),
                 messageText: Text("Loading more .."),
                 backgroundColor: Colors.white,
               );
             } else {
               Get.rawSnackbar(
                 titleText: Text("Note"),
                 messageText: Text("No more SR Data..."),
                 backgroundColor: Colors.white,
               );
             }
           }
         }
       });

    });
    return srListData;
  }

  Future<ServiceRequestComplaintListModel?> getSrListDataWithFilters(
      String? accessKey,
      String? resolutionStatusId,
      String? severity,
      String? typeOfReqId) async {
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      filteredListData = await repository.getSrListDataWithFilters(accessKey,
          userSecurityKey, empID!, resolutionStatusId!, severity!, typeOfReqId!);
    });
    return filteredListData;
  }

  Future<ServiceRequestComplaintListModel?> getSiteListData(
      String? accessKey, String? siteID) async {
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      siteListData = await repository.getSiteListData(
          accessKey, userSecurityKey, empID!, siteID!);
    });
    return siteListData;
  }


}
