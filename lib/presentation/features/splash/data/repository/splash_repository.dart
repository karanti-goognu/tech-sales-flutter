
import 'dart:io';

import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/provider/leads_provider.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/provider/splash_provider.dart';
import 'package:meta/meta.dart';

class MyRepositorySplash {
  final MyApiClientSplash apiClient;

  MyRepositorySplash({@required this.apiClient}) : assert(apiClient != null);

  getAccessKey() {
    return apiClient.getAccessKey();
  }

  getSecretKey(String empId,String mobileNumber) {
    return apiClient.getSecretKey(empId,mobileNumber);
  }
}
