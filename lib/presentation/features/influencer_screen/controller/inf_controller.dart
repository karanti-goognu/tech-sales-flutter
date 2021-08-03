import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailDataModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/repository/inf_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final InfRepository repository;

  InfController({@required this.repository})
      : assert(repository != null);


  final _infResponse = InfluencerTypeModel().obs;
  final _distResponse = StateDistrictListModel().obs;
  final _infListResponse = InfluencerListModel().obs;


  final _offset = 0.obs;
  final _inflTypeId = StringConstants.empty.obs;
  final _name = StringConstants.empty.obs;
  final _mobileNumber = StringConstants.empty.obs;
  final _ditrictName = StringConstants.empty.obs;

  get infResponse => _infResponse.value;
  get distResponse => _distResponse.value;
  get infListResponse => _infListResponse.value;

  get offset => this._offset.value;
  get inflTypeId => this._inflTypeId.value;
  get name => this._name.value;
  get mobileNumber => this._mobileNumber.value;
  get ditrictName => this._ditrictName.value;



  set infResponse(value) => _infResponse.value = value;
  set distResponse(value) => _distResponse.value = value;
  set infListResponse(value) => _infListResponse.value = value;

  set offset(value) => this._offset.value = value;
  set inflTypeId(value) => this._inflTypeId.value = value;
  set name(value) => this._name.value = value;
  set mobileNumber(value) => this._mobileNumber.value = value;
  set ditrictName(value) => this._ditrictName.value = value;

  Future<String> getAccessKey() {
    return repository.getAccessKey();
  }


  Future<InfluencerTypeModel> getInfType() async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      infResponse =
      await repository.getInfTypeData(accessKey, userSecurityKey, empID);
    });
    return infResponse;
  }

  Future<StateDistrictListModel> getDistList() async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      distResponse =
      await repository.getDistList(accessKey, userSecurityKey, empID);
    });
    return distResponse;
  }

  Future<InfluencerDetailModel> getInfData(String contact) async {
    InfluencerDetailModel _infDetailModel;
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
    //Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      _infDetailModel = await repository.getInfData(accessKey, userSecurityKey, contact);
    });
    return _infDetailModel;
  }

  getAccessKeyAndSaveInfluencer(
      InfluencerRequestModel influencerRequestModel, bool status ) {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    _prefs.then((SharedPreferences prefs) async {
      String accessKey = await repository.getAccessKey();
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      await repository.saveInfluencerForm(accessKey, userSecurityKey, influencerRequestModel, status)
          .then((value) {
        //Get.back();
        if (value.response.respCode == 'INF2001') {
          Get.dialog(
              CustomDialogs().showDialogSubmitInfluencer(value.response.respMsg.toString()),
              barrierDismissible: false);
        }else if (value.response.respCode == 'INF2002') {
          Get.dialog(
              CustomDialogs().showDialogSubmitInfluencer(value.response.respMsg.toString()),
              barrierDismissible: false);
        }
        else {
          // Get.back();
          Get.dialog(
              CustomDialogs().messageDialogMWP(value.response.respMsg.toString()),
              barrierDismissible: false);
        }
      });
    });
  }


  Future<InfluencerListModel> getInfluencerList() async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);

      String infId = "";
      if (this.inflTypeId != StringConstants.empty) {
        infId = "&inflTypeId%20=${this.inflTypeId}";
      }

      String infName = "";
      if (this.name != StringConstants.empty) {
        infName = "&name=${this.name}";
      }

      String infMobile = "";
      if (this.mobileNumber != StringConstants.empty) {
        infMobile = "&mobileNumber%20=${this.mobileNumber}";
      }

      String infDist= "";
      if (this.ditrictName != StringConstants.empty) {
        infDist = "&ditrictName%20=${this.ditrictName}";
      }

      var url = "${UrlConstants.getInfluencerList}$empID$infId$infName$infMobile$infDist";
      print("===============$url");
      infListResponse =
      await repository.getInfluencerList(accessKey, userSecurityKey, url);
    });
    return infListResponse;
  }


  Future<InfluencerDetailDataModel> getInfDetailData(String membershipId) async {
    InfluencerDetailDataModel _influencerDetailDataModel;
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
    //Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      _influencerDetailDataModel = await repository.getInfDetailData(accessKey, userSecurityKey, membershipId);
    });
    return _influencerDetailDataModel;
  }


  getAccessKeyAndUpdateInfluencer(
      InfluencerRequestModel influencerRequestModel ) {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    _prefs.then((SharedPreferences prefs) async {
      String accessKey = await repository.getAccessKey();
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      await repository.updateInfluencerForm(accessKey, userSecurityKey, influencerRequestModel)
          .then((value) {
        //Get.back();
        if (value.response.respCode == 'INF2002') {
          Get.dialog(
              CustomDialogs().showDialogSubmitInfluencer(value.response.respMsg.toString()),
              barrierDismissible: false);
        }
        else {
          // Get.back();
          Get.dialog(
              CustomDialogs().messageDialogMWP(value.response.respMsg.toString()),
              barrierDismissible: false);
        }
      });
    });
  }
}
