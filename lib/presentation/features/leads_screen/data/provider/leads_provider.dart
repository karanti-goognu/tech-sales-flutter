

import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/helper/draftLeadDBHelper.dart';
import 'package:flutter_tech_sales/presentation/features/influencer_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/AddLeadInitialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/LeadsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadResponse.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/TotalPotentialModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/UpdateLeadResponseModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteDistrictListModel.dart';
import 'package:flutter_tech_sales/utils/constants/GlobalConstant.dart' as gv;
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApiClientLeads {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final db = DraftLeadDBHelper();
  String? version;


  MyApiClientLeads({required this.httpClient});



  getAccessKey() async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }


  Future getAccessKeyNew() async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version) );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        return accessKeyModel.accessKey;
      } else
        print('error');
    } catch (_) {
      print('exception at EG repo ${_.toString()}');
    }
  }

  getSecretKey(String empId, String mobile) async {
    version = VersionClass.getVersion();
    try {
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': version!,
        'reference-id': empId,
        'mobile-number': mobile,
      };
      var response = await httpClient.get(Uri.parse(UrlConstants.getSecretKey),
          headers: requestHeadersEmpIdAndNo);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SecretKeyModel secretKeyModel = SecretKeyModel.fromJson(data);
        return secretKeyModel;
      } else {
        print('Error in else');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getFilterData(String? accessKey) async {
    try {
      version = VersionClass.getVersion();
      String userSecurityKey = "empty";
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
      });
      if (userSecurityKey == "empty") {
        var response = await httpClient.get(Uri.parse(UrlConstants.getFilterData),
            headers: requestHeadersWithAccessKeyAndSecretKey(
                accessKey, userSecurityKey,version) );
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
          return accessKeyModel;
        } else
          print('error');
      } else {
        print('user security key is empty');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getLeadsData(String? accessKey, String securityKey, String url) async {

    try {
      version = VersionClass.getVersion();
      final response = await get(Uri.parse(url),
          headers:
              requestHeadersWithAccessKeyAndSecretKey(accessKey, securityKey,version) );


      if (response.statusCode == 200) {

        var data = json.decode(response.body);
        LeadsListModel leadsListModel = LeadsListModel.fromJson(data);
        return leadsListModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch--> ${_.toString()}');
    }
  }

  getSearchData(String? accessKey, String securityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      final response = await get(Uri.parse(url),
          headers:
              requestHeadersWithAccessKeyAndSecretKey(accessKey, securityKey,version) );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        LeadsListModel leadsListModel = LeadsListModel.fromJson(data);
        return leadsListModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch ${_.toString()}');
    }
  }

  getAddLeadsData(String? accessKey, String? userSecurityKey) async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.addLeadsData),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey,version) );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AddLeadInitialModel addLeadInitialModel =
            AddLeadInitialModel.fromJson(data);
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        print(addLeadInitialModel.siteSubTypeEntity![0]);
        return addLeadInitialModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getInflDetailsData(
    accessKey,
    String? userSecurityKey,
    phoneNumber,
  ) async {
    try {
      version = VersionClass.getVersion();
      final response = await get(
        Uri.parse(UrlConstants.getInflData + "/$phoneNumber"),
        headers:
            requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version) ,
      );
       if (response.statusCode == 200) {
         var data = json.decode(response.body);
        InfluencerDetail influencerDetailModel =
            InfluencerDetail.fromJson(json.decode(response.body));
        if(data["resp_code"] == "DM1005"){
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        return influencerDetailModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  saveLeadsData(
      accessKey,
      String? userSecurityKey,
      SaveLeadRequestModel saveLeadRequestModel,
      List<File?> imageList,
      BuildContext context) async {
    version = VersionClass.getVersion();
    http.MultipartRequest request = new http.MultipartRequest(
        'POST', Uri.parse(UrlConstants.saveLeadsData));
    request.headers.addAll(
        requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version));

    for (var file in imageList) {
      String fileName = file!.path.split("/").last;
      var stream = new http.ByteStream(file.openRead());
      stream.cast();
      var length = await file.length();
      var multipartFileSign = new http.MultipartFile('file', stream, length, filename: fileName);

      request.files.add(multipartFileSign);
    }

    String empId;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      gv.currentId = empId;
      var uploadImageWithLeadModel = {
        'leadSegment': "TRADE",
        'siteSubTypeId': int.parse(saveLeadRequestModel.siteSubTypeId!),
        'assignedTo': empId,
        'leadStatusId': 1,
        'leadStage': 1,
        'eventId': saveLeadRequestModel.eventId ?? null,
        'contactName': saveLeadRequestModel.contactName,
        'contactNumber': saveLeadRequestModel.contactNumber ?? '0',
        'geotagType': saveLeadRequestModel.geotagType ?? 'M',
        'leadLatitude': saveLeadRequestModel.leadLatitude ?? '0',
        'leadLongitude': saveLeadRequestModel.leadLongitude ?? '0',
        'leadAddress': saveLeadRequestModel.leadAddress ?? 'null',
        'leadPincode': saveLeadRequestModel.leadPincode ?? '0',
        'leadStateName': saveLeadRequestModel.leadStateName ?? 'null',
        'leadDistrictName': saveLeadRequestModel.leadDistrictName ?? 'null',
        'leadTalukName': saveLeadRequestModel.leadTalukName ?? 'null',
        'leadSalesPotentialMt':
            saveLeadRequestModel.leadSalesPotentialMt ?? '0',
        'leadReraNumber': saveLeadRequestModel.leadReraNumber ?? '0',
        'isStatus': saveLeadRequestModel.isStatus ?? 'null',
        'createdBy': empId,
        'leadIsDuplicate': "N",
        'listLeadImage': saveLeadRequestModel.listLeadImage ?? 'null',
        'listLeadcomments': saveLeadRequestModel.comments ?? 'null',
        'leadInfluencerEntity': saveLeadRequestModel.influencerList ?? 'null',
        'leadSourceUser': saveLeadRequestModel.leadSourceUser,
        'leadSource' : saveLeadRequestModel.leadSource,
        'leadSourcePlatform': saveLeadRequestModel.leadSourcePlatform
      };

      request.fields['uploadImageWithLeadModel'] =
          jsonEncode(uploadImageWithLeadModel);

      try {
        request
            .send()
            .then((result) async {

          http.Response.fromStream(result).then((response) async {
            var data = json.decode(response.body);
            SaveLeadResponse saveLeadResponse =
            SaveLeadResponse.fromJson(data);


            if(data["resp_code"] == "DM1005"){
              Get.dialog(CustomDialogs.appUserInactiveDialog(
                  data["resp_msg"]), barrierDismissible: false);
            }else{
            if (saveLeadResponse.respCode == "LD2008") {
              Get.back();
              gv.selectedLeadID = saveLeadResponse.leadId;
              gv.fromLead = false;
              Get.dialog(CustomDialogs.showExistingLeadDialog(
                  saveLeadResponse.respMsg!,
                  context,
                  saveLeadRequestModel,
                  imageList));
            } else if (saveLeadResponse.respCode == "LD2007") {
              if (gv.fromLead) {
                db.removeLeadInDraft(gv.draftID);
                gv.fromLead = false;
              }
              gv.fromLead = false;
              Get.dialog(CustomDialogs
                  .showDialogSubmitLead(
                  saveLeadResponse.respMsg!, 2, context),barrierDismissible: false);
              if (saveLeadRequestModel.eventId == null) {
                Get.back();
                Get.dialog(CustomDialogs
                    .showDialogSubmitLead(
                    saveLeadResponse.respMsg!, 1, context),barrierDismissible: false);
              }

            } else if (saveLeadResponse.respCode == "LD2012") {
              gv.fromLead = false;
              Get.dialog(CustomDialogs.showExistingTSODialog(
                  saveLeadResponse.respMsg!,
                  context,
                  saveLeadRequestModel,
                  imageList));
            }
            else {
              gv.fromLead = false;
              Get.back();
              Get.dialog(
                  CustomDialogs.showDialog(saveLeadResponse.respMsg!));
            }
          }
              });
            });
      } catch (_) {
        print('exception ${_.toString()}');
      }
    });
  }


  getLeadData(String accessKey, String? userSecurityKey, int leadId, String? empID) async {
     try {
      version = VersionClass.getVersion();
       final response = await get(
        Uri.parse(UrlConstants.getLeadData2 + "$leadId"+"&referenceID=$empID"),
         headers:
         requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version) ,
      );
      if (response.statusCode == 200) {
        Get.back();

        var data = json.decode(response.body);

        ViewLeadDataResponse viewLeadDataResponse = ViewLeadDataResponse.fromJson(data);
        return viewLeadDataResponse;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  Future<ViewLeadDataResponse?>getLeadDataNew(String? accessKey, String? userSecurityKey, int? leadId, String? empID) async {
    ViewLeadDataResponse? viewLeadDataResponse;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));

    try {
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getLeadData2 + "$leadId"+"&referenceID=$empID"),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version) ,
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          viewLeadDataResponse = ViewLeadDataResponse.fromJson(json.decode(response.body));
        }} else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at INF Repo $e");
    }
    return viewLeadDataResponse;
  }

  updateLeadsData(accessKey, String? userSecurityKey, var updateRequestModel,
      List<File?> imageList, BuildContext context, int? leadId,int from) async {
    version = VersionClass.getVersion();
    http.MultipartRequest request = new http.MultipartRequest(
        'POST', Uri.parse(UrlConstants.updateLeadsData));
    request.headers.addAll(requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version));
    for (var file in imageList) {
      String fileName = file!.path.split("/").last;
      var stream = new http.ByteStream(file.openRead());
      stream.cast();
      var length = await file.length();
      var multipartFileSign =
          new http.MultipartFile('file', stream, length, filename: fileName);

      request.files.add(multipartFileSign);

    }
    String empId;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      gv.currentId = empId;

      request.fields['uploadImageWithUpdateLeadModel'] =
          json.encode(updateRequestModel);


      try {
        request
            .send()
            .then((result) async {
              http.Response.fromStream(result).then((response) {
                var data = json.decode(response.body);
                UpdateLeadResponseModel updateLeadResponseModel =
                UpdateLeadResponseModel.fromJson(data);
                if(data["resp_code"] == "DM1005"){
                    Get.dialog(CustomDialogs.appUserInactiveDialog(
                        data["resp_msg"]), barrierDismissible: false);
                  }
                else{
                if (updateLeadResponseModel.respCode == "LD2009") {
                  gv.selectedLeadID = updateLeadResponseModel.leadId;


                  Get.back();
                  Get.back();
                  Get.back();
                  Get.dialog(CustomDialogs.showDialogSubmitLead(
                      updateLeadResponseModel.respMsg!, from, context), barrierDismissible: false);
                } else if (updateLeadResponseModel.respCode == "ED2011") {
                  Get.back();
                  Get.dialog(CustomDialogs
                      .showDialog(updateLeadResponseModel.respMsg!), barrierDismissible: false);
                }
                else {
                  Get.back();
                  Get.dialog(
                    CustomDialogs.showDialog("Some Error Occurred !!! "),
                  );
                }
              }
              });
            });
      } catch (_) {
        print('exception ${_.toString()}');
      }

    });
  }

  Future<LeadsListModel?> getSearchDataNew(String? accessKey, String? userSecurityKey, String? empID, String searchText) async {
    LeadsListModel? leadsListModel;
    try {
      String url = "${UrlConstants.getSearchData}searchText=$searchText&referenceID=$empID";
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecurityKey,version) );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        leadsListModel = LeadsListModel.fromJson(data);
        if(leadsListModel.respCode == "DM1005"){
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              leadsListModel.respMsg!), barrierDismissible: false);
        }
      } else
        print('error');
    } catch (_) {
      print('exception at Lead repo ${_.toString()}');
    }
    return leadsListModel;

  }

  Future<InfluencerDetailModel?> getInfNewData(String? accessKey,
      String? userSecretKey, String contact) async {
    InfluencerDetailModel? infDetailModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.getInfluencerDetail + "$contact"),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey, userSecretKey,version) );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          infDetailModel = InfluencerDetailModel.fromJson(json.decode(response.body));
        }} else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at EG Repo $e");
    }

    return infDetailModel;
  }

  Future<TotalPotentialModel?> getTotalPotential(accessKey, String? userSecretKey, var updateRequestModel) async {
    TotalPotentialModel? totalPotentialModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try {
      version = VersionClass.getVersion();
      var response = await http.post(Uri.parse(UrlConstants.getTotalSitePotential),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version) ,
        body: json.encode(updateRequestModel),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs.appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          totalPotentialModel = TotalPotentialModel.fromJson(json.decode(response.body));
        }} else {
        print('error');
      }
    }
    catch (e) {
      print("Exception at Lead Repo $e");
    }

    return totalPotentialModel;
  }


  Future<SiteDistrictListModel?> getLeadDistList(String? accessKey, String? userSecretKey, String empID) async {
    SiteDistrictListModel? siteDistrictListModel;
    try {
      version = VersionClass.getVersion();

      var response = await http.get(Uri.parse(UrlConstants.leadDistList + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs.appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        siteDistrictListModel = SiteDistrictListModel.fromJson(json.decode(response.body));
      }
    }
    catch (e) {
      print("Exception at Lead Repo .... $e");
    }
    return siteDistrictListModel;
  }

}
