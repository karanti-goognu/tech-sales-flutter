import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_tech_sales/core/glitch/no_internet_glitch.dart';
import 'package:flutter_tech_sales/core/glitch/glitch.dart';
import 'package:flutter_tech_sales/core/model/LoginModel.dart';
import 'package:flutter_tech_sales/network/login_apis.dart';

class LoginHelper {
  final api = LoginApi();
  Future<Either<Glitch, LoginModel>> checkEmpIDAndContact() async {
    final apiResult = await api.checkEmpIDAndContact();
    return apiResult.fold((l) {
      // There can be many types of error but, for simplicity, we are going
      // to assume only NoInternetGlitch
      return Left(NoInternetGlitch());
    }, (r) {
      // the API returns breed, id, url, width, height, category, details etc
      // but we will take only the information we need in our app and ignore
      // the rest
      // here we will decode API result to CatPhoto
      final loginModel = LoginModel.fromMap(jsonDecode(r)[0]);
      return Right(loginModel);
    });
  }
}
