// import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{

final _sitesConverted = ''.obs;
final _volumeConverted = ''.obs;
final _newInfl = ''.obs;
final _dspSlabsConverted = ''.obs;

  get sitesConverted => this._sitesConverted.value;
  set sitesConverted(value) => this._sitesConverted.value = value;

  get volumeConverted => this._volumeConverted.value;
  set volumeConverted(value) => this._volumeConverted.value = value;

  get newInfl => this._newInfl.value;
  set newInfl(value) => this._newInfl.value = value;

  get dspSlabsConverted => this._dspSlabsConverted.value;
  set dspSlabsConverted(value) => this._dspSlabsConverted.value = value;

  // getAccessKey(int requestId) {
  //   // print('EmpId :: ${this.empId} Phone Number :: ${this.phoneNumber} ');
  //   Future.delayed(
  //       Duration.zero,
  //       () => Get.dialog(Center(child: CircularProgressIndicator()),
  //           barrierDismissible: false));
  //   repository.getAccessKey().then((data) {
  //     Get.back();
  //     this.accessKeyResponse = data;
  //     switch (requestId) {
  //       case RequestIds.CHECK_IN:
  //         getCheckInDetails(this.accessKeyResponse.accessKey);
  //         break;
  //       case RequestIds.CHECK_OUT:
  //         getCheckOutDetails(this.accessKeyResponse.accessKey);
  //         break;
  //     }
  //   });
  // }


  
}