import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardYearlyViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/bar_graph_for_ytd.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/line_series_for_ytd.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';


class YearToDate extends StatefulWidget {
  final empID;
  YearToDate({this.empID});
  @override
  _YearToDateState createState() => _YearToDateState();
}


class _YearToDateState extends State<YearToDate> {
  DashboardController _dashboardController = Get.find();
  String? actualOrAverage = 'Actual';
  bool _ytdIsVolume = false;
  String? yearMonth;
  List<dynamic>? _yearMonthList = [];
  late File imgFile;
  Random random = Random();
  List<DashboardYearlyModels>? _thisYearData;
  List<ChartDataForYTD> _barGraphGeneratedField = [];
  List<ChartDataForYTD> _barGraphFieldConverted = [];
  List<ChartDataForYTD> _lineChartGenerated = [];
  List<ChartDataForYTD> _lineChartConverted = [];
  ScreenshotController screenshotController = ScreenshotController();


  getCountAndActualDataForBarGraph() {
    _barGraphGeneratedField = [];
    _barGraphFieldConverted = [];
    _dashboardController.barGraphLegend1 = 'Leads Generated';
    _dashboardController.barGraphLegend2 = 'Leads Converted';
    for (int i = 0; i < _dashboardController.monthList.length; i++) {
      _barGraphGeneratedField.add(ChartDataForYTD(
          _thisYearData![i].leadGenerated!.toDouble(),
          _dashboardController.monthList[i]));

      _barGraphFieldConverted.add(ChartDataForYTD(
          _thisYearData![i].leadConverted!.toDouble(),
          _dashboardController.monthList[i]));
    }
  }

  getVolumeAndActualDataForBarGraph() {
    _barGraphGeneratedField = [];
    _barGraphFieldConverted = [];
    _dashboardController.barGraphLegend1 = 'Volume Generated';
    _dashboardController.barGraphLegend2 = 'Volume Converted';
    for (int i = 0; i < _dashboardController.monthList.length; i++) {
      _barGraphGeneratedField.add(ChartDataForYTD(
          _thisYearData![i].generatedVolume!.toDouble(),
          _dashboardController.monthList[i]));

      _barGraphFieldConverted.add(ChartDataForYTD(
          _thisYearData![i].convertedVolume!.toDouble(),
          _dashboardController.monthList[i]));
    }
  }

  getVolumeAndAverageDataForLineChart() {
    _lineChartGenerated = [];
    _lineChartConverted = [];
    _dashboardController.lineChartLegend1 = 'Avg Generated Volume ';
    _dashboardController.lineChartLegend2 = 'Avg Converted Volume';
    for (int i = 0; i < _dashboardController.monthList.length; i++) {
      _lineChartGenerated.add(ChartDataForYTD(
          _thisYearData![i].avgGeneratedVolume!.toDouble(),
          _dashboardController.monthList[i]));

      _lineChartConverted.add(ChartDataForYTD(
          _thisYearData![i].avgConvertedVolume!.toDouble(),
          _dashboardController.monthList[i]));
    }
  }

  getCountAndAverageDataForLineChart() {
    _lineChartGenerated = [];
    _lineChartConverted = [];
    _dashboardController.lineChartLegend1 = 'Avg Lead Generated ';
    _dashboardController.lineChartLegend2 = 'Avg Lead Converted';
    for (int i = 0; i < _dashboardController.monthList.length; i++) {
      _lineChartGenerated.add(ChartDataForYTD(
          _thisYearData![i].avgLeadGenerated!.toDouble(),
          _dashboardController.monthList[i]));

      _lineChartConverted.add(ChartDataForYTD(
          _thisYearData![i].avgLeadConverted!.toDouble(),
          _dashboardController.monthList[i]));
    }
  }

getYearlyData()async{
  await _dashboardController.getYearlyViewDetails(widget.empID).then((value) {
    _yearMonthList =
        _dashboardController.dashboardYearlyViewModel.dashboardYearlyModels==null?[]:
        _dashboardController.dashboardYearlyViewModel.dashboardYearlyModels
            .map(
              (e) => e.showYear,
        )
            .toList()
            .toSet()
            .toList();

    if(mounted)
    setState(() {
      yearMonth = _yearMonthList![1];
    });
    _thisYearData = _dashboardController
        .dashboardYearlyViewModel.dashboardYearlyModels
        .where((DashboardYearlyModels i) => i.showYear == yearMonth)
        .toList();
    getCountAndActualDataForBarGraph();
  });
}

