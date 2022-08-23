import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/deleteEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/detailEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerListResponse.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerModel.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';


class DetailEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }


  final EgRepository repository;

  DetailEventController({required this.repository});

  final Rx<DetailEventModel?> _egDetailEventData = DetailEventModel().obs;

  final _deleteEventResponse = DeleteEventModel().obs;

  final _dealerListResponse = DealerListResponse().obs;


  get egDetailEventDaa => _egDetailEventData.value;

  get deleteEventResponse => _deleteEventResponse.value;

  get dealerListResponse => this._dealerListResponse.value;


  set egDetailEventDaa(value) => _egDetailEventData.value = value;

  set deleteEventResponse(value) => _deleteEventResponse.value = value;

  set dealerListResponse(value) => this._dealerListResponse.value = value;

  final _dealerList = List<DealerModel>.empty(growable: true).obs;

  final _dealerListSelected = List<DealerModelSelected>.empty(growable: true).obs;

  get dealerList => this._dealerList;

  set dealerList(value) => this._dealerList.value = value;

  get dealerListSelected => this._dealerListSelected;

  set dealerListSelected(value) => this._dealerListSelected.value = value;


  Future<String?> getAccessKey() {
    return repository.getAccessKey().then((value) => value as String?);
  }

  Future<DetailEventModel?> getDetailEventData(
    int? eventId,
  ) async {
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      String? accessKey = await (repository.getAccessKey() );
      egDetailEventDaa = await repository.getdetailEvents(
          accessKey, userSecurityKey, empID!, eventId);
    });
    return egDetailEventDaa;
  }

  getDealersList(int eventId) async {
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String? accessKey = await (repository.getAccessKey() );
    _prefs.then((SharedPreferences prefs) {
      String? userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId)!;
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
            print('${dealerListResponse.respMsg}');
          } else {
          }
        }
      });
    });
  }

  deleteEvent(int? eventId) async {
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    String? accessKey = await (repository.getAccessKey() );
    repository.getAccessKey().then((data) async {
      await _prefs.then((SharedPreferences prefs) async {
        empID = prefs.getString(StringConstants.employeeId);
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        repository
            .deleteEvent(accessKey, userSecurityKey, empID!, eventId)
            .then((value) {
          if (value!.respMsg == 'DM1002') {
            Get.defaultDialog(
                title: "Message",
                middleText: value.respMsg.toString(),
                confirm: MaterialButton(
                  onPressed: () => Get.back(),
                  child: Text('OK'),
                ),
                barrierDismissible: false);
          } else {
            Get.dialog(
                CustomDialogs.messageDialogMWP(value.respMsg.toString()),
                barrierDismissible: false);
          }
        });
      });
    });
  }
}
