
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/DealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/InfDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/UpdateDealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsFilterController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen
    super.onReady();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory
    super.onClose();
  }

  final EgRepository repository;

  EventsFilterController({@required this.repository})
      : assert(repository != null);


  final _egApprovedEventData = ApprovedEventsModel().obs;

  get egApprovedEventDaa => _egApprovedEventData.value;

  set egApprovedEventDaa(value) => _egApprovedEventData.value = value;

  final _infDetailModel = InfDetailModel().obs;
  get infDetailModel => _infDetailModel.value;
  set infDetailModel(value) => _infDetailModel.value = value;



  Future<String> getAccessKey() {
    return repository.getAccessKey();
  }

  Future<ApprovedEventsModel> getApprovedEventData() async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
//    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      // print(userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: $empID');
      egApprovedEventDaa =
      await repository.getApprovedEvents(accessKey, userSecurityKey, empID);
    });
//    Get.back();
    return egApprovedEventDaa;
  }


  getAccessKeyAndStartEvent(StartEventModel startEventModel) {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) async {
      String accessKey = await repository.getAccessKey();
      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        repository.startEvent(accessKey, userSecurityKey, startEventModel)
            .then((value) {
          //Get.back();
          if (value.respCode == 'DM2043') {
            Get.back();
            Get.defaultDialog(
                title: "Message",
                middleText: value.respMsg.toString(),
                confirm: MaterialButton(
                  onPressed: () => Get.back(),
                  child: Text('OK'),
                ),
                barrierDismissible: false);
          } else {
            Get.back();
            Get.dialog(
                CustomDialogs().messageDialogMWP(value.respMsg.toString()),
                barrierDismissible: false);
          }
        });
      });
    });
  }


  Future<DealerInfModel> getDealerInfList(int eventId) async {
    DealerInfModel _dealerInfModel;
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    var accessKey = await repository.getAccessKey();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: $empID');
      _dealerInfModel =
      await repository.getDealerInfList(accessKey, userSecurityKey, empID, eventId);
    });
//    Get.back();
    return _dealerInfModel;
  }

  getAccessKeyAndSaveDealerInf(UpdateDealerInfModel updateDealerInfModel) {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) async {
      String accessKey = await repository.getAccessKey();
      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        repository.updateDealerInf(accessKey, userSecurityKey, updateDealerInfModel)
            .then((value) {
          //Get.back();
          if (value.respCode == 'DM2043') {
            Get.back();
            Get.defaultDialog(
                title: "Message",
                middleText: value.respMsg.toString(),
                confirm: MaterialButton(
                  onPressed: () => Get.back(),
                  child: Text('OK'),
                ),
                barrierDismissible: false);
          } else {
            Get.back();
            Get.dialog(
                CustomDialogs().messageDialogMWP(value.respMsg.toString()),
                barrierDismissible: false);
          }
        });
      });
    });
  }


  Future<InfDetailModel> getInfData(String contact) async {
    InfDetailModel _infDetailModel;
   // InfDetailsModel _infDetailsModel;

    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
//    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      _infDetailModel = await repository.getInfData(accessKey, userSecurityKey, contact);
      //     .then((value) {
      //   if(value.respCode == "DM1002"){
      //         return _infDetailModel;
      //   }else if(value.respCode == "NUM404") {
      //     return _infDetailsModel;
      //   }
      // });
    });
//    Get.back();
    return _infDetailModel;
  }
}



