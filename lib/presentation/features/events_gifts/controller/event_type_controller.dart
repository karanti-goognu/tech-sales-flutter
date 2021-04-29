import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/GetGiftStockModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/addEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
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
  final _addEventResponse = AddEventModel().obs;
  final _dealerList = List<DealerModel>().obs;
  final _dealerListSelected = List<DealerModelSelected>().obs;

  get addEventResponse => _addEventResponse.value;
  get dealerList => this._dealerList;
  get dealerListSelected => this._dealerListSelected;

  set addEventResponse(value) => _addEventResponse.value = value;
  set dealerList(value) => this._dealerList.value = value;
  set dealerListSelected(value) => this._dealerListSelected.value = value;




  Future<AccessKeyModel> getAccessKey() {
    // print(repository.getAccessKey().then((value) => value.accessKey));
    return repository.getAccessKey();
  }

//   getDealerList(String accessKey) async {
//     Future.delayed(
//         Duration.zero,
//             () => Get.dialog(Center(child: CircularProgressIndicator()),
//             barrierDismissible: false));
//     // this.isLoading = true;
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     _prefs.then((SharedPreferences prefs) {
//       String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
//       String empId = prefs.getString(StringConstants.employeeId);
//       String url = UrlConstants.getAddEvent + "$empId";
//
//       repository.getEventTypeData(accessKey, userSecurityKey, empId);
//       //     .then((data){
//       //   if (data == null) {
//       //     debugPrint('Dealer List Response is null');
//       //   } else {
//       //     debugPrint('Dealer List Response is not null');
//       //     this.addEventResponse = data;
//       //     if (data.dealersModels.length != 0) {
//       //       for (int i = 0;
//       //       i < data.dealersModels.length ;
//       //       i++) {
//       //         this.dealerList.add(new DealerModel(
//       //           data.dealersModels[i].dealerId,
//       //             data.dealersModels[i].dealerName,
//       //             false));
//       //       }
//       //     }
//       //   }
//       // });
//     });
// //    Get.back();
//     return egTypeDaa;
//   }

  Future<AddEventModel>getEventType(String accessKey) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: $empID');
      addEventResponse = await repository.getEventTypeData(accessKey, userSecurityKey, empID);
    });
    return addEventResponse;
  }






//   Future<AddEventModel> getInfluencerType(String accessKey, String mobileNo) async {
//     //In case you want to show the progress indicator, uncomment the below code and line 43 also.
//     //It is working fine without the progress indicator
// //    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
//     String userSecurityKey = "";
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//     await _prefs.then((SharedPreferences prefs) async {
//       userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
//       addEventResponse = await repository.getEventTypeData(accessKey, userSecurityKey, mobileNo);
//     });
// //    Get.back();
//     return addEventResponse;
//   }
}