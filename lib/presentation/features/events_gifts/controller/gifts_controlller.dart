import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/gifts_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/saveVisitResponse.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/LogsModel.dart';


class GiftController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
  final GiftsRepository repository;

  GiftController({@required this.repository}) : assert(repository != null);

  final _giftStockModel = GetGiftStockModel().obs;
  final _giftStockModelList= List<GiftStockModelList>.empty(growable: true).obs;
  final _giftStockModelList1= List<GiftStockModelList>.empty(growable: true).obs;
  final _giftTypeModelList= List<GiftTypeModelList>.empty(growable: true).obs;
  final _selectedDropdown =0.obs;
  final _itemFromBottomSheetTapped = false.obs;
  final _logsModel = LogsModel().obs;
  final _dataForViewLog = List<GiftStockList>.empty(growable: true).obs;
  final _monthYear = ''.obs;


  get monthYear => _monthYear;

  set monthYear(value) {
    _monthYear.value = value;
  }

  get dataForViewLog => _dataForViewLog;

  set dataForViewLog(value) {
    _dataForViewLog.value = value;
  }

  get logsModel => _logsModel.value;

  set logsModel(value) {
    _logsModel.value = value;
  }

  get itemFromBottomSheetTapped => _itemFromBottomSheetTapped;

  set itemFromBottomSheetTapped(value) {
    _itemFromBottomSheetTapped.value = value;
    print(_itemFromBottomSheetTapped.value );
  }

  get selectedDropdown => _selectedDropdown.value;

  set selectedDropdown(value) {
    print(selectedDropdown);
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

  get giftStockModelList1 => _giftStockModelList1;

  set giftStockModelList1(value) {
    _giftStockModelList1.assignAll(value);
  }

  get giftStockModel => _giftStockModel.value;

  set giftStockModel(value) {
    _giftStockModel.value = value;
  }

  Future<String> getAccessKey() {
    return repository.getAccessKey();
  }

  Future getGiftStockData() async {
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false));
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    await _prefs.then((SharedPreferences prefs) async {
      String empID= prefs.getString(StringConstants.employeeId);
      String securityKey = prefs.getString(StringConstants.userSecurityKey);
      giftStockModel = await repository.getGiftStockData(empID, accessKey, securityKey);
      giftStockModelList= giftStockModel.giftStockModelList;
      giftTypeModelList= giftStockModel.giftTypeModelList;
      print(giftTypeModelList);
    });
    Get.back();
    return giftStockModel;
  }

  Future addGiftStock({String comment, String giftTypeId, String giftTypeText,String giftInHandQty,String giftInHandQtyNew}) async {
    SaveVisitResponse response;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false));
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    await _prefs.then((SharedPreferences prefs) async {
      String empID= prefs.getString(StringConstants.employeeId);
      String securityKey = prefs.getString(StringConstants.userSecurityKey);
      response = await repository.addGiftStockData(empID,securityKey,accessKey,comment,giftTypeId,giftTypeText,giftInHandQty,giftInHandQtyNew);
      print(response.respMsg);
    });
    Get.back();
    Get.rawSnackbar(title: "Message", message: response.respMsg);

    return response;
  }
  Future getViewLogsData(String monthYear) async {
    print(monthYear);
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator()), barrierDismissible: false));
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    await _prefs.then((SharedPreferences prefs) async {
      String empID= prefs.getString(StringConstants.employeeId);
      String securityKey = prefs.getString(StringConstants.userSecurityKey);
      logsModel = await repository.getViewLogsData(accessKey, securityKey,empID, monthYear);
      Get.back();
      if(logsModel.respCode=="DM1006"){
        Get.dialog(CustomDialogs().showMessage(logsModel.respMsg));
        dataForViewLog=<GiftStockList>[];
      }
      else{
        Get.dialog(CustomDialogs().showMessage(logsModel.respMsg));
        dataForViewLog=logsModel.giftStockModelList;
      }

    });
    return logsModel;
  }
  Future getViewLogsData1(List<GiftStockModelList> giftStockModelList) async {
    List<GiftStockModelList> _giftStockModelList = [];

    for(int i=1 ; i<giftStockModelList.length;i++){
      _giftStockModelList.add(giftStockModelList[i]);
    }
    giftStockModelList1 = _giftStockModelList ;
    return _giftStockModelList;
  }

}