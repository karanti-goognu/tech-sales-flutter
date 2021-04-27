
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/model/approvedEventModel.dart';
import 'package:flutter_tech_sales/presentation/features/events_gifts/data/repository/eg_repository.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
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

  Future<AccessKeyModel> getAccessKey() {
    return repository.getAccessKey();
  }

  Future<ApprovedEventsModel> getApprovedEventData(String accessKey) async {
    //In case you want to show the progress indicator, uncomment the below code and line 43 also.
    //It is working fine without the progress indicator
//    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String userSecurityKey = "";
    String empID = "";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
}


/*
  final _accessKeyResponse = AccessKeyModel().obs;
  final _secretKeyResponse = SecretKeyModel().obs;
  final _filterStatusResponse = EventStatusEntities().obs;
  final _filterTypeResponse = EventTypeModels().obs;

  final _offset = 0.obs;
  final _isFilterApplied = false.obs;

  get isFilterApplied => _isFilterApplied;

  set isFilterApplied(value) {
    _isFilterApplied.value = value;
  }

  get offset => this._offset.value;

  set offset(value) => this._offset.value = value;


  final _selectedPosition = 0.obs;
  final _selectedFilterCount = 0.obs;
  final _assignToDate = StringConstants.empty.obs;
  final _assignFromDate = StringConstants.empty.obs;
  final _searchKey = "".obs;

  final _selectedEventStatus = StringConstants.empty.obs;
  final _selectedEventStatusValue = StringConstants.empty.obs;

  get accessKeyResponse => this._accessKeyResponse.value;

  get selectedFilterCount => this._selectedFilterCount.value;

  get searchKey => this._searchKey.value;

  get secretKeyResponse => this._secretKeyResponse.value;

  get assignToDate => this._assignToDate.value;

  get assignFromDate => this._assignFromDate.value;

  get filterStatusResponse => this._filterStatusResponse;

  get filterTypeResponse => this._filterTypeResponse;

  get selectedPosition => this._selectedPosition.value;

  get selectedEventStatus => this._selectedEventStatus.value;

  get selectedEventStatusValue => this._selectedEventStatusValue.value;

  set selectedFilterCount(value) => this._selectedFilterCount.value = value;

  set accessKeyResponse(value) => this._accessKeyResponse.value = value;

  set secretKeyResponse(value) => this._secretKeyResponse.value = value;

  set filterStatusResponse(value) => this._filterStatusResponse.value = value;

  set searchKey(value) => this._searchKey.value = value;

  set assignToDate(value) => this._assignToDate.value = value;

  set assignFromDate(value) => this._assignFromDate.value = value;

  set selectedPosition(value) => this._selectedPosition.value = value;

  set selectedEventStatus(value) => this._selectedEventStatus.value = value;

  set _selectedEventStatusValue(value) =>
      this._selectedEventStatusValue.value = value;

  getSecretKey(int requestId) {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    String empId = "empty";
    String mobileNumber = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      String empIdEncrypted =
      encryptString(empId, StringConstants.encryptedKey);
      String mobileNumberEncrypted =
      encryptString(mobileNumber, StringConstants.encryptedKey);
      repository
          .getSecretKey(empIdEncrypted, mobileNumberEncrypted)
          .then((data) {
        print(data.toJson()['secret-key']);
        Get.back();
        this.secretKeyResponse = data;
        if (data != null) {
          prefs.setString(StringConstants.userSecurityKey,
              this.secretKeyResponse.secretKey);
          getAccessKey(requestId);
        } else {
          print('Secret key response is null');
        }
      });
    });
  }

  getAccessKey(int requestId) {

    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    repository.getAccessKey().then((data) {
      Get.back();
      this.accessKeyResponse = data;

      if (this.accessKeyResponse.respCode == 'DM1005') {
        print(this.accessKeyResponse.respMsg);
        Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        _prefs.then((SharedPreferences prefs) {
          prefs.setString(StringConstants.userSecurityKey, '');
          prefs.setString(StringConstants.isUserLoggedIn, "false");
          prefs.setString(StringConstants.employeeName, '');
          prefs.setString(StringConstants.employeeId, '');
          prefs.setString(StringConstants.mobileNumber, '');
        });
        SystemNavigator.pop();
      }
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        String userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
//        print('User Security key is :: $userSecurityKey');
        if (userSecurityKey != "empty") {
          //Map<String, dynamic> decodedToken = JwtDecoder.decode(userSecurityKey);
          bool hasExpired = JwtDecoder.isExpired(userSecurityKey);
          if (hasExpired) {
            print('Has expired');
            getSecretKey(requestId);
          } else {
            print('Not expired');
            switch (requestId) {
              case RequestIds.LEADS_FILTER_DATA_REQUEST:
                getFilterData();
                break;
              case RequestIds.GET_LEADS_LIST:
                getLeadsData(this.accessKeyResponse.accessKey);
                break;
              case RequestIds.SEARCH_LEADS:
                searchLeads(this.accessKeyResponse.accessKey);
                break;
            }
          }
        }
      });
    });
  }

  getFilterData() {
    repository.getFilterData(this.accessKeyResponse.accessKey).then((data) {
      debugPrint('Access Key Response :: ');
      print(json.encode(data));
      if (data == null) {
        debugPrint('Filter Data Response is null');
      } else {
        this.filterStatusResponse = data;
        if (_filterStatusResponse.respCode == "DM1002") {
          //Get.dialog(CustomDialogs().errorDialog(filterDataResponse.respMsg));
        } else {
          Get.dialog(CustomDialogs().errorDialog(filterStatusResponse.respMsg));
        }
      }
    });
  }

  getLeadsData(String accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');
      String encryptedEmpId =
      encryptString(empId, StringConstants.encryptedKey).toString();
      String assignTo = "";
      if (this.assignToDate != StringConstants.empty) {
        assignTo = "&assignDateTo=${this.assignToDate}";
      }

      String assignFrom = "";
      if (this.assignFromDate != StringConstants.empty) {
        assignFrom = "&assignDateFrom=${this.assignFromDate}";
      }

      String leadStatus = "";
      if (this.selectedLeadStatusValue != StringConstants.empty) {
        leadStatus = "&leadStatus=${this.selectedLeadStatusValue}";
      }
      String leadStage = "";
      if (this.selectedLeadStageValue != StringConstants.empty) {
        leadStage = "&leadStage=${this.selectedLeadStageValue}";
      }

      //	leadPotentialFrom (optional)
      //
      // 	leadPotentialTo (optional)
      String leadPotentialFrom = "";
      String leadPotentialTo = "";
      print('${this.selectedLeadPotentialValue}');
      if (this.selectedLeadPotentialValue != StringConstants.empty) {
        switch (selectedLeadPotentialValue) {
          case "0":
            leadPotentialFrom = "&leadPotentialFrom=0";
            leadPotentialTo = "&leadPotentialTo=200";
            break;
          case "1":
            leadPotentialFrom = "&leadPotentialFrom=201";
            leadPotentialTo = "&leadPotentialTo=500";
            break;
          case "2":
            leadPotentialFrom = "&leadPotentialFrom=501";
            break;
          default:
            leadPotentialFrom = "";
            leadPotentialTo = "";
            break;
        }
      }
      //debugPrint('request without encryption: $body');
      String url =
          "${UrlConstants.getLeadsData}$empId$assignFrom$assignTo$leadStatus$leadStage$leadPotentialFrom$leadPotentialTo&limit=10&offset=${this.offset}";

      var encodedUrl = Uri.encodeFull(url);
      debugPrint('Url is : $encodedUrl');
      repository
          .getLeadsData(accessKey, userSecurityKey, encodedUrl)
          .then((data) {
        if (data == null) {
          debugPrint('Leads Data Response is null');
        } else {
          if(this.leadsListResponse.leadsEntity == null|| this.leadsListResponse.leadsEntity.isEmpty){
            this.leadsListResponse = data;
          }else{
            print("adding");
            print(json.encode(data));
            // this._leadsListResponse.value.leadsEntity.addAll(data.leadsEntity);
            // this.leadsListResponseAddLeads = data.leadsEntity;
            print(data.leadsEntity.length);
            // this.leadsListResponse = data;
            LeadsListModel leadListResponseServer = data;

            print(json.encode(leadListResponseServer));
            if(leadListResponseServer.leadsEntity.isNotEmpty){
//              leadListResponseServer.leadsEntity=[];
              leadListResponseServer.leadsEntity.addAll(this.leadsListResponse.leadsEntity );
              this.leadsListResponse = leadListResponseServer;
              Get.rawSnackbar(
                titleText: Text("Note"),
                messageText: Text(
                    "Loading more .."),
                backgroundColor: Colors.white,
              );
//              Get.snackbar("Note", "Loading more ..",snackPosition: SnackPosition.BOTTOM,backgroundColor:Color(0xffffffff),duration: Duration(milliseconds: 2000));
            } else{
              print("Is Filter Applied: ${this.isFilterApplied}");
              if(this.isFilterApplied==true){
                print("Filter will be implemented here");
                this.leadsListResponse= data;
              }
              else{
                Get.rawSnackbar(
                  titleText: Text("Note"),
                  messageText: Text(
                      "No more leads .."),
                  backgroundColor: Colors.white,
                );
              }

//              Get.snackbar("Note", "No more leads ..",snackPosition: SnackPosition.BOTTOM,backgroundColor:Color(0xff0fffff),duration: Duration(milliseconds: 2000));
            }
          }
          //this.fullLeadsList= this.fullLeadsList.arrdd(this.leadsListResponse);
          //  print("Length of full list is ${this.fullLeadsList.length}");
          if (leadsListResponse.respCode == "LD2006") {
            //Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          } else {
            Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          }
        }
      });
    });
  }

  searchLeads(String accessKey) {
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');
      String encryptedEmpId =
      encryptString(empId, StringConstants.encryptedKey).toString();

      //debugPrint('request without encryption: $body');
      String url =
          "${UrlConstants.getSearchData}$empId&searchText=${this.searchKey}";
      debugPrint('Url is : $url');
      repository.getSearchData(accessKey, userSecurityKey, url).then((data) {
        if (data == null) {
          debugPrint('Leads Data Response is null');
        } else {
          this.leadsListResponse = data;
          if (leadsListResponse.respCode == "LD2004") {
            //Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
            print('success');
            //leadsDetailWidget();
          } else {
            Get.dialog(CustomDialogs().errorDialog(leadsListResponse.respMsg));
          }
        }
      });
    });
  }

  showNoInternetSnack() {
    Get.snackbar(
        "No internet connection.", "Please check your internet connection.",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM);
  }

  openOtpVerificationPage(mobileNumber) {
    Get.toNamed(Routes.VERIFY_OTP);
  }



}

 */
