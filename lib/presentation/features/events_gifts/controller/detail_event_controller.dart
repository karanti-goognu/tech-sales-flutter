import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/deleteEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
//import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  // @override
  // void onReady() {
  //   // called after the widget is rendered on screen
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {
  //   // called just before the Controller is deleted from memory
  //   super.onClose();
  // }

  final EgRepository repository;

  DetailEventController({@required this.repository})
      : assert(repository != null);

  final _egDetailEventData = DetailEventModel().obs;

  final _deleteEventResponse = DeleteEventModel().obs;

  //final _eventDealersModelList = EventDealersModelList().obs;

  get egDetailEventDaa => _egDetailEventData.value;

  get deleteEventResponse => _deleteEventResponse.value;

 // get eventDealersModelList => _eventDealersModelList.value;

  set egDetailEventDaa(value) => _egDetailEventData.value = value;

  set deleteEventResponse(value) => _deleteEventResponse.value = value;

  //set eventDealersModelList(value) => _eventDealersModelList.value = value;

  final _dealerList = List<DealerModel>().obs;

  final _dealerListSelected = List<DealerModelSelected>().obs;

  get dealerList => this._dealerList;

  set dealerList(value) => this._dealerList.value = value;

  get dealerListSelected => this._dealerListSelected;

  set dealerListSelected(value) => this._dealerListSelected.value = value;

  // get isLoading => this._isLoading.value;
  // set isLoading(value) => this._isLoading.value = value;

  Future<String> getAccessKey() {
    return repository.getAccessKey();
  }

  Future<DetailEventModel> getDetailEventData(
    int eventId,
  ) async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
    Future.delayed(Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      // print(userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      String accessKey = await repository.getAccessKey();
      print('EMP: $empID');
      egDetailEventDaa = await repository.getdetailEvents(
          accessKey, userSecurityKey, empID, eventId);
    });
    Get.back();
    return egDetailEventDaa;
  }

  getDealersList(int eventId) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    // this.isLoading = true;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);

      repository
          .getdetailEvents(accessKey, userSecurityKey, empId, eventId)
          .then((data) {
        // this.isLoading = false;
        if (data == null) {
          debugPrint('Dealer List Response is null');
        } else {
          debugPrint('Dealer List Response is not null');
          this.egDetailEventDaa = data;
         // this.eventDealersModelList = data.eventDealersModelList;

          // this.isLoading = false;
          if (this.egDetailEventDaa.dealersModels.length != 0) {
            for (int i = 0;
                i < this.egDetailEventDaa.dealersModels.length;
                i++) {
              this.dealerList.add(new DealerModel(
                  egDetailEventDaa.dealersModels[i].dealerId,
                  egDetailEventDaa.dealersModels[i].dealerName,
                  false));

              // this.dealerList.add(new DealerModel(
              //     egDetailEventDaa.eventDealersModelList[i].dealerId,
              //     egDetailEventDaa.eventDealersModelList[i].dealerName,
              //     true));
            }
          }

          // if (this.egDetailEventDaa.eventDealersModelList.length != 0) {
          //   for (int i = 0;
          //   i < this.egDetailEventDaa.eventDealersModelList.length;
          //   i++) {
          //     this.dealerListSelected.add(new DealerModelSelected(
          //         egDetailEventDaa.eventDealersModelList[i].dealerId,
          //         egDetailEventDaa.eventDealersModelList[i].dealerName,));
          //   }
          // }
          Get.back();
          if (egDetailEventDaa.respCode == "DM1002") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            print('${egDetailEventDaa.respMsg}');
            //SitesDetailWidget();
          } else {
            // Get.dialog(CustomDialogs().errorDialog(dealerListResponse.respMsg));
          }
        }
      });
    });
  }

  Future<DeleteEventModel> deleteEvent(int eventId) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String accessKey = await repository.getAccessKey();
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) async {
      await _prefs.then((SharedPreferences prefs) async {
        empID = prefs.getString(StringConstants.employeeId);
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        repository
            .deleteEvent(accessKey, userSecurityKey, empID, eventId)
            .then((value) {
          //Get.back();
          if (value.respMsg == 'DM1002') {
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
}
