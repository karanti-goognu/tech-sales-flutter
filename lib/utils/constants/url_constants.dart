
import 'package:http/http.dart';

final client = Client();

abstract class UrlConstants {
  static const String baseUrl = 'https://xyz.com';
  static const String globalInfo = '$baseUrl/all';
  static const String allCountries = '$baseUrl/countries';
}