  @override
  void initState() {
    getYearlyData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          color: ThemeData.light().scaffoldBackgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Leads (Count)',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Transform.scale(
                      scale: 0.6,
                      child: CupertinoSwitch(
                        value: _ytdIsVolume,
                        onChanged: (_) {
                          if(mounted)
                          setState(() {
                            _ytdIsVolume = _;
                          });
                          if (actualOrAverage == "Actual") {
                            if (_ytdIsVolume == true)
                              {
                                getVolumeAndActualDataForBarGraph();
//                                print("Actual and Volume");
                              }
                            else
                              {
                                getCountAndActualDataForBarGraph();
//                                print("Actual and Count");
                              }

                          } else {
                            if (_ytdIsVolume == true)
                              getVolumeAndAverageDataForLineChart();
                            else
                              getCountAndAverageDataForLineChart();
                          }
                        },
                        activeColor: Colors.amber,
                      )),
                  Expanded(
                    child: Text(
                      'Volume (MT)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: ThemeData.light().scaffoldBackgroundColor,
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
                            Text('Share',
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal*2.9,
                                  color: ColorConstants.blackColor,
                                  fontFamily: "Muli"),
                            ),
                          ],
                        ),
                      ),
                      onTap: () => _printPngBytes(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
//                    scale: 0.7,
                  scale: 1,
                    child: Container(
                      height: 28,
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: yearMonth == null
                          ? CupertinoActivityIndicator()
                          : DropdownButtonHideUnderline(
                              child: Obx(
                              () => _dashboardController.gotYearlyData==true?
                              DropdownButton(
                                  value: yearMonth,
                                  iconEnabledColor: HexColor('FF8500'),
                                  items: _yearMonthList!
                                      .map<DropdownMenuItem>(
                                          (e) => DropdownMenuItem(
                                        child: Text(e,
                                          style: TextStyle(
                                              fontSize: SizeConfig.safeBlockHorizontal*3.0,
                                              color: ColorConstants.blackColor,
                                              fontFamily: "Muli"),                                        ),
                                        value: e,
                                      ))
                                      .toList(),
                                  onTap: () {
                                  //  print("On Tap called");
                                  },
                                  onChanged: (dynamic _) {
                                  //  print("On changed called");
                                    if(mounted)
                                    setState(() {
                                      yearMonth = _;
                                      _thisYearData = _dashboardController
                                          .dashboardYearlyViewModel
                                          .dashboardYearlyModels
                                          .where((DashboardYearlyModels i) =>
                                      i.showYear == yearMonth)
                                          .toList();
//                                      print("This year data length${_thisYearData.length} yearMonth $yearMonth");
                                    });
//                                    print(yearMonth);
                                    if (_ytdIsVolume == true) {
                                      getVolumeAndActualDataForBarGraph();
                                      getVolumeAndAverageDataForLineChart();
                                    } else {
                                      _thisYearData = _dashboardController
                                          .dashboardYearlyViewModel
                                          .dashboardYearlyModels
                                          .where((DashboardYearlyModels i) =>
                                      i.showYear == yearMonth)
                                          .toList();
                                      getCountAndActualDataForBarGraph();
                                      getCountAndAverageDataForLineChart();
                                    }
                                  }):Container(),
                            )),
                    ),
                  ),
                  Transform.scale(
                    scale: 1,
                    child: Container(
                      height: 28,
//                      width: 100,
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: actualOrAverage,
                            iconEnabledColor: HexColor('FF8500'),
                            items: ['Actual', 'Average']
                                .map((e) => DropdownMenuItem(
                                      child: Text(e,
                                        style: TextStyle(
                                            fontSize: SizeConfig.safeBlockHorizontal*3,
                                            color: ColorConstants.blackColor,
                                            fontFamily: "Muli"),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (dynamic _) {
                              if(mounted)
                              setState(() {
                                actualOrAverage = _;
                              });
                              if (actualOrAverage == 'Actual') {
//                                print("Actual");
                                if (_ytdIsVolume == true)
                                  getVolumeAndActualDataForBarGraph();
                                else
                                  getCountAndActualDataForBarGraph();
                              } else {
//                                print("Average");
                                if (_ytdIsVolume == true)
                                  getVolumeAndAverageDataForLineChart();
                                else
                                  getCountAndAverageDataForLineChart();
                              }
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              actualOrAverage == "Actual"?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 14,
                    height: 14,
                    color: HexColor('00ADEE'),
                  ),
                  Text(_dashboardController.barGraphLegend1.toString(), style: TextStyle(fontSize: 12),),
                  Expanded(child: Container(),),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 14,
                    height: 14,
                    color: HexColor('39B54A'),
                  ),
                  Text(_dashboardController.barGraphLegend2.toString(), style: TextStyle(fontSize: 12),),

                ],
              ):Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 14,
                    height: 14,
                    color: HexColor('F15A22'),
                  ),
                  Text(_dashboardController.lineChartLegend1.toString(), style: TextStyle(fontSize: 12),),
                  Expanded(child: Container(),),
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 14,
                    height: 14,
                    color: HexColor('9E3A0D'),
                  ),
                  Text(_dashboardController.lineChartLegend2.toString(), style: TextStyle(fontSize: 12),),

                ],
              ),
              SizedBox(
                height: 15,
              ),
              actualOrAverage == "Actual"
                  ? Theme(
                data: ThemeData(highlightColor: Colors.amberAccent,),
                    child: Scrollbar(
                      thickness: 8,
                      radius: Radius.circular(12),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: SizeConfig.screenWidth! * 1.7,
                            height: SizeConfig.screenHeight! /2.8,
                            child: BarGraphForYTD(
                              chartData: _barGraphGeneratedField,
                              chartData2: _barGraphFieldConverted,
                            ),
                          ),
                        ),
                    ),
                  )
                  : LineSeriesForYTD(
                      chartData: _lineChartGenerated,
                      chartData2: _lineChartConverted,
                    ),
                SizedBox(
                  height: 20,
                ),
              _dashboardController.dashboardYearlyViewModel==null?Container():
              _dashboardController.dashboardYearlyViewModel.mtdVolume==null?Center(child: CircularProgressIndicator(),):
              _ytdIsVolume? _returnDataGridForVolume(_dashboardController.dashboardYearlyViewModel.mtdVolume):_returnDataGridForCount(_dashboardController.dashboardYearlyViewModel.mtdCount),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _printPngBytes() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    String empIdForFileName= _dashboardController.empId;
    Uint8List? pngBytes = await  (screenshotController.capture(pixelRatio: 5) );
    final directory = (await getExternalStorageDirectory())!.path;
    imgFile = new File('$directory/$empIdForFileName-YTD-${DateTime.now().millisecondsSinceEpoch}.png');
    imgFile.writeAsBytes(pngBytes!);
    _dashboardController.getDetailsForSharingReport(imgFile);
    Get.back();
  }

  Widget _returnDataGridForCount(MtdCount data) {
    return Column(
      children: [
        Container(
          height: SizeConfig.screenHeight! / 20,
          color: HexColor('707070'),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "MTD",
                  style: TextStyle(color: HexColor('FFFFFF')),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text("Tgt",
                    style: TextStyle(color: HexColor('FFFFFF')),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text("Pro. Rata",
                    style: TextStyle(color: HexColor('FFFFFF')),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text("Act",
                    style: TextStyle(color: HexColor('FFFFFF')),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text("Act%",
                    style: TextStyle(color: HexColor('FFFFFF')),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.12),
//              height: SizeConfig.screenHeight/11,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Conv",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text("${data.convTargetCount}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.convProrataCount}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.convActCount}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.convAchvCountPerc}%", textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Slab",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text("${data.slabTargetCount}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.slabProrataCount}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.slabActCount}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.slabAchvCountPerc}%", textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _returnDataGridForVolume(MtdVolume data) {
    return Column(
      children: [
        Container(
          height: SizeConfig.screenHeight! / 20,
          color: HexColor('707070'),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "MTD",
                  style: TextStyle(color: HexColor('FFFFFF')),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text("Tgt",
                    style: TextStyle(color: HexColor('FFFFFF')),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text("Pro. Rata",
                    style: TextStyle(color: HexColor('FFFFFF')),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text("Act",
                    style: TextStyle(color: HexColor('FFFFFF')),
                    textAlign: TextAlign.center),
              ),
              Expanded(
                child: Text("Act%",
                    style: TextStyle(color: HexColor('FFFFFF')),
                    textAlign: TextAlign.center),
              )
            ],
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.12),
//              height: SizeConfig.screenHeight/11,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Conv",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text("${data.convTargetVolume}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.convProrataVolume}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.convActVolume}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.convAchvVolumePerc}%", textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Slab",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Text("${data.slabTargetVolume}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.slabProrataVolume}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.slabActVolume}", textAlign: TextAlign.center),
                    ),
                    Expanded(
                      child: Text("${data.slabAchvVolumePerc}%", textAlign: TextAlign.center),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ChartDataForYTD {
  ChartDataForYTD(this.count, this.month);
  final double count;
  final String? month;
}



