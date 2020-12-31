import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/model/TargetVSActualModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/repository/mwp_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddCalendarEventController extends GetxController{
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  AddCalendarEventController({@required this.repository}) : assert(repository != null);
  final _targetVsActual = TargetVsActualModel().obs;
  get targetVsActual => _targetVsActual.value;
  set targetVsActual(value) =>
    _targetVsActual.value = value;

  getTargetVsActualData(String accessKey) async {
    //debugPrint('Access Key Response :: ');
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('User Security Key :: $userSecurityKey');
      targetVsActual = await repository.getTargetVsActualData(accessKey,userSecurityKey,empID);
    });
     return targetVsActual;
    //print("access" + this.accessKeyResponse.accessKey);
  }

  Future<AccessKeyModel> getAccessKey(){
    return repository.getAccessKey();
  }
}