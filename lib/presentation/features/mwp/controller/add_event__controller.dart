import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/repository/app_repository.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerListResponse.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/DealerModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/MeetResponseModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveMeetRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/SaveVisitRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/UpdateMeetRequest.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/UpdateVisitModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/VisitModel.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/data/saveVisitResponse.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  final MyRepositoryApp repository;

  AddEventController({@required this.repository}) : assert(repository != null);

  final _saveVisitResponse = SaveVisitResponse().obs;
  final _dealerListResponse = DealerListResponse().obs;
  final _meetResponseModelView = MeetResponseModelView().obs;
  final _visitResponseModel = VisitResponseModel().obs;
  final _dealerList = List<DealerModel>().obs;
  final _dealerListSelected = List<DealerModelSelected>().obs;
  final _selectedView = "Visit".obs;
  final _visitOutcomes = ''.obs;
  final _selectedEventTypeMeet = "MASON MEET".obs;
  final _selectedVenueTypeMeet = "BOOKED".obs;
  final _selectedMonth = "January".obs;
  final _phoneNumber = "8860080067".obs;
  final _siteIdText = "Site Id".obs;
  final _empId = "_empty".obs;
  final _otpCode = "_empty".obs;
  final _visitId = 0.obs;
  final _meetAction = "S".obs;
  final _visitActionType = "UPDATE".obs;
  final _retryOtpActive = false.obs;
  final _visitSubType = 'RETENTION SITE'.obs;
  final _visitType = 'PHYSICAL'.obs;
  final _visitSiteId = StringConstants.empty.obs;
  final _visitDateTime = "Visit Date".obs;
  //test
  final _visitViewDateTime = "Visit Date".obs;
  //
  final _visitStartTime = StringConstants.empty.obs;
  final _nextVisitDate = "Next Visit Date".obs;
  final _visitRemarks = StringConstants.empty.obs;


  final _totalParticipants = StringConstants.empty.obs;
  final _isLoading = false.obs;
  final _isLoadingVisitView = false.obs;

  final _dalmiaInflCount = 0.obs;
  final _nonDalmiaInflCount = 0.obs;
  final _venue = StringConstants.empty.obs;
  final _expectedLeadsCount = 0.obs;
  final _giftsDistributedCount = 0.obs;
  final _eventLocation = StringConstants.empty.obs;
  final _isSaveDraft = StringConstants.empty.obs;
  final _createdBy = StringConstants.empty.obs;
  final _meetInitiatorName = StringConstants.empty.obs;

  get isLoading => this._isLoading.value;

  get siteIdText => this._siteIdText.value;
  get visitOutcomes => this._visitOutcomes.value;

  get visitActionType => this._visitActionType.value;

  get meetAction => this._meetAction.value;

  get isLoadingVisitView => this._isLoadingVisitView.value;

  get visitId => this._visitId.value;

  get dealerList => this._dealerList;

  get dealerListSelected => this._dealerListSelected;

  get meetResponseModelView => this._meetResponseModelView.value;

  get nextVisitDate => this._nextVisitDate.value;

  get saveVisitResponse => this._saveVisitResponse.value;

  get visitResponseModel => this._visitResponseModel.value;

  get dealerListResponse => this._dealerListResponse.value;

  get selectedView => this._selectedView.value;

  get visitType => this._visitType.value;

  get selectedEventTypeMeet => this._selectedEventTypeMeet.value;

  get selectedVenueTypeMeet => this._selectedVenueTypeMeet.value;

  get selectedMonth => this._selectedMonth.value;

  get phoneNumber => this._phoneNumber.value;

  get totalParticipants => this._totalParticipants.value;

  get empId => this._empId.value;

  get otpCode => this._otpCode.value;

  get retryOtpActive => this._retryOtpActive.value;

  get visitSubType => this._visitSubType.value;

  get visitSiteId => this._visitSiteId.value;

  get visitDateTime => this._visitDateTime.value;
  //
  get visitViewDateTime => this._visitViewDateTime.value;
