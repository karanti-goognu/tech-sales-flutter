
import 'package:http/http.dart';

final client = Client();


abstract class UrlConstants {

  //Base Url
  //static const String baseUrl = 'https://mobileapps.dalmiabharat.com/tech-sales-server';
  static const String baseUrl = 'https://mobiledevcloud.dalmiabharat.com/tech_sales_server';

  //End points
  static const String loginCheck = '$baseUrl/login/login-otp';
  static const String getAccessKey = '$baseUrl/validation/generate-access-key';
  static const String retryOtp = '$baseUrl/login/login-otp-retry';
  static const String validateOtp = '$baseUrl/login/login-otp-validate';
}
