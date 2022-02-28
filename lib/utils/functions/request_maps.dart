import 'package:flutter_tech_sales/utils/constants/string_constants.dart';


Map<String, String> requestHeaders(String version){
  Map<String, String> requestHeaders = new Map();
  requestHeaders= {
    'Content-type': 'application/json',
    'app-name': StringConstants.appName,
    'app-version': version,
    'access-token': StringConstants.accessToken,
  };
  return requestHeaders;
}

Map<String, String> requestHeadersWithAccessKey(String accessKey, String version) {
  Map<String, String> requestHeaders = new Map();
  requestHeaders = {
    'Content-type': 'application/json',
    'app-name': StringConstants.appName,
    'app-version': version,
    'access-key': accessKey,
  };

  return requestHeaders;
}

Map<String, String> requestHeadersWithAccessKeyAndSecretKey(String accessKey , String userSecurityKey, String version) {
  Map<String, String> requestHeaders = new Map();
  requestHeaders = {
    'Content-type': 'application/json',
    'app-name': StringConstants.appName,
    'app-version': version,
    'access-key': accessKey,
    'user-security-key' : userSecurityKey
  };

  return requestHeaders;
}

Map<String, String> requestHeadersWithAccessKeyAndSecretKeywithoutContentType(String accessKey , String userSecurityKey, String version) {

  Map<String, String> requestHeaders = new Map();
  requestHeaders = {
    'app-name': StringConstants.appName,
    'app-version': version,
    'access-key': accessKey,
    'user-security-key' : userSecurityKey
  };
  return requestHeaders;
}

Map<String, String> requestHeadersWithAccessKeyAndSecretKeyAndReferenceId(String accessKey , String userSecurityKey, String version, String refernceId) {
  Map<String, String> requestHeaders = new Map();
  requestHeaders = {
    'Content-type': 'application/json',
    'app-name': StringConstants.appName,
    'app-version': version,
    'access-key': accessKey,
    'user-security-key' : userSecurityKey,
    'reference-id' : refernceId
  };

  return requestHeaders;
}
