import 'dart:convert';
import 'dart:developer';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SecretKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/AccessKeyModel.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/utils/constants/VersionClass.dart';
import 'package:flutter_tech_sales/utils/constants/string_constants.dart';
import 'package:flutter_tech_sales/utils/constants/url_constants.dart';
import 'package:flutter_tech_sales/utils/functions/request_maps.dart';
import 'package:http/http.dart' as http;

class MyApiClientSplash {
  final http.Client httpClient;
  String? version;

  MyApiClientSplash({required this.httpClient});

  Future<AccessKeyModel> getAccessKey() async {
    late AccessKeyModel accessKeyModel;
    try {
      version = VersionClass.getVersion();
      Uri uri = Uri.parse(UrlConstants.getAccessKey);
      var response = await httpClient.get(uri, headers: requestHeaders(version));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        accessKeyModel = AccessKeyModel.fromJson(data);
      } else
        print('error');
    } catch (_) {
      print('exception ${_.toString()}');
    }
    return accessKeyModel;
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

      Uri uri = Uri.parse(UrlConstants.getSecretKey);
      var response = await httpClient.get(uri,
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

  getRefreshData(String url, String accessKey, String securityKey) async {
    version = VersionClass.getVersion();
    try {
      Map<String, String> requestHeadersEmpIdAndNo = {
        'Content-type': 'application/json',
        'app-name': StringConstants.appName,
        'app-version': version!,
        'access-key': accessKey,
        'user-security-key': securityKey,
      };
      Uri uri= Uri.parse(url);

      var response = await httpClient.get(uri, headers: requestHeadersEmpIdAndNo);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        log("Data: $data");
        SplashDataModel splashDataModel = SplashDataModel.fromJson(data);
        return splashDataModel;
      } else {
        print('Error in else');
      }
    } catch (_) {
      print('exception ${_.toString()}');
    }
  }
}
