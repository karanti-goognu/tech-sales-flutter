
import 'package:http/http.dart';

final client = Client();


abstract class UrlConstants {

  //Base Url
  //static const String baseUrl = 'https://mobileapps.dalmiabharat.com/tech-sales-server';
  static const String baseUrl = 'https://mobiledevcloud.dalmiabharat.com/tech_sales_server';

  static const String baseUrlforImages = 'https://mobiledevcloud.dalmiabharat.com/tso/leads';

  //End points
  static const String loginCheck = '$baseUrl/login/login-otp';
  static const String getAccessKey = '$baseUrl/validation/generate-access-key';
  static const String getSecretKey = '$baseUrl/validation/generate-secret-key';
  static const String retryOtp = '$baseUrl/login/login-otp-retry';
  static const String validateOtp = '$baseUrl/login/login-otp-validate';
  static const String getFilterData = '$baseUrl/leads/lead-filter-data';
  static const String getLeadsData = '$baseUrl/leads/lead-list-view?referenceID=';
  static const String addLeadsData = '$baseUrl/leads/lead-new';
  static const String getInflData = '$baseUrl/influencer/getDetails';
  static const String saveLeadsData = '$baseUrl/leads/lead-save';
  static const String refreshSplashData = '$baseUrl/refresh/refresh-data?referenceID=';
  static const String getLeadData = '$baseUrl/leads/view-lead?leadId=';

  static const String getSearchData = '$baseUrl/leads/lead-search?referenceID=';
  static const String getCheckInDetails = '$baseUrl/journey/details';
}
