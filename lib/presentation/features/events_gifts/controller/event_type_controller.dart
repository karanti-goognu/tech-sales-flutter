import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventTypeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final EgRepository repository;

  EventTypeController({@required this.repository})
      : assert(repository != null);
  final _egTypeData = AddEventModel().obs;
  get egTypeDaa => _egTypeData.value;
  set egTypeDaa(value) => _egTypeData.value = value;

  Future<AccessKeyModel> getAccessKey() {
    // print(repository.getAccessKey().then((value) => value.accessKey));
    return repository.getAccessKey();
  }

  Future<AddEventModel> getEventType(String accessKey) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      // print(userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: ${empID}');
      egTypeDaa = await repository.getEventTypeData(accessKey, userSecurityKey, empID);
    });
    return egTypeDaa;
  }
}