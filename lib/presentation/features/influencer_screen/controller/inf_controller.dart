import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerTypeModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/StateDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/repository/inf_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
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

  get infResponse => _infResponse.value;
  get distResponse => _distResponse.value;
  get infListResponse => _infListResponse.value;

  set infResponse(value) => _infResponse.value = value;
  set distResponse(value) => _distResponse.value = value;
  set infListResponse(value) => _infListResponse.value = value;

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
      InfluencerRequestModel influencerRequestModel ) {
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    _prefs.then((SharedPreferences prefs) async {
      String accessKey = await repository.getAccessKey();
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      await repository.saveInfluencerForm(accessKey, userSecurityKey, influencerRequestModel)
          .then((value) {
        //Get.back();
        if (value.response.respCode == 'INF2001') {
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
      infListResponse =
      await repository.getInfluencerList(accessKey, userSecurityKey, empID);
    });
    return infListResponse;
  }
}
