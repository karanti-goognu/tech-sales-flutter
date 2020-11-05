import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/model/LoginModel.dart';
import 'package:flutter_tech_sales/presentation/features/login/data/repository/login_repository.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final MyRepository repository;

  SplashController({@required this.repository}) : assert(repository != null);

  final _login = LoginModel().obs;

  get login => this._login.value;

  set login(value) => this._login.value = value;

  getAll() {}

  openLoginPage() {
    Timer(Duration(seconds: 3), () => Get.off(LoginScreen()));
  }
}
