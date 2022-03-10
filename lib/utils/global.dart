import 'package:flutter_tech_sales/utils/functions/check_internet.dart';

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
  static const String homeCountryDetails = 'homeCountry';
}

 Future<bool> internetChecking() async {
  bool result = await CheckInternet.hasConnection();
  return result;
}

