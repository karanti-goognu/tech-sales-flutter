import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/glitch/glitch.dart';
import 'package:flutter_tech_sales/core/helper/login_helper.dart';
import 'package:flutter_tech_sales/core/model/LoginModel.dart';

class LoginProvider extends ChangeNotifier {
  final _helper = LoginHelper();
  final _streamController = StreamController<Either<Glitch, LoginModel>>();

  Stream<Either<Glitch, LoginModel>> get loginStream {
    return _streamController.stream;
  }

  Future<void> getLoginStatus() async {
    final loginHelperResult = await _helper.checkEmpIDAndContact();
    print('$loginHelperResult');
    _streamController.add(loginHelperResult);
    print('$loginStream');
  }

/*void refreshGird() {
    getTwentyRandomPhoto();
  }*/
}
