import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/month_to_date.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:flutter_tech_sales/presentation/features/splash/controller/splash_controller.dart';
import 'package:flutter_tech_sales/presentation/features/splash/data/models/SplashDataModel.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

import 'package:screenshot/screenshot.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DashboardController _dashboardController = Get.find();
  SplashController _splashController = Get.find();
  List<ReportingTsoListModel> _employeeDropDownData;
  String empID;


  ScreenshotController screenshotController = ScreenshotController();
  @override
  void initState() {
    _dashboardController.getMonthViewDetails();
    print(_splashController.splashDataModel.reportingTsoListModel);
    _employeeDropDownData=_splashController.splashDataModel.reportingTsoListModel;
    print('--');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('height');
    print(MediaQuery.of(context).size.height);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
            title: Text('MY DASHBOARD'),
            backgroundColor: ColorConstants.appBarColor,
            bottom: PreferredSize(
              preferredSize: _employeeDropDownData.isEmpty?Size.fromHeight(50):Size.fromHeight(110),
              child: Column(
                children: [
                  _employeeDropDownData.isEmpty?Container()
                  :DropdownButtonHideUnderline(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 0),
                      child: DropdownButtonFormField(
                          isExpanded: true,
                          iconEnabledColor: ColorConstants.appBarColor,
                          items: _employeeDropDownData
                              .map((e) => DropdownMenuItem(
                            value: e.tsoId,
                            child: Text(
                              '(${e.tsoId})  ${e.tsoName}',
                              style: TextStyle(color: ColorConstants.appBarColor,fontWeight: FontWeight.bold),
                            ),
                          ))
                              .toList(),
                          value:empID,
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              empID=value;
                            });
                            _dashboardController.getMonthViewDetails(empID: empID);
                          }),
                    ),
                  ),
                  TabBar(
                    tabs: [
                      Tab(
                        text: "MONTH TO DATE",
                      ),
                      Tab(
                        text: "YEAR TO DATE",
                      ),
                    ],
                    indicatorColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigator(),
          floatingActionButton: BackFloatingButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: TabBarView(
            children: [MonthToDate(), YearToDate()],
          )),
      // ),
    );
  }
  @override
  void dispose() {
    _dashboardController.dispose();
    super.dispose();
  }
}
