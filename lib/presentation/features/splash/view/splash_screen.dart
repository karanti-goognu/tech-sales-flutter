import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenPageState();
  }
}

class SplashScreenPageState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () => Get.toNamed(Routes.LOGIN));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Container(
          child: Center(
              child: Text(
        "TSO App",
        style: TextStyle(
            color: ColorConstants.blackColor,
            fontSize: 32,
            fontFamily: "Raleway"),
      ))),
    );
  }
}
