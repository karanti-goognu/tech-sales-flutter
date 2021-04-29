import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/gifts_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GiftController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
  final GiftsRepository repository;

  GiftController({@required this.repository}) : assert(repository != null);

  final _giftStockModel = GetGiftStockModel().obs;
  final _giftStockModelList= List<GiftStockModelList>().obs;
  final _giftTypeModelList= List<GiftTypeModelList>().obs;
  final _selectedDropdown =0.obs;

  get selectedDropdown => _selectedDropdown.value;

  set selectedDropdown(value) {
    _selectedDropdown.value = value;
  }

  get giftTypeModelList => _giftTypeModelList;

  set giftTypeModelList(value) {
    _giftTypeModelList.value = value;
  }

  get giftStockModelList => _giftStockModelList;

  set giftStockModelList(value) {
    _giftStockModelList.value = value;
  }

  get giftStockModel => _giftStockModel.value;

  set giftStockModel(value) {
    _giftStockModel.value = value;
  }

  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
  }

  Future getGiftStockData() async {
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      String empID= prefs.getString(StringConstants.employeeId);
      giftStockModel = await repository.getGiftStockData(empID);
      giftStockModelList= giftStockModel.giftStockModelList;
      giftTypeModelList= giftStockModel.giftTypeModelList;
      print(giftTypeModelList);



    });
    Get.back();
    return giftStockModel;
  }

  Future addGiftStock() async {
    var response;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      String empID= prefs.getString(StringConstants.employeeId);
       response = await repository.addGiftStockData(empID);
    });
    Get.back();
    return response;
  }

}