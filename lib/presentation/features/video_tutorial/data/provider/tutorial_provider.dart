import 'dart:convert';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/model/TsoAppTutorialListModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/widgets/custom_dialogs.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';



class MyApiClient {
  final http.Client httpClient;
  String? version;

  MyApiClient({required this.httpClient});

  Future<AccessKeyModel?> getAccessKey() async {
    try {
      version = VersionClass.getVersion();
      var response = await httpClient.get(Uri.parse(UrlConstants.getAccessKey),
          headers: requestHeaders(version) as Map<String, String>?);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception at Tutorial repo ${_.toString()}');
    }
  }


  Future<TsoAppTutorialListModel?> getAppTutorialListData(String? accessKey, String? userSecretKey) async{
    TsoAppTutorialListModel? tsoAppTutorialListModel;
    try{
      version = VersionClass.getVersion();
      var response = await http.get(Uri.parse(UrlConstants.AppTutorialList),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey,version) as Map<String, String>?);
      var data = json.decode(response.body);
      if(data["resp_code"] == "DM1005"){
        Get.dialog(CustomDialogs().appUserInactiveDialog(
            data["resp_msg"]), barrierDismissible: false);
      }else {
        tsoAppTutorialListModel =
            TsoAppTutorialListModel.fromJson(json.decode(response.body));
      }
    }
    catch(e){
      print("Exception at Tutorial Repo $e");
    }
    return tsoAppTutorialListModel;
  }
}