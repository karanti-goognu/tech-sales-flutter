import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  SplashController eventController = Get.find();
  SplashDataModel _splashDataModel;
  var data;
  getData() async {
    await eventController.getAccessKey(RequestIds.REFRESH_DATA);
        // .then((value) async {
      print(eventController.splashDataModel.srComplainResolutionEntity[0].toJson());
    // });
  }

  @override
  void initState() {
    getData();
    // getData().whenComplete((){
    //   setState(() {
    //     _splashDataModel=data;
    //   });
    //   print(_splashDataModel.srComplaintTypeEntity);
    // });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text('Hello'
          )
        ],
      ),
    );
  }
}
