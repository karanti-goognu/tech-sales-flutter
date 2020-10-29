
import 'package:http/http.dart';

final client = Client();

abstract class UrlConstants {
  static const String baseUrl = 'https://mobileapps.dalmiabharat.com/tech-sales-server';
  static const String loginCheck = '$baseUrl/login/login-otp';
  static const String allCountries = '$baseUrl/countries';
}
