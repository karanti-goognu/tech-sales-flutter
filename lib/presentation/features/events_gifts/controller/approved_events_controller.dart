
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/DealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/InfDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/SaveNewInfluencerModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/SaveNewInfluencerResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/StartEventResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/UpdateDealerInfModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/UpdateDealerInfResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
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
  String responseForDialog = '';



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


  Future<StartEventResponse>getAccessKeyAndStartEvent(StartEventModel startEventModel) async{
    StartEventResponse _startEventResponse;
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    // Future.delayed(
    //     Duration.zero,
    //         () => Get.dialog(Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));

      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
         _startEventResponse = await repository.startEvent(accessKey, userSecurityKey, startEventModel);
    });
      //Get.back();
      return _startEventResponse;
  }


  Future<DealerInfModel> getDealerInfList(int eventId) async {
    DealerInfModel _dealerInfModel;
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    var accessKey = await repository.getAccessKey();
    // Future.delayed(
    //     Duration.zero,
    //         () => Get.dialog(Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: $empID');
      _dealerInfModel =
      await repository.getDealerInfList(accessKey, userSecurityKey, empID, eventId);
    });
   // Get.back();
    return _dealerInfModel;
  }

  Future<UpdateDealerInfResponse>getAccessKeyAndSaveDealerInf(UpdateDealerInfModel updateDealerInfModel) async{
    UpdateDealerInfResponse _updateDealerInfResponse;
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      String accessKey = await repository.getAccessKey();
      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        _updateDealerInfResponse = await repository.updateDealerInf(accessKey, userSecurityKey, updateDealerInfModel);
    });
    //Get.back();
    return _updateDealerInfResponse;
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
    //Get.back();
    return _infDetailModel;
  }

  Future<SaveNewInfluencerResponse>getAccessKeyAndSaveNewInfluencer(SaveNewInfluencerModel saveNewInfluencerModel) async{
    SaveNewInfluencerResponse saveNewInfluencerResponse;
    String userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    // Future.delayed(
    //     Duration.zero,
    //         () => Get.dialog(Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
      String accessKey = await repository.getAccessKey();
      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        saveNewInfluencerResponse = await repository.saveNewInfluencer(
            accessKey, userSecurityKey, saveNewInfluencerModel);


      });
      //Get.back();
      return saveNewInfluencerResponse;
   // });
  }








  //////////test
  // Future<InfDetailModel> getInfData1(String contact) async {
  //   InfDetailModel _infDetailModel;
  //   //In case you want to show the progress indicator, uncomment the below code and line 43 also.
  //   //It is working fine without the progress indicator
  //   //Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
  //   String userSecurityKey = "";
  //   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //   String accessKey = await repository.getAccessKey();
  //
  //   await _prefs.then((SharedPreferences prefs) async {
  //     userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
  //     _infDetailModel = await repository.getInfData1(accessKey, userSecurityKey, contact);
  //   });
  //   //Get.back();
  //   return _infDetailModel;
  // }
}