//
  get visitStartTime => this._visitStartTime.value;

  get visitRemarks => this._visitRemarks.value;

  get dalmiaInflCount => this._dalmiaInflCount.value;

  get nonDalmiaInflCount => this._nonDalmiaInflCount.value;

  get venue => this._venue.value;

  get expectedLeadsCount => this._expectedLeadsCount.value;

  get giftsDistributedCount => this._giftsDistributedCount.value;

  get eventLocation => this._eventLocation.value;

  get isSaveDraft => this._isSaveDraft.value;

  get createdBy => this._createdBy.value;

  get meetInitiatorName => this._meetInitiatorName.value;

  set isLoading(value) => this._isLoading.value = value;

  set siteIdText(value) => this._siteIdText.value = value;
  set visitOutcomes(value) => this._visitOutcomes.value = value;


  set visitActionType(value) => this._visitActionType.value = value;

  set meetAction(value) => this._meetAction.value = value;

  set isLoadingVisitView(value) => this._isLoadingVisitView.value = value;

  set saveVisitResponse(value) => this._saveVisitResponse.value = value;

  set visitResponseModel(value) => this._visitResponseModel.value = value;

  set dealerList(value) => this._dealerList.value = value;

  set dealerListSelected(value) => this._dealerListSelected.value = value;

  set dealerListResponse(value) => this._dealerListResponse.value = value;

  set visitStartTime(value) => this._visitStartTime.value = value;

  set meetResponseModelView(value) => this._meetResponseModelView.value = value;

  set totalParticipants(value) => this._totalParticipants.value = value;

  set phoneNumber(value) => this._phoneNumber.value = value;

  set selectedView(value) => this._selectedView.value = value;

  set selectedMonth(value) => this._selectedMonth.value = value;

  set empId(value) => this._empId.value = value;

  set nextVisitDate(value) => this._nextVisitDate.value = value;

  set otpCode(value) => this._otpCode.value = value;

  set visitType(value) => this._visitType.value = value;

  set retryOtpActive(value) => this._retryOtpActive.value = value;

  set visitSubType(value) => this._visitSubType.value = value;

  set visitDateTime(value) => this._visitDateTime.value = value;
  //
  set visitViewDateTime(value) => this._visitViewDateTime.value = value;
  //

  set visitSiteId(value) => this._visitSiteId.value = value;

  set visitRemarks(value) => this._visitRemarks.value = value ;

  set dalmiaInflCount(value) => this._dalmiaInflCount.value = value;

  set nonDalmiaInflCount(value) => this._nonDalmiaInflCount.value = value;

  set venue(value) => this._venue.value = value;

  set expectedLeadsCount(value) => this._expectedLeadsCount.value = value;

  set giftsDistributedCount(value) => this._giftsDistributedCount.value = value;

  set eventLocation(value) => this._eventLocation.value = value;

  set isSaveDraft(value) => this._isSaveDraft.value = value;

  set createdBy(value) => this._createdBy.value = value;

  set visitId(value) => this._visitId.value = value;

  set selectedEventTypeMeet(value) => this._selectedEventTypeMeet.value = value;

  set selectedVenueTypeMeet(value) => this._selectedVenueTypeMeet.value = value;

  set meetInitiatorName(value) => this._meetInitiatorName.value = value;

  saveVisit(String accessKey) {
    Future.delayed(Duration.zero,()=>Get.dialog(Center(child: CircularProgressIndicator())));
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');
      print(this.visitDateTime);
      SaveVisitRequest saveVisitRequest = new SaveVisitRequest(
        empId,
        "VISIT",
        this.visitSubType,
        this.visitSiteId,
        this.visitDateTime=="Visit Date"?null:this.visitDateTime,
        this.visitRemarks,
      );

      debugPrint('Save MWP Model : ${json.encode(saveVisitRequest)}');
      String url = "${UrlConstants.saveVisit}";
      debugPrint('Url is : $url');
      repository
          .saveVisitPlan(accessKey, userSecurityKey, url, saveVisitRequest)
          .then((data) {
        if (data == null) {
          debugPrint('Save Visit Response is null');
        } else {
          Get.back();
          this.saveVisitResponse = data;
          this.visitDateTime = "Visit Date";
          this.visitRemarks = "";
          print('Response: ${this.saveVisitResponse}');
          if (saveVisitResponse.respCode == "MWP2022") {
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
          }else if(saveVisitResponse.respCode == "DM2144"){
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
          }
          else {
            print('Success');
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
          }
        }
      });
    });
  }

  saveMeet(String accessKey) {
    List<MwpMeetDealers> list = new List();
    for (int i = 0; i < this.dealerListSelected.length; i++) {
      list.add(new MwpMeetDealers(dealerId: dealerListSelected[i].dealerId));
    }
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');

      SaveMeetRequest saveMeetRequest = new SaveMeetRequest(
        empId,
        "MEET",
        this.selectedEventTypeMeet,
        this.visitDateTime,
        this.dalmiaInflCount,
        this.nonDalmiaInflCount,
        this.selectedVenueTypeMeet,
        this.expectedLeadsCount,
        this.giftsDistributedCount,
        this.eventLocation,
        this.meetAction,
        empId,
        this.meetInitiatorName,
        list,
      );

      String url = "${UrlConstants.saveVisit}";
      debugPrint('Url is : $url');
      repository
          .saveMeetPlan(accessKey, userSecurityKey, url, saveMeetRequest)
          .then((data) {
        if (data == null) {
          debugPrint('Save Visit Response is null');
        } else {
          debugPrint('Save Visit Response is not null');
          this.saveVisitResponse = data;
          if (saveVisitResponse.respCode == "MWP2021") {
            Get.dialog(
                CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
            print('${saveVisitResponse.respMsg}');
            //SitesDetailWidget();
          }
        }
      });
    });
  }

  getDealersList(String accessKey) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    // this.isLoading = true;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.getDealersList + "$empId";
      print('$url');
      repository.getDealerList(accessKey, userSecurityKey, url).then((data) {
        // this.isLoading = false;
        if (data == null) {
          debugPrint('Dealer List Response is null');
        } else {
          debugPrint('Dealer List Response is not null');
          this.dealerListResponse = data;
          this.isLoading = false;
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
          if (dealerListResponse.respCode == "MWP2013") {
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

  Future<VisitResponseModel>viewVisitData(String accessKey) async {
    this.isLoadingVisitView = true;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.viewVisitData +
          "$empId&visitCategory=VISIT&id=${this.visitId}";
      print('$url');
      repository.getVisitData(accessKey, userSecurityKey, url).then((data) {
        this.isLoadingVisitView = false;
        if (data == null) {
          debugPrint('Dealer List Response is null');
        } else {
          debugPrint('Dealer List Response is not null');
          this.visitResponseModel = data;
          this.visitSiteId =
              this.visitResponseModel.mwpVisitModel.docId.toString();
          // this.visitDateTime = this.visitResponseModel.mwpVisitModel.visitDate.toString();
          this.visitViewDateTime = this.visitResponseModel.mwpVisitModel.visitDate.toString();
          this.visitOutcomes = this.visitResponseModel.mwpVisitModel.visitOutcomes.toString();
          if (this.visitResponseModel.mwpVisitModel.visitStartTime != null) {
            this.visitStartTime =
                this.visitResponseModel.mwpVisitModel.visitStartTime.toString();
          }
          if (this.visitResponseModel.mwpVisitModel.nextVisitDate != null) {
            var date = DateTime.fromMillisecondsSinceEpoch(
                this.visitResponseModel.mwpVisitModel.nextVisitDate);
            final DateFormat formatter = DateFormat("yyyy-MM-dd");
            final String formattedDate = formatter.format(date);
            this.nextVisitDate = formattedDate;
          }
          if(this.visitResponseModel.mwpVisitModel.nextVisitDate == null){
            this.nextVisitDate = "Next Visit Date";
          }

          if (this.visitResponseModel.mwpVisitModel.visitType == null) {
            this.visitType = "PHYSICAL";
          } else {
            this.visitType =
                this.visitResponseModel.mwpVisitModel.visitType.toString();
          }
          this.visitSubType = this.visitResponseModel.mwpVisitModel.visitSubType.toString();
          this.visitRemarks = this.visitResponseModel.mwpVisitModel.remark.toString();
        }
      });
    });

    return visitResponseModel;

  }


  viewMeetData(String accessKey) async {
    this.isLoadingVisitView = true;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      String userSecurityKey = prefs.getString(StringConstants.userSecurityKey);
      String empId = prefs.getString(StringConstants.employeeId);
      String url = UrlConstants.viewVisitData +
          "$empId&visitCategory=MEET&id=${this.visitId}";
      print('$url');
      repository.getMeetData(accessKey, userSecurityKey, url).then((data) {
        if (data == null) {
          debugPrint('Meet Response is null');
          this.isLoadingVisitView = false;
        } else {
          debugPrint('Meet Response is not null');
          this.meetResponseModelView = data;
          this.selectedEventTypeMeet =
              this.meetResponseModelView.mwpMeetModel.meetType;
          this.venue = this.meetResponseModelView.mwpMeetModel.venue;
          this.visitDateTime = this.meetResponseModelView.mwpMeetModel.meetDate;
          this.dalmiaInflCount =
              this.meetResponseModelView.mwpMeetModel.dalmiaInflCount;
          this.isSaveDraft =
              this.meetResponseModelView.mwpMeetModel.isSaveDraft;
          this.nonDalmiaInflCount =
              this.meetResponseModelView.mwpMeetModel.nonDalmiaInflCount;
          this.expectedLeadsCount =
              this.meetResponseModelView.mwpMeetModel.expectedLeadsCount;
          this.giftsDistributedCount =
              this.meetResponseModelView.mwpMeetModel.giftsDistributedCount;
          this.eventLocation =
              this.meetResponseModelView.mwpMeetModel.eventLocation;
          /*if (this.meetResponseModelView.dealerModel.length != 0) {
            for (int i = 0;
                i < this.meetResponseModelView.dealerModel.length;
                i++) {
              print('${this.meetResponseModelView.dealerModel[i].dealerName}');
              this.dealerList.add(new DealerModel(
                  this.meetResponseModelView.dealerModel[i].dealerId,
                  this.meetResponseModelView.dealerModel[i].dealerName,
                  false));
            }
          }*/
          this.isLoadingVisitView = false;
        }
      });
    });
  }

  updateVisit(String accessKey) {
    // this.isLoadingVisitView = true;
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async{
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');

      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
      MwpVisitModelUpdate mwpVisitModelUpdate;
      String url = "${UrlConstants.updateVisit}";
      print('=============================');
      // debugPrint('Url is : $url');
      if (this.visitActionType == "UPDATE") {
        print('update');
        mwpVisitModelUpdate = new MwpVisitModelUpdate(
            this.visitId,
            this.visitViewDateTime,
            visitType,
            "",
            0.0,
            0.0,
            "",
            0.0,
            0.0,
            this.nextVisitDate=="Next Visit Date"?null:this.nextVisitDate,
          this.visitOutcomes,
          this.visitRemarks,
          this.visitSubType,
          this.visitSiteId
        );
        print('&&&&&&'+url);
        print('visitId'+this.visitId.toString());
        print(json.encode(mwpVisitModelUpdate));
        // mwpVisitModelUpdate.nextVisitDate = this.nextVisitDate;
        repository
            .updateVisitPlan(accessKey, userSecurityKey, url,
                new UpdateVisitResponseModel(mwpVisitModel: mwpVisitModelUpdate,mwpMeetModel: null))
            .then((data) {
          // this.isLoadingVisitView = false;
          Get.back();
          if (data == null) {
            debugPrint('Update Visit Response is null');
          } else {
            debugPrint('Update Visit Response is not null');
            this.saveVisitResponse = data;
            if (saveVisitResponse.respCode == "MWP2028") {
              Get.dialog(
                  CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
              print('${saveVisitResponse.respMsg}');
              //SitesDetailWidget();
            } else {
              Get.dialog(
                  CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
              print('${saveVisitResponse.respMsg}');
            }
          }
        });
      } else if (this.visitActionType == "START") {
        if (!(await Geolocator().isLocationServiceEnabled())) {
          Get.back();
      Get.dialog(CustomDialogs().errorDialog(
      "Please enable your location service from device settings"));
      }

        else {
          geolocator
              .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
              .then((Position position) {
            print('start');
            var journeyStartLat = position.latitude;
            var journeyStartLong = position.longitude;
            print('$journeyStartLong   $journeyStartLat');
            DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
            print(this.visitViewDateTime);
            mwpVisitModelUpdate = new MwpVisitModelUpdate(
                this.visitId,
                this.visitViewDateTime,
                visitType,
                dateFormat.format(DateTime.now()),
                journeyStartLat,
                journeyStartLong,
                "",
                0.0,
                0.0,
                this.nextVisitDate == "Next Visit Date" ? null : this
                    .nextVisitDate,
                this.visitOutcomes,
                this.visitRemarks,
                this.visitSubType,
                this.visitSiteId);
            // mwpVisitModelUpdate.nextVisitDate = this.nextVisitDate;
            repository
                .updateVisitPlan(accessKey, userSecurityKey, url,
                new UpdateVisitResponseModel(
                    mwpVisitModel: mwpVisitModelUpdate, mwpMeetModel: null))
                .then((data) {
              this.isLoadingVisitView = false;
              if (data == null) {
                debugPrint('Save Visit Response is null');
              } else {
                debugPrint('Save Visit Response is not null');
                this.saveVisitResponse = data;
                if (saveVisitResponse.respCode == "MWP2028") {
                  Get.dialog(CustomDialogs()
                      .messageDialogMWP(saveVisitResponse.respMsg));
                  print('${saveVisitResponse.respMsg}');
                  //SitesDetailWidget();
                } else {
                  Get.dialog(CustomDialogs()
                      .messageDialogMWP(saveVisitResponse.respMsg));
                  print('${saveVisitResponse.respMsg}');
                }
              }
            });
          }).catchError((e) {
            Get.back();
            Get.dialog(CustomDialogs().errorDialog(
                "Access to location data denied "));
            print(e);
          });

        }

      } else if (this.visitActionType == "END") {
        print('end');
        print(this.nextVisitDate);
        if (!(await Geolocator().isLocationServiceEnabled())) {
          Get.back();
          Get.dialog(CustomDialogs().errorDialog(
              "Please enable your location service from device settings"));
        } else {
          geolocator
              .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
              .then((Position position) {
            var journeyEndLat = position.latitude;
            var journeyEndLong = position.longitude;
            DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
            mwpVisitModelUpdate = new MwpVisitModelUpdate(
                this.visitId,
                this.visitViewDateTime,
                visitType,
                this.visitResponseModel.mwpVisitModel.visitStartTime,
                double.parse(
                    this.visitResponseModel.mwpVisitModel.visitStartLat),
                double.parse(
                    this.visitResponseModel.mwpVisitModel.visitStartLong),
                dateFormat.format(DateTime.now()),
                journeyEndLat,
                journeyEndLong,
                this.nextVisitDate == "Next Visit Date" ? null : this
                    .nextVisitDate,
                this.visitOutcomes,
                this.visitRemarks,
                this.visitSubType,
                this.visitSiteId);
            // mwpVisitModelUpdate.nextVisitDate = this.nextVisitDate;
            repository
                .updateVisitPlan(accessKey, userSecurityKey, url,
                new UpdateVisitResponseModel(
                    mwpVisitModel: mwpVisitModelUpdate))
                .then((data) {
              this.isLoadingVisitView = false;
              if (data == null) {
                debugPrint('Save Visit Response is null');
              } else {
                debugPrint('Save Visit Response is not null');
                this.saveVisitResponse = data;
                if (saveVisitResponse.respCode == "MWP2028") {
                  Get.dialog(CustomDialogs()
                      .messageDialogMWP(saveVisitResponse.respMsg));
                  print('${saveVisitResponse.respMsg}');
                  //SitesDetailWidget();
                } else {
                  Get.dialog(CustomDialogs()
                      .messageDialogMWP(saveVisitResponse.respMsg));
                  print('${saveVisitResponse.respMsg}');
                }
              }
            });
          }).catchError((e) {
            Get.back();
            Get.dialog(CustomDialogs().errorDialog(
                "Access to location data denied "));
            print(e);
          });
        }
      } else {
        mwpVisitModelUpdate = new MwpVisitModelUpdate(
            this.visitId,
            this.visitViewDateTime,
            visitType,
            "",
            0.0,
            0.0,
            "",
            0.0,
            0.0,
            this.nextVisitDate=="Next Visit Date"?null:this.nextVisitDate,
            this.visitOutcomes,
            this.visitRemarks,
            this.visitSubType,
            this.visitSiteId);
      }
    });
  }

  updateMeet(String accessKey) {
    List<MwpMeetDealersUpdate> list = new List();
    for (int i = 0; i < this.dealerListSelected.length; i++) {
      list.add(new MwpMeetDealersUpdate(
          id: 10,
          mwpMeetId: this.visitId,
          dealerId: dealerListSelected[i].dealerId));
    }
    String empId = "empty";
    String userSecurityKey = "empty";
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      print('$empId');
      userSecurityKey =
          prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      print('User Security key is :: $userSecurityKey');

      MwpMeetModel mwpMeetModel = new MwpMeetModel(
          id: visitId,
          meetType: this.selectedEventTypeMeet,
          meetDate: this.visitDateTime,
          dalmiaInflCount: this.dalmiaInflCount,
          nonDalmiaInflCount: this.nonDalmiaInflCount,
          venue: this.selectedVenueTypeMeet,
          expectedLeadsCount: this.expectedLeadsCount,
          giftsDistributedCount: this.giftsDistributedCount,
          eventLocation: this.eventLocation,
          isSaveDraft: this.meetAction,
          updatedBy: empId,
          mwpMeetDealers: list);
      UpdateMeetRequest updateMeetRequest =
          new UpdateMeetRequest(mwpMeetModel: mwpMeetModel);

      String url = "${UrlConstants.updateVisit}";
      debugPrint('Url is : $url');
      repository
          .updateMeetPlan(accessKey, userSecurityKey, url, updateMeetRequest)
          .then((data) {
        if (data == null) {
          debugPrint('Save Visit Response is null');
        } else {
          debugPrint('Save Visit Response is not null');
          this.saveVisitResponse = data;

          Get.dialog( CustomDialogs().messageDialogMWP(saveVisitResponse.respMsg));
          print('${saveVisitResponse.respMsg}');
          //SitesDetailWidget();
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

  openSplashScreen() {
    Get.toNamed(Routes.INITIAL);
  }
}
