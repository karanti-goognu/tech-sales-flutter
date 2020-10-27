import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/animations/routes_animation.dart';
import 'package:flutter_tech_sales/presentation/features/login/view/login.dart';
import 'package:flutter_tech_sales/utils/color_constants.dart';

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
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context)
            .push(RoutesAnimation.createRoute(LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(
          child: Text(
        "TSO App",
        style: TextStyle(color: ColorConstants.blackColor, fontSize: 32,fontFamily: "Raleway"),
      )),
    );
  }
}
