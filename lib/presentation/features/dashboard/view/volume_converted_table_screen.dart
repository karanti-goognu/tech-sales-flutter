import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';

class VolumeConvertedTable extends StatefulWidget {
  @override
  _VolumeConvertedTableState createState() => _VolumeConvertedTableState();
}

class _VolumeConvertedTableState extends State<VolumeConvertedTable> {
  DashboardController _dashboardController = Get.find();

  @override
  void initState() {
    _dashboardController.getDashboardMtdConvertedVolumeList();
//    print('${_dashboardController.mtdConvertedVolumeList.supplyQty}test');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: 120,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Volume Converted".toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: "Muli"),
                  ),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: BackFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MTD Vol. Converted',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('Total Count-0'),
          Expanded(
            child: Container(
              child: ListView.separated(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return index == 0
                        ? Container(
                            height: SizeConfig.screenHeight / 16,
                            color: HexColor('707070'),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:2,
                                  child: Text(
                                    "Site ID​",
                                    style: TextStyle(
                                        color: HexColor('FFFFFF'),
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal * 3),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text("Current Stage​",
                                      style: TextStyle(
                                          color: HexColor('FFFFFF'),
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3),
                                      textAlign: TextAlign.center),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text("Brand​",
                                      style: TextStyle(
                                          color: HexColor('FFFFFF'),
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3),
                                      textAlign: TextAlign.center),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text("Qty",
                                      style: TextStyle(
                                          color: HexColor('FFFFFF'),
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3),
                                      textAlign: TextAlign.center),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Text("Supply Date",
                                      style: TextStyle(
                                          color: HexColor('FFFFFF'),
                                          fontSize:
                                              SizeConfig.blockSizeHorizontal *
                                                  3),
                                      textAlign: TextAlign.center),
                                ),
                                Expanded(
                                  child: Container(),
                                )
                              ],
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex:2,
                                        child: Text(
                                          "500067​",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize:
                                          SizeConfig.blockSizeHorizontal * 3),
                                        ),
                                      ),
                                      Expanded(
                                        flex:2,
                                        child: Text(
                                          "Column & Lintel",
                                          textAlign: TextAlign.center,
                                            style: TextStyle(fontSize:
                                            SizeConfig.blockSizeHorizontal * 3)
                                        ),
                                      ),
                                      Expanded(
                                        flex:2,
                                        child: Text(
                                          "DSP",
                                          textAlign: TextAlign.center,
                                            style: TextStyle(fontSize:
                                            SizeConfig.blockSizeHorizontal * 3)
                                        ),
                                      ),
                                      Expanded(
                                        flex:2,
                                        child: Text(
                                          "50 bg​",
                                          textAlign: TextAlign.center,
                                            style: TextStyle(fontSize:
                                            SizeConfig.blockSizeHorizontal * 3)
                                        ),
                                      ),
                                      Expanded(
                                        flex:2,
                                        child: Text(
                                          "21-Feb-21",
                                          textAlign: TextAlign.center,
                                            style: TextStyle(fontSize:
                                            SizeConfig.blockSizeHorizontal * 3)
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor('F9A61A')),
                                              padding: EdgeInsets.all(4),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                                size: 14,
                                              )))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      index == 0 ? Container() : Divider(),
                 ),
            ),
          )
        ],
      ),
    );
  }
}

