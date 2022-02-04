import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:async/async.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/UpdateLeadResponseModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/KittyBagsListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/Pending.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/PendingSupplyDetails.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteDistrictListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SiteVisitRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/SitesListModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/UpdateSiteModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
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

class MyApiClientSites {
  final http.Client httpClient;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String version;

  MyApiClientSites({@required this.httpClient});

  getAccessKey() async {
    try {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // version = packageInfo.version;
      version = VersionClass.getVersion();
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders(version));
      // print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  Future getAccessKeyNew() async {
    try {
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // version = packageInfo.version;
      version = VersionClass.getVersion();
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders(version));
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
    try {
      version = VersionClass.getVersion();
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': version,
        'reference-id': empId,
        'mobile-number': mobile,
      };

      var response = await httpClient.get(UrlConstants.getSecretKey,
          headers: requestHeadersEmpIdAndNo);
      // print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SecretKeyModel secretKeyModel = SecretKeyModel.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return secretKeyModel;
      } else {
        print('Error in else');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  getFilterData(String accessKey) async {
    try {
      version = VersionClass.getVersion();
      String userSecurityKey = "empty";
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      _prefs.then((SharedPreferences prefs) {
        userSecurityKey =
            prefs.getString(StringConstants.userSecurityKey) ?? "empty";
        print('$userSecurityKey');
      });
      if (userSecurityKey == "empty") {
        var response = await httpClient.get(UrlConstants.getFilterData,
            headers: requestHeadersWithAccessKeyAndSecretKey(
                accessKey, userSecurityKey, version));
        // print('Response body is : ${json.decode(response.body)}');
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
          //print('Access key Object is :: $accessKeyModel');
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

  getSitesData(String accessKey, String securityKey, String url) async {
    try {
      //debugPrint('in get posts: ${UrlConstants.loginCheck}');
      version = VersionClass.getVersion();
      final response = await get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, securityKey, version));
      //var response = await httpClient.post(UrlConstants.loginCheck);
      // print('response is :  ${response.body}');
      if (response.statusCode == 200) {
        // print('success');
        var data = json.decode(response.body);
        SitesListModel sitesListModel = SitesListModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        //print('Response body is : ${json.decode(response.body)}');
        return sitesListModel;
      } else
        print('error in else');
    } catch (_) {
      print('error in catch ${_.toString()}');
    }
  }

  getSearchData(String accessKey, String securityKey, String url) async {
    try {
      //debugPrint('in get posts: ${UrlConstants.loginCheck}');
      version = VersionClass.getVersion();
      final response = await get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, securityKey, version));
      //var response = await httpClient.post(UrlConstants.loginCheck);
     // print('response is :  ${response.body}');
      if (response.statusCode == 200) {
        // print('success');
        var data = json.decode(response.body);
        SitesListModel sitesListModel = SitesListModel.fromJson(data);
        //print('Access key Object is :: $loginModel');
        return sitesListModel;
      } else
        print('error in else');
    } catch (_) {
     // print('error in catch ${_.toString()}');
    }
  }

