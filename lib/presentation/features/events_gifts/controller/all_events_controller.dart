

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EndEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/EventResponse.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/allEventsModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final EgRepository repository;

  AllEventController({required this.repository});
  final Rx<AllEventsModel?> _egAllEventData = AllEventsModel().obs;
  get egAllEventData => this._egAllEventData.value;
  set egAllEventData(value) => this._egAllEventData.value = value;
  final Rx<EndEventModel?> _endEventModel = EndEventModel().obs;

  get endEventModel => _endEventModel.value;

  set endEventModel(value) {
    _endEventModel.value = value;
  }

  final _eventType = ''.obs;
  final _eventTypeValue = ''.obs;
  final _eventStatus = ''.obs;
  final _eventStatusValue = ''.obs;
  final _selectedPosition = 0.obs;
  final _isFilterApplied = false.obs;

  final Rx<AllEventsModel?> _dataForSearchResult = AllEventsModel().obs;

  get dataForSearchResult => _dataForSearchResult.value;
  set dataForSearchResult(value) {
    _dataForSearchResult.value = value;
  }

  /*
  // final _eventListModels = EventListModels().obs;
  // final _eventStatusEntities = EventStatusEntities().obs;

  final _eventDate = StringConstants.empty.obs;
  final _eventStatusText = StringConstants.empty.obs;
  final _eventVenue = StringConstants.empty.obs;
  final _eventInflCount = StringConstants.empty.obs;
  final _expectedLeadsCount = StringConstants.empty.obs;
  final _dealerName = StringConstants.empty.obs;
  final _eventTypeText = StringConstants.empty.obs;


  get eventDate => _eventDate.value;

  set eventDate(value) {
    _eventDate.value = value;
  }

  get eventStatusText => _eventStatusText.value;

  set eventStatusText(value) {
    _eventStatusText.value = value;
  }

  get eventVenue => _eventVenue.value;

  set eventVenue(value) {
    _eventVenue.value = value;
  }

  get eventInflCount => _eventInflCount.value;

  set eventInflCount(value) {
    _eventInflCount.value = value;
  }

  get expectedLeadsCount => _expectedLeadsCount.value;

  set expectedLeadsCount(value) {
    _expectedLeadsCount.value = value;
  }

  get dealerName => _dealerName.value;

  set dealerName(value) {
    _dealerName.value = value;
  }

  get eventTypeText => _eventTypeText.value;

  set eventTypeText(value) {
    _eventTypeText.value = value;
  }
*/
//  final _searchKey=''.obs;
//  get searchKey => _searchKey;
//  set searchKey(value) {
//    _searchKey.value = value;
//  }


  get isFilterApplied => _isFilterApplied.value;

  set isFilterApplied(value) {
    _isFilterApplied.value = value;
  }


  get selectedPosition => _selectedPosition.value;

  set selectedPosition(value) {
    _selectedPosition.value = value;
  }

  get eventTypeValue => _eventTypeValue.value;

  set eventTypeValue(value) {
    _eventTypeValue.value = value;
  }

  final _assignToDate = StringConstants.empty.obs;
  final _selectedFilterCount=0.obs;

  get selectedFilterCount => _selectedFilterCount.value;

  set selectedFilterCount(value) {
    _selectedFilterCount.value = value;
  }

  get assignFromDate => _assignFromDate.value;

  set assignFromDate(value) {
    _assignFromDate.value = value;
  }

  get eventStatusValue => _eventStatusValue.value;

  set eventStatusValue(value) {
    _eventStatusValue.value = value;
  }
  get assignToDate => _assignToDate;

  set assignToDate(value) {
    _assignToDate.value = value;
  }

  final _assignFromDate = StringConstants.empty.obs;


  get eventStatus => _eventStatus.value;

  set eventStatus(value) {
    _eventStatus.value = value;
  }

  get eventType => _eventType.value;

  set eventType(value) {
    _eventType.value = value;
  }

  // get eventListModels => this._eventListModels.value;
  // set eventListModels(value) => this._eventListModels.value = value;
  //
  // get eventStatusEntities => this._eventStatusEntities.value;
  // set eventStatusEntities(value) => this._eventStatusEntities.value = value;



  Future eventSearch(String searchText) async{
    String? userSecurityKey = "";
    String? empID = "";
    String? accessKey = await (repository.getAccessKey() as FutureOr<String?>);
    Future<SharedPreferences>  _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
    });
    dataForSearchResult = await repository.eventSearch(accessKey, userSecurityKey, empID!, searchText);
  }

  Future<AllEventsModel?> getAllEventData() async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
    //Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String? userSecurityKey = "";
    String? empID = "";
    String? accessKey = await (repository.getAccessKey() as FutureOr<String?>);
    Future<SharedPreferences>  _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      String assignTo = "";
      if (this.assignToDate != StringConstants.empty) {
        assignTo = "&eventToDate=${this.assignToDate}";
      }

      String assignFrom = "";
      if (this.assignFromDate != StringConstants.empty) {
        assignFrom = "&eventFromDate=${this.assignFromDate}";
      }

      String eventType = "";
      if (this.eventType != StringConstants.empty) {
        eventType = "&eventType=${this.eventTypeValue}";
      }

      String eventStatus = "";
      if (this.eventStatus != StringConstants.empty) {
        eventStatus = "&eventStatus=${this.eventStatusValue}";
      }


      var url = "${UrlConstants.getAllEvents}$empID$assignTo$assignFrom$eventType$eventStatus";

      egAllEventData = await repository.getAllEvents(accessKey, userSecurityKey, url);

    });
    //Get.back();
    return egAllEventData;
  }

  Future<EndEventModel?> getEndEventDetail( String eventId)async{
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String? userSecurityKey = "";
    String? empID = "";
    String? accessKey = await (repository.getAccessKey() as FutureOr<String?>);
    Future<SharedPreferences>  _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
    });

    endEventModel = await repository.getEndEventDetail(accessKey, userSecurityKey, empID!, eventId);

    Get.back();
    return endEventModel;


  }

  Future<EventResponse?> submitEndEventDetail(int eventId,
      String eventComment,String eventDate,double eventEndLat,double eventEndLong)async{
    String? userSecurityKey = "";
    String? empID = "";
    String? accessKey = await (repository.getAccessKey() as FutureOr<String?>);
    Future<SharedPreferences>  _prefs = SharedPreferences.getInstance();
    // Future.delayed(
    //     Duration.zero,
    //         () => Get.dialog(Center(child: CircularProgressIndicator()),
    //         barrierDismissible: false));
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
    });

    EventResponse? endEventModel = await repository.submitEndEventDetail(accessKey, userSecurityKey, empID, eventId,eventComment,eventDate,eventEndLat,eventEndLong);
   // Get.back();
    return endEventModel;
  }


}