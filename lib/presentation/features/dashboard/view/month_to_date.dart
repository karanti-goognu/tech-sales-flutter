import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/dsp_for_mtd.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/top_row_for_mtd.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:screenshot/screenshot.dart';

class MonthToDate extends StatefulWidget {
  final empID, yearMonth;
  MonthToDate({
    Key? key,
    this.empID,
    this.yearMonth,
  }) : super(key: key);
  @override
  MonthToDateState createState() => MonthToDateState();
}

class MonthToDateState extends State<MonthToDate> {
  bool _currentMothDetailsVolume = false;
  bool _currentMothDspSlabVolume = false;
  DashboardController _dashboardController = Get.find();
  ScreenshotController screenshotController = ScreenshotController();
  late File imgFile;
  String? empID, _currentMonth, _previousMonth;
  String? yearMonthForFileName;
  Random random = Random();


  void _printPngBytes() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    String empIdForFileName= _dashboardController.empId;
    Uint8List? pngBytes = await  (screenshotController.capture(pixelRatio: 5) );
    final directory = (await getApplicationDocumentsDirectory()).path;
    imgFile = new File('$directory/$empIdForFileName-MTD-${DateTime.now().millisecondsSinceEpoch}.png');
    imgFile.writeAsBytes(pngBytes!);
    _dashboardController.getDetailsForSharingReport(imgFile);
    Get.back();
  }

  void passEmpId(String empIdValue) {
    this.empID = empIdValue;
  }

  @override
  void initState() {
    empID = widget.empID;
    yearMonthForFileName = widget.yearMonth;
    final DateFormat formatter = DateFormat("MMMM");
    _currentMonth = formatter.format(DateTime.now());
    _previousMonth = formatter
        .format(DateTime(DateTime.now().year, DateTime.now().month - 1));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: ListView(
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: ThemeData.light().scaffoldBackgroundColor,
                    height: 690,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(() => _dashboardController.isPrev == false
                                      ? Text(
                                          '$_currentMonth Details',
                                          style: TextStyle(fontSize: 18),
                                        )
                                      : Text(
                                          '$_previousMonth Details',
                                          style: TextStyle(fontSize: 18),
                                        )),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: 8, right: 8, top: 4, bottom: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: ThemeData.light()
                                              .scaffoldBackgroundColor,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(4, 4),
                                                spreadRadius: 2,
                                                blurRadius: 4),
                                            BoxShadow(
                                                color: Colors.white,
                                                offset: Offset(-4, -4),
                                                spreadRadius: 2,
                                                blurRadius: 4),
                                          ]),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.share,
                                            color: ColorConstants.appBarColor,
                                          ),
                                          Text('Share'),
                                        ],
                                      ),
                                    ),
                                    onTap: () => _printPngBytes(),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'All target achievement are shown on Pro rata basis',
                                    style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal*2.5),
                                  ),
                                  Expanded(child: Container())
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Leads (Count)',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Transform.scale(
                                      scale: 0.6,
                                      child: CupertinoSwitch(
                                        value: _currentMothDetailsVolume,
                                        onChanged: (_) {
                                          setState(() =>
                                              _currentMothDetailsVolume = _);
                                        },
                                        activeColor: Colors.amber,
                                      )),
                                  Text(
                                    'Volume (MT)',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TopRowForMTD(
                                  currentMothDetailsVolume:
                                      _currentMothDetailsVolume,
                                  dashboardController: _dashboardController),
                            ],
                          ),
                        ),
                        Divider(),
                        Expanded(
                          flex: 7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'DSP Slab Conversion',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Expanded(child: Container())
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Total Slab Opportunities',
                                    style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal!*2.5),
                                  ),
                                  Expanded(child: Container())
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Slab (Count)',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Transform.scale(
                                      scale: 0.6,
                                      child: CupertinoSwitch(
                                        value: _currentMothDspSlabVolume,
                                        onChanged: (_) {
                                          setState(() =>
                                              _currentMothDspSlabVolume = _);
                                        },
                                        activeColor: Colors.amber,
                                      )),
                                  Text(
                                    'Volume (MT)',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              DspColumnChild(
                                  currentMothDspSlabVolume:
                                      _currentMothDspSlabVolume,
                                  dashboardController: _dashboardController),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Obx(
                          () => _dashboardController.isPrev == false
                              ? MaterialButton(
                                  onPressed: () {

                                    int year = DateTime.now().year;
                                    int month = DateTime.now().month - 1;
                                    String yearMonth;
                                    if (month >= 3) {
                                      yearMonth = year.toString() + '-' + (month.toString().length == 1
                                          ? '0' + month.toString()
                                          : month.toString());
                                    } else {
                                      yearMonth = (year - 1).toString() +
                                          '-' +
                                          (month.toString().length == 1
                                              ? '0' + month.toString()
                                              : month.toString());
                                    }

                                    if(widget.empID=="_empty"){

                                      _dashboardController.getMonthViewDetails(
                                          empID: empID,
                                          yearMonth: yearMonth);
                                    }
                                    else{
                                      _dashboardController.getMonthViewDetails(
                                          empID: widget.empID,
                                          yearMonth: yearMonth);
                                    }
                                    _dashboardController.isPrev = true;
                                    _dashboardController.yearMonth= yearMonth;

                                  },
                                  child: Text(
                                    'Show $_previousMonth (Prev.) Data',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: ColorConstants.appBarColor,
                                )
                              : MaterialButton(
                                  onPressed: () {
                                    int year = DateTime.now().year;
                                    int month = DateTime.now().month;
                                    String yearMonth;
                                    if (month >= 3) {
                                      yearMonth = year.toString() + '-' + (month.toString().length == 1
                                          ? '0' + month.toString()
                                          : month.toString());
                                    } else {
                                      yearMonth = (year - 1).toString() +
                                          '-' +
                                          (month.toString().length == 1
                                              ? '0' + month.toString()
                                              : month.toString());
                                    }

                                    if(widget.empID=="_empty"){
                                      _dashboardController.getMonthViewDetails(
                                          empID: empID,
                                          yearMonth: yearMonth);
                                    }
                                    else{
                                      _dashboardController.getMonthViewDetails(
                                          empID: widget.empID,
                                          yearMonth: yearMonth);
                                    }
                                    _dashboardController.yearMonth= yearMonth;
                                    _dashboardController.isPrev = false;
                                  },
                                  child: Text(
                                    'Show $_currentMonth (Current) Data',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: ColorConstants.appBarColor,
                                ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class ChartDataForMTD {
  ChartDataForMTD(this.x, this.y, [this.color]);
  final String x;
  final double? y;
  final Color? color;
}
