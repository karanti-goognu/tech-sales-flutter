import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/DealerInfModel.dart';
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

  EventsFilterController({required this.repository});


  final Rx<ApprovedEventsModel?> _egApprovedEventData = ApprovedEventsModel().obs;

  get egApprovedEventDaa => _egApprovedEventData.value;

  set egApprovedEventDaa(value) => _egApprovedEventData.value = value;

  final _infDetailModel = InfluencerDetailModel().obs;
  get infDetailModel => _infDetailModel.value;
  set infDetailModel(value) => _infDetailModel.value = value;
  String responseForDialog = '';



  Future<String?> getAccessKey() {
    return repository.getAccessKey().then((value) => value as String?);
  }

  Future<ApprovedEventsModel?> getApprovedEventData() async {
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String? accessKey = await (repository.getAccessKey());

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      egApprovedEventDaa =
      await repository.getApprovedEvents(accessKey, userSecurityKey, empID!);
    });
    return egApprovedEventDaa;
  }


  Future<StartEventResponse?>getAccessKeyAndStartEvent(StartEventModel startEventModel) async{
    StartEventResponse? _startEventResponse;
    String? userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String? accessKey = await (repository.getAccessKey() );

      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
         _startEventResponse = await repository.startEvent(accessKey, userSecurityKey, startEventModel);
    });
      return _startEventResponse;
  }


  Future<DealerInfModel?> getDealerInfList(int? eventId) async {
    DealerInfModel? _dealerInfModel;
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    var accessKey = await repository.getAccessKey();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      _dealerInfModel =
      await repository.getDealerInfList(accessKey, userSecurityKey, empID!, eventId);
    });
    return _dealerInfModel;
  }

  Future<UpdateDealerInfResponse?>getAccessKeyAndSaveDealerInf(UpdateDealerInfModel updateDealerInfModel) async{
    UpdateDealerInfResponse? _updateDealerInfResponse;
    String? userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      String? accessKey = await (repository.getAccessKey() );
      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        _updateDealerInfResponse = await repository.updateDealerInf(accessKey, userSecurityKey, updateDealerInfModel);
    });
    return _updateDealerInfResponse;
  }


  Future<InfluencerDetailModel?> getInfData(String contact) async {
    InfluencerDetailModel? _infDetailModel;
    String? userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String? accessKey = await (repository.getAccessKey() );

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      _infDetailModel = await repository.getInfData(accessKey, userSecurityKey, contact);
    });
    return _infDetailModel;
  }

  Future<SaveNewInfluencerResponse?>getAccessKeyAndSaveNewInfluencer(SaveNewInfluencerModel saveNewInfluencerModel) async{
    SaveNewInfluencerResponse? saveNewInfluencerResponse;
    String? userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      String? accessKey = await (repository.getAccessKey() );
      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        saveNewInfluencerResponse = await repository.saveNewInfluencer(
            accessKey, userSecurityKey, saveNewInfluencerModel);
      });
      return saveNewInfluencerResponse;
  }

}



