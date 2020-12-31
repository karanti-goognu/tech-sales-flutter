// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
// import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
// import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
// import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ComplaintViewController extends GetxController{
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   final SrRepository repository;
//   ComplaintViewController({@required this.repository}) : assert(repository != null);
//
//   final _complaintListData  = ComplaintViewModel().obs;
//
//   get complaintListData => _complaintListData;
//
//   set complaintListData(value) {
//     _complaintListData.value = value;
//   }
//
//   Future<AccessKeyModel> getAccessKey(){
//     return repository.getAccessKey();
//   }
//
//   Future<ComplaintViewModel>  getComplaintViewData(String accessKey, String id) async {
//     String userSecurityKey = "";
//     String empID = "";
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     try{
//       await _prefs.then((SharedPreferences prefs) async {
//         userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
//         empID = prefs.getString(StringConstants.employeeId);
//         complaintListData = await repository.getComplaintViewData(accessKey,userSecurityKey, empID, id);
//       });
//       print(json.encode(complaintListData));
//       return complaintListData;
//     }
//     catch(e){
//       print(e);
//     }
//   }
//
// }