import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/GetMWPResponse.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMWPResponse.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MWPPlanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  MWPPlanController({@required this.repository}) : assert(repository != null);

  final _saveMWPResponse = new SaveMWPResponse().obs;
  final _getMWPResponse = new GetMWPResponse().obs;

  final _isLoading = false.obs;
  final _totalConversionVol = 0.obs;
  final _newILPMembers = 0.obs;
  final _dspSlab = 0.obs;
  final _siteConVol = 0.obs;
  final _siteConNo = 0.obs;
  final _siteVisitsTotal = 0.obs;
  final _siteVisitsUnique = 0.obs;
  final _influencerVisit = 0.obs;
  final _masonMeet = 0.obs;
  final _counterMeet = 0.obs;
  final _contractorMeet = 0.obs;
  final _miniContractorMeet = 0.obs;
  final _consumerMeet = 0.obs;
  final _action = "SAVE".obs;
  final _selectedMonth = StringConstants.empty.obs;

  set isLoading(value) => this._isLoading.value = value;

  set saveMWPResponse(value) => this._saveMWPResponse.value = value;

  set action(value) => this._action.value = value;

  get saveMWPResponse => this._saveMWPResponse.value;

  get action => this._action.value;

  get isLoading => this._isLoading.value;

  set getMWPResponse(value) => this._getMWPResponse.value = value;

  get getMWPResponse => this._getMWPResponse.value;

  set selectedMonth(value) => this._selectedMonth.value = value;

  get selectedMonth => this._selectedMonth.value;

  set totalConversionVol(value) => this._totalConversionVol.value = value;

  get totalConversionVol => this._totalConversionVol.value;

  get newILPMembers => this._newILPMembers.value;

  set newILPMembers(value) => this._newILPMembers.value = value;

  get dspSlab => this._dspSlab.value;

  set dspSlab(value) => this._dspSlab.value = value;

  get siteConVol => _siteConVol.value;

  set siteConVol(value) => _siteConVol.value = value;

  get siteConNo => _siteConNo.value;

  set siteConNo(value) => _siteConNo.value = value;

  get siteVisitsTotal => _siteVisitsTotal.value;

  set siteVisitsTotal(value) => _siteVisitsTotal.value = value;

  get siteVisitsUnique => _siteVisitsUnique.value;

  set siteVisitsUnique(value) => _siteVisitsUnique.value = value;

  get influencerVisit => _influencerVisit.value;

  set influencerVisit(value) => _influencerVisit.value = value;

  get masonMeet => _masonMeet.value;

  set masonMeet(value) => _masonMeet.value = value;

  get counterMeet => _counterMeet.value;

  set counterMeet(value) => _counterMeet.value = value;

  get contractorMeet => _contractorMeet.value;

  set contractorMeet(value) => _contractorMeet.value = value;

  get miniContractorMeet => _miniContractorMeet.value;

  set miniContractorMeet(value) => _miniContractorMeet.value = value;

  get consumerMeet => _consumerMeet.value;

  set consumerMeet(value) => _consumerMeet.value = value;

  saveMWPPlan(String accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');

      SaveMWPModel saveMWPModel = new SaveMWPModel(
          this.selectedMonth,
          empId,
          this.totalConversionVol,
          this.newILPMembers,
          this.dspSlab,
          this.siteConVol,
          this.siteConNo,
          this.siteVisitsTotal,
          this.siteVisitsUnique,
          this.influencerVisit,
          this.masonMeet,
          this.counterMeet,
          this.contractorMeet,
          this.miniContractorMeet,
          this.consumerMeet,
         this.action,
          empId,
          empId);

      debugPrint('Save MWP Model : ${json.encode(saveMWPModel)}');
      String url = "${UrlConstants.saveMWPData}";
      debugPrint('Url is : $url');
      repository
          .saveMWPPlan(accessKey, userSecurityKey, url, saveMWPModel)
          .then((data) {
        if (data == null) {
          debugPrint('MWP Data Response is null');
        } else {
          debugPrint('MWP Data Response is not null');
          this.saveMWPResponse = data;
          if (saveMWPResponse.respCode == "MWP2007") {
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveMWPResponse.respMsg));
            print('${saveMWPResponse.respMsg}');
            //SitesDetailWidget();
          } else if (saveMWPResponse.respCode == "MWP2011") {
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveMWPResponse.respMsg));
            print('${saveMWPResponse.respMsg}');
            //SitesDetailWidget();
          } else if (saveMWPResponse.respCode == "MWP2016") {
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveMWPResponse.respMsg));
            print('${saveMWPResponse.respMsg}');
            //SitesDetailWidget();
          } else {
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveMWPResponse.respMsg));
          }
        }
      });
    });
  }

  getMWPPlan(String accessKey) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.getMWPData +"referenceID=$empId&"+ "monthYear=${this.selectedMonth}";
      print('$url');
      repository.getMWPPlan(accessKey, userSecurityKey, url).then((data) {
        this.isLoading = false;
        if (data == null) {
          debugPrint('MWP Data Response is null');
        } else {
          debugPrint('MWP Data Response is not null');
          this.getMWPResponse = data;
          this.isLoading = false;
          if (getMWPResponse.respCode == "MWP2013") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            print('${getMWPResponse.respMsg}');
            //SitesDetailWidget();
          } else {
            Get.dialog(CustomDialogs().errorDialog(saveMWPResponse.respMsg));
          }
        }
      });
    });
  }
}
