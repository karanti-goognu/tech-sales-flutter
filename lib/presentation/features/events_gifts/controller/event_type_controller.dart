import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
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
  final _giftStockModel = GetGiftStockModel().obs;

  get giftStockModel => _giftStockModel;

  set giftStockModel(value) {
    _giftStockModel.value = value;
  }

  Future<AccessKeyModel> getAccessKey() {
    // print(repository.getAccessKey().then((value) => value.accessKey));
    return repository.getAccessKey();
  }

  Future<AddEventModel> getEventType(String accessKey) async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
//    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      // print(userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: $empID');
      egTypeDaa = await repository.getEventTypeData(accessKey, userSecurityKey, empID);
    });
//    Get.back();
    return egTypeDaa;
  }

  Future<GetGiftStockModel> getGiftStockData() async {
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
    String empID= prefs.getString(StringConstants.employeeId);
      giftStockModel = await repository.getGiftStockData(empID);

    });
    print(giftStockModel);
    Get.back();
    return giftStockModel;
  }


}