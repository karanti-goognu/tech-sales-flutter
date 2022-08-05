import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/bindings/home_binding.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/home_screen/view/homescreen.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/UpdateSRModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';


class UpdateServiceRequestController extends GetxController {

  List<File> imageList = List<File>.empty(growable: true);

  late String id;
  ComplaintViewModel? complaintViewModel;
  int option = 1;
  String dropdownValue = 'Select visit sub-types';

  setTabOption(int value){
    this.option=value;
    update();
  }

   updateImageList(File? value) {
    if(value!=null) {
      imageList.add(value);
      update();
    }
  }

  updateImageAfterDelete(int index) {
    if(index>=0) {
      imageList.removeAt(index);
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose(){
    imageList.clear();
    super.dispose();
  }

  final Rx<ComplaintViewModel?> _complaintListData = ComplaintViewModel().obs;
  get complaintListData => _complaintListData.value;
  set complaintListData(value) {
    _complaintListData.value = value;
  }

  final SrRepository repository;
  /// Request Update Details
  TextEditingController complaintID = TextEditingController();
  TextEditingController allocatedToID = TextEditingController();
  TextEditingController allocatedToName = TextEditingController();
  TextEditingController dateOfComplaint = TextEditingController();
  TextEditingController daysOpen = TextEditingController();
  TextEditingController sitePotential = TextEditingController();
  TextEditingController department = TextEditingController();
  TextEditingController requestType = TextEditingController();
  TextEditingController requestSubType = TextEditingController();
  TextEditingController customerType = TextEditingController();
  TextEditingController severity = TextEditingController();
  TextEditingController customerID = TextEditingController();
  TextEditingController requestorContact = TextEditingController();
  TextEditingController requestorName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController taluk = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController coverBlockProvidedNo = TextEditingController();
  TextEditingController formwarkRemovalDate = TextEditingController();


  UpdateServiceRequestController({required this.repository});
  final _updateRequestData = UpdateSRModel().obs;
  get updateRequestData => _updateRequestData.value;
  set updateRequestData(value) => _updateRequestData.value = value;
  bool responseReceived = false;

  Future<AccessKeyModel?> getAccessKey() {
    return repository.getAccessKey();
  }

  getAccessKeyAndUpdateRequest(
      List<File> imageList, UpdateSRModel? updateRequestModel) {
    String? userSecurityKey = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    Future.delayed(
        Duration.zero,
        () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) async {
      await _prefs.then((SharedPreferences prefs) async {
        userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
        updateServiceRequest(
                imageList, data!.accessKey, userSecurityKey, updateRequestModel)
            .then((value) {
          Get.back();
          Get.defaultDialog(
            title: "Message",
            middleText: value!['resp-msg'].toString(),
            barrierDismissible: false,
            confirm: MaterialButton(
              onPressed: () {
                  Get.back();
                  Get.offAll(() => HomeScreen(), binding: HomeScreenBinding());
                  },
              child: Text('OK'),
            ),
          );
          // }
        });
      });
    });
  }


  Future<Map?> updateServiceRequest(List<File> imageList, String? accessKey,
      String? userSecurityKey, UpdateSRModel? updateRequestModel) {
    return repository.updateServiceRequest(imageList, accessKey, userSecurityKey, updateRequestModel).whenComplete(() => responseReceived = true);
  }


  Future getRequestUpdateDetailsData(String? accessKey) async {
    String? userSecurityKey = "";
    String? empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      complaintListData = await repository.getComplaintViewData(accessKey, userSecurityKey, empID!, this.id);
      update();
    });

     return complaintListData;
  }

}
