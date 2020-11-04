import 'package:flutter_tech_sales/utils/constants/string_constants.dart';


Map<String, String> requestHeaders = {
  'Content-type': 'application/json',
  'app-name': StringConstants.appName,
  'app-version': StringConstants.appVersion,
  'access-token': StringConstants.accessToken,
};

Map<String, String> requestHeadersWithAccessKey(String accessKey) {
  Map<String, String> requestHeaders = new Map();
  requestHeaders = {
    'Content-type': 'application/json',
    'app-name': StringConstants.appName,
    'app-version': StringConstants.appVersion,
    'access-key': accessKey,
  };
  return requestHeaders;
}