  getSiteDetailsData(String accessKey, String userSecurityKey, int siteId,
      String empID) async {
    try {
      version = VersionClass.getVersion();
      String url = UrlConstants.getSiteDataVersion4 + "$siteId&referenceID=$empID";
      print(url);
      final response = await get(
        Uri.parse(UrlConstants.getSiteDataVersion4 + "$siteId&referenceID=$empID"),
        headers: requestHeadersWithAccessKeyAndSecretKey(
            accessKey, userSecurityKey, version),
      );
print("URL:$url ");
      // print(
      //     'Response body is  ---: ${json.decode(response.body)['siteVisitHistoryEntity']}');
      if (response.statusCode == 200) {
        // Get.back();
        var data = json.decode(response.body);
        // print('@@@@');
        //print(data);
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }else{
        ViewSiteDataResponse viewSiteDataResponse = ViewSiteDataResponse.fromJson(data);

        // print('@@@@');
        // print(viewSiteDataResponse.counterListModel[0].soldToParty);
        // print('SITE VISIT: ${json.encode(viewSiteDataResponse.mwpVisitModel)}');
        if (viewSiteDataResponse.respCode == "ST2010") {
          return viewSiteDataResponse;
        } else if (viewSiteDataResponse.respCode == "ST2011") {
          Get.back();
          Get.dialog(CustomDialogs().showDialog(viewSiteDataResponse.respMsg));
        }
        else {
          Get.back();
          Get.dialog(CustomDialogs().showDialog("Some Error Occured !!! "));
        }
      }
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }

  updateSiteData(accessKey, String userSecurityKey, updateDataRequest,
      List<File> list, BuildContext context, int siteId) async {
    version = VersionClass.getVersion();
    http.MultipartRequest request = new http.MultipartRequest(
        'POST', Uri.parse(UrlConstants.updateSiteData));
    print(UrlConstants.updateSiteData);
    request.headers.addAll(
        requestHeadersWithAccessKeyAndSecretKeywithoutContentType(
            accessKey, userSecurityKey, version));

    // print(json.encode(updateDataRequest));

    // updateDataRequest['siteVisitHistoryEntity'].forEach((e) => print(e));

    for (var file in list) {
      String fileName = file.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

      // get file length
      var length = await file.length(); //imageFile is your image file

      // multipart that takes file
      var multipartFileSign =
      new http.MultipartFile('file', stream, length, filename: fileName);

      request.files.add(multipartFileSign);
    }

    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";

      gv.currentId = empId;

      request.fields['uploadImageWithUpdateSiteModel'] =
          json.encode(updateDataRequest);

      /// rint(saveLeadRequestModel.comments[0].commentedBy);
      print("Request headers :: " + request.headers.toString());
      print("Request Body/Fields :: " +
          request.fields['siteInfluencerEntity'].toString());
      print("Files:: " + request.files.toString());
      try {
        request
            .send()
            .then((result) async {
          http.Response.fromStream(result).then((response) {
            // print("---@@---");
            // print(response.body);

            var data = json.decode(response.body);
            //    print(data);

            //      print(response.body)  ;
            UpdateLeadResponseModel updateLeadResponseModel =
            UpdateLeadResponseModel.fromJson(data);
            //  print(response.body);
            if (updateLeadResponseModel.respCode == "ST2033") {
              Get.back();
              Get.dialog(CustomDialogs()
                  .showDialog(updateLeadResponseModel.respMsg));
            } else {
              Get.dialog(CustomDialogs()
                  .showDialog(updateLeadResponseModel.respMsg));
            }
          });
        })
            .catchError((err) => print('error : ' + err.toString()))
            .whenComplete(() {});
      } catch (_) {
        print('exception ${_.toString()}');
      }
    });
  }

  updateVersion2SiteData(accessKey, String userSecurityKey, updateDataRequest,
      List<File> list, BuildContext context, int siteId) async {
    version = VersionClass.getVersion();
    http.MultipartRequest request = new http.MultipartRequest(
        'POST', Uri.parse(UrlConstants.updateVersion4SiteData));
    print(UrlConstants.updateVersion4SiteData);
    request.headers.addAll(
        requestHeadersWithAccessKeyAndSecretKeywithoutContentType(
            accessKey, userSecurityKey, version));

    updateDataRequest['siteStageHistorys'].forEach((e) => print(e));

    for (var file in list) {
      String fileName = file.path.split("/").last;
      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

      // get file length
      var length = await file.length(); //imageFile is your image file

      // multipart that takes file
      var multipartFileSign =
      new http.MultipartFile('file', stream, length, filename: fileName);

      request.files.add(multipartFileSign);
    }

    String empId;
    String mobileNumber;
    String name;
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((SharedPreferences prefs) async {
      empId = prefs.getString(StringConstants.employeeId) ?? "empty";
      mobileNumber = prefs.getString(StringConstants.mobileNumber) ?? "empty";
      name = prefs.getString(StringConstants.employeeName) ?? "empty";

      gv.currentId = empId;

      request.fields['uploadImageWithUpdateSiteModel'] = json.encode(updateDataRequest);

      /// rint(saveLeadRequestModel.comments[0].commentedBy);
      print("Request headers :: " + request.headers.toString());
      print("###${request.fields}");
      print("Request Body/Fields :: " +
          request.fields['siteInfluencerEntity'].toString());
      print("Files:: " + request.files.toString());
      log("Site Body--> "+json.encode(updateDataRequest));
      try {
        request
            .send()
            .then((result) async {
          http.Response.fromStream(result).then((response) {
            // print("---@@---");
            // print(response.body);

            var data = json.decode(response.body);
            //    print(data);

            //      print(response.body)  ;
            if(data["resp_code"] == "DM1005"){
              Get.dialog(CustomDialogs().appUserInactiveDialog(
                  data["resp_msg"]), barrierDismissible: false);
            }else{
            UpdateSiteModel updateLeadResponseModel =
            UpdateSiteModel.fromJson(data);
            print(response.body);
            if (updateLeadResponseModel.respCode == "ST2033") {
              Get.back();
              Get.dialog(CustomDialogs()
                  .showDialog(updateLeadResponseModel.respMsg));
            }
            else {
              Get.dialog(CustomDialogs()
                  .showDialog(updateLeadResponseModel.respMsg));
            }
          }
          });
        })
            .catchError((err) => print('error : ' + err.toString()))
            .whenComplete(() {});
      } catch (_) {
        print('exception ${_.toString()}');
      }
    });
  }


  Future<SitesListModel> getSearchDataNew(String accessKey,
      String userSecurityKey, String empID, String searchText) async {
    try {
      version = VersionClass.getVersion();
      String url =
          "${UrlConstants.getSiteSearchData}searchText=${searchText}&referenceID=$empID";
      print(url);
      var response = await httpClient.get(url,
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecurityKey, version));
      // print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        SitesListModel sitesListModel = SitesListModel.fromJson(data);
        return sitesListModel;
      } else
        print('error');
    } catch (_) {
      print('exception at EG repo ${_.toString()}');
    }
  }


  // Future<SiteVisitResponseModel>siteVisitSave(String accessKey, String userSecretKey, SiteVisitRequestModel siteVisitRequestModel) async {
  //   SiteVisitResponseModel siteVisitResponseModel;
  //   try{
  //     version = VersionClass.getVersion();
  //     var response = await http.post(Uri.parse(UrlConstants.saveUpdateSiteVisit),
  //       headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
  //       body: json.encode(siteVisitRequestModel),
  //     );
  //     print("URL ${UrlConstants.saveUpdateSiteVisit}");
  //     print('Request : ${response.request}');
  //     print('RESPONSE : ${json.encode(siteVisitRequestModel)}');
  //
  //     var data = json.decode(response.body);
  //       siteVisitResponseModel =
  //           SiteVisitResponseModel.fromJson(json.decode(response.body));
  //   }
  //   catch(e){
  //     print("Exception at EG Repo $e");
  //   }
  //   return siteVisitResponseModel;
  // }

  Future<SiteVisitResponseModel>siteVisitSave(String accessKey, String userSecretKey, SiteVisitRequestModel siteVisitRequestModel) async {
    SiteVisitResponseModel siteVisitResponseModel;
    Future.delayed(Duration.zero, ()=>Get.dialog(Center(child: CircularProgressIndicator())));
    try{
      version = VersionClass.getVersion();
      var response = await http.post(Uri.parse(UrlConstants.saveUpdateSiteVisit),
        headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version),
        body: json.encode(siteVisitRequestModel),
      );
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.back();
        print("======$data");
        print("======${UrlConstants.saveUpdateSiteVisit}");
        if (data["resp_code"] == "DM1005") {
          Get.dialog(CustomDialogs().appUserInactiveDialog(
              data["resp_msg"]), barrierDismissible: false);
        }
        else {
          siteVisitResponseModel = SiteVisitResponseModel.fromJson(json.decode(response.body));
        }} else {
        print('error');
      }
    }
    catch(e){
      print("Exception at site Repo $e");
    }
    return siteVisitResponseModel;
  }

  getPendingSupplyData(String accessKey, String securityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      final response = await get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, securityKey, version));
      if(response.statusCode==200) {
        var data = json.decode(response.body);
        PendingSupplyData pendingSupplyData = PendingSupplyData.fromJson(data);
        PendingSupplyDataResponse pendingSupplyDataResponse = pendingSupplyData.response;
        print(pendingSupplyDataResponse);
        return pendingSupplyDataResponse;
      }else
        print('error');
    } catch (_) {
      // print('error in catch ${_.toString()}');
    }
  }

  getPendingSupplyDetails(String accessKey, String securityKey, String url) async {
    try {
      version = VersionClass.getVersion();
      final response = await get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, securityKey, version));
      if(response.statusCode==200) {
        var data = json.decode(response.body);
        print(data);
        PendingSupplyDetails pendingSupplyData = PendingSupplyDetails.fromJson(data);
        PendingSupplyDetailsEntity pendingSupplyDataResponse = pendingSupplyData.response;
        return pendingSupplyDataResponse;
      }else
        print('error');
    } catch (_) {
      // print('error in catch ${_.toString()}');
    }
  }

  updatePendingSupplyDetails(String accessKey, String securityKey, String url,Map<String, dynamic> jsonData) async {
    try {
      version = VersionClass.getVersion();
      print(url);
      final response = await http.put(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, securityKey, version),
          body: json.encode(jsonData));
      // log(""+json.encode(jsonData));
      if(response.statusCode==200) {
        String data = response.body;
        return json.decode(data);
      }else
        print('error');
    } catch (_) {
      // print('error in catch ${_.toString()}');
    }
  }


  ///district list for filter
  Future<SiteDistrictListModel> getSiteDistList(String accessKey, String userSecretKey, String empID) async {
    SiteDistrictListModel siteDistrictListModel;
    try {
      version = VersionClass.getVersion();

      var response = await http.get(Uri.parse(UrlConstants.siteDistList + empID),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        siteDistrictListModel = SiteDistrictListModel.fromJson(json.decode(response.body));
        print(response.body);
      }
    }
    catch (e) {
      print("Exception at Site Repo $e");
    }
    return siteDistrictListModel;
  }

  Future<KittyBagsListModel> getKittyBagsList(String accessKey, String partyCode, String userSecretKey,) async {
    KittyBagsListModel kittyBagsListModel;
    try {
      version = VersionClass.getVersion();
      String url = UrlConstants.siteKittyPoints + "$partyCode";
      print(url);
      var response = await http.get(Uri.parse(url),
          headers: requestHeadersWithAccessKeyAndSecretKey(
              accessKey, userSecretKey,version));
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        kittyBagsListModel = KittyBagsListModel.fromJson(json.decode(response.body));
        print(response.body);
      }
    }
    catch (e) {
      print("Exception at Site Repo $e");
    }
    return kittyBagsListModel;
  }


}