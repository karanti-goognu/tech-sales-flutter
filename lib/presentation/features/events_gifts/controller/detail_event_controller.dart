import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/deleteEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
//import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/saveEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerListResponse.dart';
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

  final _dealerListResponse = DealerListResponse().obs;

  //final _eventDealersModelList = EventDealersModelList().obs;

  get egDetailEventDaa => _egDetailEventData.value;

  get deleteEventResponse => _deleteEventResponse.value;

  get dealerListResponse => this._dealerListResponse.value;

 // get eventDealersModelList => _eventDealersModelList.value;

  set egDetailEventDaa(value) => _egDetailEventData.value = value;

  set deleteEventResponse(value) => _deleteEventResponse.value = value;

  set dealerListResponse(value) => this._dealerListResponse.value = value;


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
        if (data == null) {
          debugPrint('Dealer List Response is null');
        } else {
          debugPrint('Dealer List Response is not null');
          this.dealerListResponse = data;
          if (this.dealerListResponse.dealerList.length != 0) {
            for (int i = 0;
            i < this.dealerListResponse.dealerList.length;
            i++) {
              this.dealerList.add(new DealerModel(
                  dealerListResponse.dealerList[i].dealerId,
                  dealerListResponse.dealerList[i].dealerName,
                  false));
            }
          }

          Get.back();
          if (dealerListResponse.respCode == "DM1002") {
            //Get.dialog(CustomDialogs().errorDialog(SitesListResponse.respMsg));
            print('${dealerListResponse.respMsg}');
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
