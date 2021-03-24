import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/volume_converted_table_screen.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/volume_generated_site_view.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MonthToDate extends StatefulWidget {
  final empID, yearMonth;
  MonthToDate({Key key,this.empID, this.yearMonth, }): super(key: key);
  @override
  MonthToDateState createState() => MonthToDateState();
}

class MonthToDateState extends State<MonthToDate> {
  bool _currentMothDetailsVolume = false;
  bool _currentMothDspSlabVolume = false;
  DashboardController _dashboardController = Get.find();
  String empId="";

  static GlobalKey previewContainer = new GlobalKey();
  File imgFile;
  String empID, _currentMonth, _previousMonth;
  String yearMonthForFileName;
  Random random = Random();
  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes() async {
    print(empID);
    var pngBytes = await _capturePng();
    final directory = (await getExternalStorageDirectory()).path;
    imgFile = new File('$directory/$empID-$yearMonthForFileName.png');
    imgFile.writeAsBytes(pngBytes);
    print('Screenshot Path:' + imgFile.path);
    _dashboardController.getDetailsForSharingReport(imgFile);
  }

  @override
  void initState() {
    empID = widget.empID;
    print("MTD: $empID");
    yearMonthForFileName = widget.yearMonth;
    final DateFormat formatter = DateFormat("MMMM");
    _currentMonth = formatter.format(DateTime.now());
    _previousMonth = formatter
        .format(DateTime(DateTime.now().year, DateTime.now().month - 1));
    print(_previousMonth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: ListView(
          children: [
            RepaintBoundary(
              key: previewContainer,
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    color: ThemeData.light().scaffoldBackgroundColor,
                    height: 640,
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
                                  Obx(() => _dashboardController.isPrev==false
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
//                                        color: HexColor('FF8500'),
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
                                    style: TextStyle(fontSize: 12),
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
                              Expanded(
                                  child: _currentMothDetailsVolume == false
                                      ? SfCircularChart(
                                          margin: EdgeInsets.zero,
                                          // backgroundColor: Colors.yellow,
                                          annotations: <CircularChartAnnotation>[
                                            CircularChartAnnotation(
                                              // height: '45.0',
                                              widget: Container(
                                                // padding: EdgeInsets.all(20),
                                                alignment: Alignment.center,
                                                height: 77,
                                                width: 77,
                                                // color: Colors.pink,
                                                child: Text.rich(
                                                  TextSpan(
                                                      text:
                                                          "${(int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())).isNaN ? 0 : int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())}%\n",
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: HexColor(
                                                              '#002A64'),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "Site conversion efficiency",
                                                          style: TextStyle(
                                                              fontSize: 10),
                                                        )
                                                      ]),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              horizontalAlignment:
                                                  ChartAlignment.center,
                                              verticalAlignment:
                                                  ChartAlignment.center,
                                            ),
                                          ],
                                          legend: Legend(
                                            isVisible: true,
                                            position: LegendPosition.right,
                                            backgroundColor: Colors.white,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2)
                                                .toString(),
                                            title: LegendTitle(),
                                          ),
                                          series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                                dataSource: [
                                                  ChartData(
                                                      'Converted-${_dashboardController.convertedCount}',
                                                      75,
                                                      Color(0xff39B54A)),
                                                  ChartData(
                                                      'Generated-${_dashboardController.generatedCount}',
                                                      25,
                                                      Color(0xff00ADEE)),
                                                  ChartData(
                                                      'Conv. Target-${_dashboardController.convTargetCount}',
                                                      0,
                                                      Color(0xff007CBF)),
                                                  ChartData(
                                                      'Remaining Tgt-${_dashboardController.remainingTargetCount}',
                                                      0,
                                                      Color(0xffFFCD00)),
                                                ],
                                                innerRadius: '65.0',
                                                pointColorMapper:
                                                    (ChartData data, _) =>
                                                        data.color,
                                                strokeColor: Colors.red,
                                                xValueMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, _) =>
                                                        data.y)
                                          ])
                                      : Column(
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: SfRadialGauge(
                                                  enableLoadingAnimation: true,
                                                  axes: <RadialAxis>[
                                                    RadialAxis(
                                                        radiusFactor: 1.3,
                                                        startAngle: 180,
                                                        endAngle: 0,
                                                        canScaleToFit: true,
                                                        minimum: 0,
                                                        maximum: 750,
                                                        ranges: <GaugeRange>[
                                                          GaugeRange(
                                                              startValue: 0,
                                                              endValue: 500,
                                                              color:
                                                                  Colors.green,
                                                              startWidth: 10,
                                                              endWidth: 10),
                                                          GaugeRange(
                                                              startValue: 500,
                                                              endValue: 750,
                                                              color:
                                                                  Colors.orange,
                                                              startWidth: 10,
                                                              endWidth: 10),
                                                        ],
                                                        pointers: <
                                                            GaugePointer>[
                                                          NeedlePointer(
                                                            value: (int.parse(_dashboardController
                                                                            .convTargetCount
                                                                            .toString()) /
                                                                        int.parse(_dashboardController
                                                                            .generatedCount
                                                                            .toString()))
                                                                    .isNaN
                                                                ? 0
                                                                : int.parse(_dashboardController
                                                                        .convTargetCount
                                                                        .toString()) /
                                                                    int.parse(_dashboardController
                                                                        .generatedCount
                                                                        .toString()),
                                                            needleColor:
                                                                Colors.black12,
                                                          )
                                                        ],
                                                        annotations: <
                                                            GaugeAnnotation>[
                                                          GaugeAnnotation(
                                                              widget: Container(
                                                                  child: Text(
                                                                      "${(int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())).isNaN ? 0 : int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())}%",
                                                                      style: TextStyle(
//                                                                    fontSize: 25,
                                                                          fontWeight: FontWeight.bold))),
                                                              angle: 190,
                                                              positionFactor: 0.3)
                                                        ])
                                                  ]),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: GridView.count(
                                                  crossAxisCount: 2,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  childAspectRatio: 6,
                                                  children: [
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              "Generated-${_dashboardController.generatedVolume} MT"),
                                                          IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 14,
                                                              ),
                                                              onPressed: () => Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              VolumeGeneratedSiteList())))
                                                        ],
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      color: Colors.blue
                                                          .withOpacity(0.3),
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                              "Converted-${_dashboardController.convertedVolume} MT"),
                                                          IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 14,
                                                              ),
                                                              onPressed: () => Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              VolumeConvertedTable())))
                                                        ],
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      color: Colors.green
                                                          .withOpacity(0.3),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          "Remaining Tgt-${_dashboardController.remainingTargetVolume} MT"),
                                                      color: Colors.yellow
                                                          .withOpacity(0.3),
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          "Conv. Target-${_dashboardController.convTargetVolume} MT"),
                                                      color: Colors.indigo
                                                          .withOpacity(0.3),
                                                      alignment:
                                                          Alignment.center,
                                                    )
                                                  ],
                                                )),
                                          ],
                                        )),
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
                                    'DSP Slab Coversion',
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
                                    style: TextStyle(fontSize: 11),
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
                              Expanded(
                                  child: _currentMothDspSlabVolume == false
                                      ? SfCircularChart(
                                          margin: EdgeInsets.zero,
                                          legend: Legend(
                                            isVisible: true,
                                            position: LegendPosition.right,
                                            backgroundColor: Colors.white,
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2)
                                                .toString(),
                                            title: LegendTitle(),
                                          ),
                                          annotations: <
                                              CircularChartAnnotation>[
                                              CircularChartAnnotation(
                                                // height: '45.0',
                                                widget: Container(
                                                  alignment: Alignment.center,
                                                  height: 77,
                                                  width: 77,
                                                  child: Text.rich(
                                                    TextSpan(
                                                        text:
                                                            "${(int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())).isNaN ? 0 : int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())}%\n",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: HexColor(
                                                                '#002A64'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "Site conversion efficiency on Count",
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                          )
                                                        ]),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                horizontalAlignment:
                                                    ChartAlignment.center,
                                                verticalAlignment:
                                                    ChartAlignment.center,
                                              ),
                                            ],
                                          series: <CircularSeries>[
                                              DoughnutSeries<ChartData, String>(
                                                  dataSource: [
                                                    ChartData(
                                                        'Total Opp'
                                                        'ty-${_dashboardController.dspTotalOpperCount}',
                                                        100,
                                                        Color(0xff39B54A)),
                                                    ChartData(
                                                        'DSP Target-${_dashboardController.dspTargetCount}',
                                                        0,
                                                        Color(0xff00ADEE)),
                                                    ChartData(
                                                        'Slab Converted-${_dashboardController.dspSlabConvertedCount}',
                                                        0,
                                                        Color(0xff007CBF)),
                                                    ChartData(
                                                        'Remaining Tgt-${_dashboardController.dspRemaingTargetCount}',
                                                        0,
                                                        Color(0xffFFCD00)),
                                                  ],
                                                  innerRadius: '65.0',
                                                  pointColorMapper:
                                                      (ChartData data, _) =>
                                                          data.color,
                                                  xValueMapper:
                                                      (ChartData data, _) =>
                                                          data.x,
                                                  yValueMapper:
                                                      (ChartData data, _) =>
                                                          data.y)
                                            ])
                                      : Column(
                                          children: [
                                            Expanded(
                                              flex: 9,
                                              child: SfRadialGauge(
                                                  enableLoadingAnimation: true,
                                                  axes: <RadialAxis>[
                                                    RadialAxis(
                                                        radiusFactor: 1.3,
                                                        startAngle: 180,
                                                        endAngle: 0,
                                                        canScaleToFit: true,
                                                        minimum: 0,
                                                        maximum: 750,
                                                        ranges: <GaugeRange>[
                                                          GaugeRange(
                                                              startValue: 0,
                                                              endValue: 500,
                                                              color:
                                                                  Colors.green,
                                                              startWidth: 10,
                                                              endWidth: 10),
                                                          GaugeRange(
                                                              startValue: 500,
                                                              endValue: 750,
                                                              color:
                                                                  Colors.orange,
                                                              startWidth: 10,
                                                              endWidth: 10),
                                                        ],
                                                        pointers: <
                                                            GaugePointer>[
                                                          NeedlePointer(
                                                            value: (int.parse(_dashboardController
                                                                            .convTargetCount
                                                                            .toString()) /
                                                                        int.parse(_dashboardController
                                                                            .generatedCount
                                                                            .toString()))
                                                                    .isNaN
                                                                ? 0
                                                                : int.parse(_dashboardController
                                                                        .convTargetCount
                                                                        .toString()) /
                                                                    int.parse(_dashboardController
                                                                        .generatedCount
                                                                        .toString()),
                                                            needleColor:
                                                                Colors.black12,
                                                          )
                                                        ],
                                                        annotations: <
                                                            GaugeAnnotation>[
                                                          GaugeAnnotation(
                                                              widget: Container(
                                                                  child: Text(
                                                                      '${(int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())).isNaN ? 0 : int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())}%',
                                                                      style: TextStyle(
//                                                                    fontSize: 25,
                                                                          fontWeight: FontWeight.bold))),
                                                              angle: 190,
                                                              positionFactor: 0.3)
                                                        ])
                                                  ]),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: GridView.count(
                                                  crossAxisCount: 2,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  childAspectRatio: 6,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                          "Opportunity-${_dashboardController.remainingTargetVolume} MT"),
                                                      alignment:
                                                          Alignment.center,
                                                      color: Colors.blue,
                                                    ),
                                                    Container(
                                                      child: Text(
                                                          "Converted-${_dashboardController.convTargetVolume} MT"),
                                                      alignment:
                                                          Alignment.center,
                                                      color: Colors.green,
                                                    )
                                                  ],
                                                )),
                                          ],
                                        )),
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
                                    if (month > 3) {
                                      yearMonth = year.toString() +
                                          '-' +
                                          month.toString();
                                    } else {
                                      yearMonth = (year - 1).toString() +
                                          '-' +
                                          (month.toString().length == 1
                                              ? '0' + month.toString()
                                              : month.toString());
                                    }
                                    _dashboardController.getMonthViewDetails(
                                        empID: widget.empID,
                                        yearMonth: yearMonth);
                                    _dashboardController.isPrev = true;
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
                                    if (month > 3) {
                                      yearMonth = year.toString() +
                                          '-' +
                                          month.toString();
                                    } else {
                                      yearMonth = (year - 1).toString() +
                                          '-' +
                                          (month.toString().length == 1
                                              ? '0' + month.toString()
                                              : month.toString());
                                    }
                                    _dashboardController.getMonthViewDetails(
                                        empID: widget.empID,
                                        yearMonth: yearMonth);
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


  /*Pass empId*/
  void passEmpId(String empIdValue){
   print("passed empId ...   $empIdValue");
   this.empId=empIdValue;
 }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
