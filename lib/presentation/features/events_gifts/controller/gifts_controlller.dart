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

  get giftStockModel => _giftStockModel;

  set giftStockModel(value) {
    _giftStockModel.value = value;
  }

  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
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