import 'package:flutter_tech_sales/utils/functions/check_internet.dart';

 Future<bool> internetChecking() async {
  bool result = await CheckInternet.hasConnection();
  return result;
}

