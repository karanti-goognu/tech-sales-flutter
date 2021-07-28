import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ComplaintViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/model/ServiceRequestComplaintListModel.dart';
import 'package:flutter_tech_sales/presentation/features/service_requests/data/repository/sr_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SRListController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final SrRepository repository;
  SRListController({@required this.repository}) : assert(repository != null);

  final _offset = 0.obs;
  get offset => this._offset.value;

  set offset(value) => this._offset.value = value;

  final _srListData = ServiceRequestComplaintListModel().obs;
  get srListData => _srListData.value;
  set srListData(value) => _srListData.value = value;

  final _siteListData = ServiceRequestComplaintListModel().obs;
  get siteListData => _siteListData.value;
  set siteListData(value) => _siteListData.value = value;

  var _filteredListData = ServiceRequestComplaintListModel();
  get filteredListData => _filteredListData;
  set filteredListData(value) => _filteredListData = value;
//*****
  final _complaintListData = ComplaintViewModel().obs;

  get complaintListData => _complaintListData.value;

  set complaintListData(value) {
    _complaintListData.value = value;
  }
//*****

  showNoInternetSnack() {
    Get.snackbar(
        "No internet connection.", "Please check your internet connection.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
  }

//   Future<ServiceRequestComplaintListModel> getSrListData(
//       String accessKey, int offset) async {
//     String userSecurityKey = "";
//     String empID = "";
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     await _prefs.then((SharedPreferences prefs) async {
//       userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
//       empID = prefs.getString(StringConstants.employeeId);
//       ServiceRequestComplaintListModel srDataToBeAdded;
//       print("offset is ${this.offset}");
//       srDataToBeAdded = await repository.getSrListData(
//           accessKey, userSecurityKey, empID, this.offset);
//       if (srListData.srComplaintListModal == null ||
//           srListData.srComplaintListModal.isEmpty) {
//         print('---------------------------');
//         print('For the first time');
//         srListData = srDataToBeAdded;
//       } else {
//         print('---------------------------');
//         print('New One');
//         print(srDataToBeAdded.srComplaintListModal);
//         if(srDataToBeAdded.srComplaintListModal!=null &&srDataToBeAdded.srComplaintListModal.isNotEmpty){
//           print('---------------------------');
//           print('For the second time');
//           print("adding");
//           print(srDataToBeAdded.srComplaintListModal.length);
//           srListData.srComplaintListModal.clear();
//           srListData.srComplaintListModal
//               .addAll(srDataToBeAdded.srComplaintListModal);
//           Get.rawSnackbar(
//             titleText: Text("Note"),
//             messageText: Text(
//                 "Loading more .."),
//             backgroundColor: Colors.white,
//           );
// //          Get.snackbar("Note", "Loading more ..",
// //              snackPosition: SnackPosition.BOTTOM,
// //              backgroundColor: Color(0xffffffff),
// //              duration: Duration(milliseconds: 2000));
//         }
//         else{
//           print('---------------------------');
//           print('When empty');
//           Get.rawSnackbar(
//             titleText: Text("Note"),
//             messageText: Text(
//                 "No more leads .."),
//             backgroundColor: Colors.white,
//           );
// //          Get.snackbar("Note", "No more leads ..",snackPosition: SnackPosition.BOTTOM,backgroundColor:Color(0xff0fffff),duration: Duration(milliseconds: 2000));
//         }}
//     });
//     return srListData;
//   }

  Future<ServiceRequestComplaintListModel> getSrListData(
      String accessKey, int offset) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      print("offset is ${this.offset}");
      ServiceRequestComplaintListModel requestComplaintListModel;

      requestComplaintListModel = await repository.getSrListData(
          accessKey, userSecurityKey, empID, this.offset);
      if (requestComplaintListModel == null) {
        debugPrint('SR Data Response is null');
      } else {
        // if (srListData.respCode == "DM1005") {
        //   print("RESPCODE4: ${srListData.respCode}");
        //   srListData = requestComplaintListModel;
        //   Get.dialog(CustomDialogs().appUserInactiveDialog(srListData.respMsg),
        //       barrierDismissible: false);
        // }
        if (srListData.srComplaintListModal == null ||
            srListData.srComplaintListModal.isEmpty) {
          srListData = requestComplaintListModel;
        } else {
          if (requestComplaintListModel.srComplaintListModal != null &&
              requestComplaintListModel.srComplaintListModal.isNotEmpty) {
            requestComplaintListModel.srComplaintListModal.addAll(srListData.srComplaintListModal);
            this.srListData = requestComplaintListModel;
            this.srListData.srComplaintListModal.sort((SrComplaintListModal a, SrComplaintListModal b) => b.createdOn.compareTo(a.createdOn));

            Get.rawSnackbar(
              titleText: Text("Note"),
              messageText: Text("Loading more .."),
              backgroundColor: Colors.white,
            );
          } else {
            Get.rawSnackbar(
              titleText: Text("Note"),
              messageText: Text("No more SR Data..."),
              backgroundColor: Colors.white,
            );
          }
        }
      }
    });
    return srListData;
  }

  Future<ServiceRequestComplaintListModel> getSrListDataWithFilters(
      String accessKey,
      String resolutionStatusId,
      String severity,
      String typeOfReqId) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      filteredListData = await repository.getSrListDataWithFilters(accessKey,
          userSecurityKey, empID, resolutionStatusId, severity, typeOfReqId);
    });
    return filteredListData;
  }

  Future<ServiceRequestComplaintListModel> getSiteListData(
      String accessKey, String siteID) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      siteListData = await repository.getSiteListData(
          accessKey, userSecurityKey, empID, siteID);
    });
    return siteListData;
  }

  //*****
  Future getComplaintViewData(String accessKey, String id) async {
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    await _prefs.then((SharedPreferences prefs) async {
      userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      empID = prefs.getString(StringConstants.employeeId);
      complaintListData = await repository.getComplaintViewData(
          accessKey, userSecurityKey, empID, id);
      print(complaintListData);
    });
    return complaintListData;
  }
  //*****

}
