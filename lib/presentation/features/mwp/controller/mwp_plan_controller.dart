

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/GetMWPResponse.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPResponse.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MWPPlanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  MWPPlanController({required this.repository}) : assert(repository != null);

  final _saveMWPResponse = new SaveMWPResponse().obs;
  final  _getMWPResponse = new GetMWPResponse().obs;

  final _mwpPlannigList = List<MwpPlannigList>.empty(growable: true).obs;

  final _selectedMwpPlannigList = List<MwpPlannigList>.empty(growable: true).obs;


  final _isLoading = false.obs;
  final _action = "SAVE".obs;
  final _selectedMonth = StringConstants.empty.obs;
  get mwpPlannigList => _mwpPlannigList;

  set mwpPlannigList(value) {
    this._mwpPlannigList.value = value;
  }

  get selectedMwpPlannigList => _selectedMwpPlannigList;

  set selectedMwpPlannigList(value) {
    this._selectedMwpPlannigList.value = value;
  }

  get isLoading => this._isLoading.value;

  set isLoading(value) => this._isLoading.value = value;

  get getMWPResponse => this._getMWPResponse.value;

  set getMWPResponse(value) => this._getMWPResponse.value = value;

  get saveMWPResponse => this._saveMWPResponse.value;

  set saveMWPResponse(value) => this._saveMWPResponse.value = value;

  get action => this._action.value;

  set action(value) => this._action.value = value;

  get selectedMonth => this._selectedMonth.value;

  set selectedMonth(value) => this._selectedMonth.value = value;


  saveMWPPlan(String accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";

      SaveMWPModel saveMWPModel = new SaveMWPModel(
          this.selectedMonth,
          empId,
          this.action,
          empId,
          empId,
          this.selectedMwpPlannigList
      );
      String url = "${UrlConstants.saveMWPData}";
      repository
          .saveMWPPlan(accessKey, userSecurityKey, url, saveMWPModel)
          .then((data) {
        if (data != null) {
          this.saveMWPResponse = data;
          if (saveMWPResponse.respCode == "MWP2007") {
            Get.dialog(CustomDialogs().messageDialogMWP(saveMWPResponse.respMsg),barrierDismissible: false);
          } else if (saveMWPResponse.respCode == "MWP2011") {
            Get.dialog(CustomDialogs().messageDialogMWP(saveMWPResponse.respMsg),barrierDismissible: false);
          } else if (saveMWPResponse.respCode == "MWP2016") {
            Get.dialog(CustomDialogs().messageDialogMWP(saveMWPResponse.respMsg),barrierDismissible: false);
          } else {Get.dialog(CustomDialogs().messageDialogMWP(saveMWPResponse.respMsg),barrierDismissible: false);
          }
        } else {
          debugPrint('MWP Data Response is null');
        }
      });
    });
  }

  getMWPPlan(String accessKey) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String? userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String? empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.getMWPData +
          "referenceID=$empId&" +
          "monthYear=${this.selectedMonth}";
      repository.getMWPPlan(accessKey, userSecurityKey, url).then((data) {
        this.isLoading = false;
        if(data == null){
          this.getMWPResponse = data;
          debugPrint('MWP Data Response is null');
        } else {
          this.getMWPResponse = data;
          this.isLoading = false;
          if (getMWPResponse.respCode == "MWP2013") {
            this.mwpPlannigList = this.getMWPResponse.mwpPlannigList;
           } else {
            Get.dialog(CustomDialogs().errorDialog(saveMWPResponse.respMsg),barrierDismissible: false);
          }
        }
      });
    });
  }
}
