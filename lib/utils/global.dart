import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_tech_sales/network/network_calls.dart';
import 'package:shared_preferences/shared_preferences.dart';




final netWorkCalls = NetworkCalls();

final mySharedPreferences = MySharedPreferences();

final RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
final Function mathFunc = (Match match) => '${match[1]},';

abstract class SharedPreferencesKeys {
  static const String isDarkTheme = 'isDarkTheme';
  static const String homeCountryDetails = 'homeCountry';
}

class MySharedPreferences {
  Future<List<String>> fetchHomeCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList(SharedPreferencesKeys.homeCountryDetails);
    if (list != null) {
      return list;
    }
    return null;
  }

/*Future setHomeCountry(HomeCountry country) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(SharedPreferencesKeys.homeCountryDetails, <String>[
      country.name,
      country.cases,
      country.deaths,
    ]);
  }*/
}

Future<bool> internetChecking() async {
  // do something here
  bool result = await DataConnectionChecker().hasConnection;
  return result;
}

