import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
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

  AllEventController({@required this.repository})
      : assert(repository != null);
  final _egAllEventData = AllEventsModel().obs;
  get egAllEventDaa => _egAllEventData.value;
  set egAllEventDaa(value) => _egAllEventData.value = value;
  final _eventType = ''.obs;
  final _eventTypeValue = ''.obs;
  final _eventStatus = ''.obs;
  final _eventStatusValue = ''.obs;
  final _selectedPosition = 0.obs;
  final _isFilterApplied = false.obs;

  get isFilterApplied => _isFilterApplied;

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

  Future eventSearch() async{
    String userSecurityKey = "";
    String empID = "";
    String accessKey = await repository.getAccessKey();
    Future<SharedPreferences>  _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
    });
    var data = repository.eventSearch(accessKey, userSecurityKey, empID);
  }

  Future<AllEventsModel> getAllEventData() async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
//    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    String empID = "";
    String accessKey = await repository.getAccessKey();
    Future<SharedPreferences>  _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      // print(userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print('EMP: $empID');
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
      print(url);

      egAllEventDaa = await repository.getAllEvents(accessKey, userSecurityKey, url);
    });
//    Get.back();
    return egAllEventDaa;
  }


}