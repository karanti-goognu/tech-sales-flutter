import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/core/data/controller/app_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/controller/mwp_plan_controller.dart';
import 'package:flutter_tech_sales/presentation/features/mwp/view/add_mwp_plan_view.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/constants/request_ids.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';


import 'package:intl/intl.dart';

class AddMWP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddMWPScreenPageState();
  }
}

class AddMWPScreenPageState extends State<AddMWP> {
  MWPPlanController _mwpPlanController = Get.find();
  AppController _appController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(json.encode(_mwpPlanController.getMWPResponse));
      print(1);
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('MMMM-yyyy');
      final String formatted = formatter.format(now);
      _mwpPlanController.selectedMonth = formatted;


      _appController.getAccessKey(RequestIds.GET_MWP_PLAN);
      _mwpPlanController.isLoading = true;
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomPadding: false,
      body: _buildAddEventInterface(context),
      floatingActionButton: Container(
        height: 68.0,
        width: 68.0,
        child: BackFloatingButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget _buildAddEventInterface(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        "MWP Planning",
                        style: TextStyle(
                            color: ColorConstants.greenText,
                            fontFamily: "Muli-Semibold.ttf",
                            fontSize: 20,
                            letterSpacing: .15),
                      ),
                    ),
                    Obx(
                          () =>
                      (_mwpPlanController.getMWPResponse.listOfMonthYear != null) ?
                      Flexible(
                        flex: 2,
                              child: Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 4, 4, 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                    boxShadow: [
                                      new BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 8.0,
                                      ),
                                    ],
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Obx(
                                      () => DropdownButton<String>(
                                        value: _mwpPlanController.selectedMonth,
                                        onChanged: (String newValue) {
                                          _mwpPlanController.selectedMonth =
                                              newValue;
                                          _appController.getAccessKey(
                                              RequestIds.GET_MWP_PLAN);
                                          _mwpPlanController.isLoading = true;
                                        },
                                        items: _mwpPlanController
                                            .getMWPResponse.listOfMonthYear
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value, style: TextStyle(
                                                  fontSize: SizeConfig.safeBlockHorizontal*3.5,
                                                  fontWeight: FontWeight.bold),

                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )),
                            ) : Container(
//                        child: Text("Error"),
                      child: CupertinoActivityIndicator(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                AddMWPPlan(),
              ],
            )),
      ),
    );
  }
}


