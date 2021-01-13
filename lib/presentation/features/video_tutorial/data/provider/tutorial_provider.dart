
import 'dart:convert';

import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/model/TsoAppTutorialListModel.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:flutter_tech_sales/core/data/models/AccessKeyModel.dart';



class MyApiClient {
  final http.Client httpClient;

  MyApiClient({@required this.httpClient});

  Future<AccessKeyModel> getAccessKey() async {
    try {
      // print('$requestHeaders');
      var response = await httpClient.get(UrlConstants.getAccessKey,
          headers: requestHeaders);
      // print('Response body is : ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        AccessKeyModel accessKeyModel = AccessKeyModel.fromJson(data);
        //print('Access key Object is :: $accessKeyModel');
        return accessKeyModel;
      } else
        print('error');
    } catch (_) {
      print('exception at Tutorial repo ${_.toString()}');
    }
  }


  Future<TsoAppTutorialListModel> getAppTutorialListData(String accessKey, String userSecretKey) async{
    TsoAppTutorialListModel tsoAppTutorialListModel;
    try{
      //+'&offset=30'
      var response = await http.get(Uri.parse(UrlConstants.AppTutorialList),
          headers: requestHeadersWithAccessKeyAndSecretKey(accessKey,userSecretKey));
      //print(response.body);
      tsoAppTutorialListModel = TsoAppTutorialListModel.fromJson(json.decode(response.body));
      print(response.body);
    }
    catch(e){
      print("Exception at Tutorial Repo $e");
    }
    return tsoAppTutorialListModel;
  }
}