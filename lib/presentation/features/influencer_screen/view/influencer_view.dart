import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class InfluencerView extends StatefulWidget {
  @override
  _InfluencerViewState createState() => _InfluencerViewState();
}

class _InfluencerViewState extends State<InfluencerView> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // disposeController(context);
          Get.offNamed(Routes.HOME_SCREEN);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: ColorConstants.backgroundColorGrey,
          appBar: AppBar(
            backgroundColor: ColorConstants.appBarColor,
            toolbarHeight: SizeConfig.screenHeight * .14,
            centerTitle: false,
            title:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                // mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "INFLUENCER",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: "Muli"),
                  ),
                ],
              ),
            ]),
            automaticallyImplyLeading: false,
          ),
          floatingActionButton:
              SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigator(),
          body: Container(),
        ));
  }
}

/*
class _InfluencerViewState extends State<InfluencerView> {
  Color _color= ColorConstants.backgroundColorBlue;
  final random = Random();
  Duration oneSec = const Duration(seconds:1);
  changeColors(){
    new Timer.periodic(oneSec, (Timer t) =>
    setState(() {
      _color = Color.fromRGBO(
        random.nextInt(100),
        random.nextInt(56),
        random.nextInt(256),
        0.1,
      );
    }));
  }
  @override
  void initState() {
    if(!this.mounted){
      changeColors();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BackFloatingButton(),
     body: AnimatedContainer(
       height: MediaQuery.of(context).size.height,
       width:MediaQuery.of(context).size.width,
       color: Colors.white,
       // color: _color,
       child: Center(child: Text("Page coming soon",),),
     duration: Duration(seconds: 4),curve: Curves.fastOutSlowIn,),
    );
  }

}

 */
