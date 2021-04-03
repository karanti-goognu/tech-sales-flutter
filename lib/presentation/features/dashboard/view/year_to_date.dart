import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/data/model/DashboardYearlyViewModel.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/bar_graph_for_ytd.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/line_series_for_ytd.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class YearToDate extends StatefulWidget {
  final empID;
  YearToDate({this.empID});
  @override
  _YearToDateState createState() => _YearToDateState();
}


class _YearToDateState extends State<YearToDate> {
  final DataGridController _controller = DataGridController();
  DashboardController _dashboardController = Get.find();
  String actualOrAverage = 'Actual';
  bool _ytdIsVolume = false;
  String yearMonth;
  List<dynamic> _yearMonthList = [];
  static GlobalKey previewContainer = new GlobalKey();
  File imgFile;
  Random random = Random();
  List<DashboardYearlyModels> _thisYearData;
  List<ChartData> _barGraphGeneratedField = [];
  List<ChartData> _barGraphFieldConverted = [];
  List<ChartData> _lineChartGenerated = [];
  List<ChartData> _lineChartConverted = [];
  var _dataForDataGrid;

  getCountAndActualDataForBarGraph() {
    print("Count and Actual $_thisYearData");
    _barGraphGeneratedField = [];
    _barGraphFieldConverted = [];
    _dashboardController.barGraphLegend1 = 'Leads Generated';
    _dashboardController.barGraphLegend2 = 'Leads Converted';
    for (int i = 0; i < _dashboardController.monthList.length; i++) {
      _barGraphGeneratedField.add(ChartData(
          _thisYearData[i].leadGenerated.toDouble(),
          _dashboardController.monthList[i]));

      _barGraphFieldConverted.add(ChartData(
          _thisYearData[i].leadConverted.toDouble(),
          _dashboardController.monthList[i]));
    }
  }

  getVolumeAndActualDataForBarGraph() {
    print("Volume and Actual $_thisYearData");
    _barGraphGeneratedField = [];
    _barGraphFieldConverted = [];
    _dashboardController.barGraphLegend1 = 'Volume Generated';
    _dashboardController.barGraphLegend2 = 'Volume Converted';
    for (int i = 0; i < _dashboardController.monthList.length; i++) {
      _barGraphGeneratedField.add(ChartData(
          _thisYearData[i].generatedVolume.toDouble(),
          _dashboardController.monthList[i]));

      _barGraphFieldConverted.add(ChartData(
          _thisYearData[i].convertedVolume.toDouble(),
          _dashboardController.monthList[i]));
    }
  }

  getVolumeAndAverageDataForLineChart() {
    print("Volume and Average $_thisYearData");
    _lineChartGenerated = [];
    _lineChartConverted = [];
    _dashboardController.lineChartLegend1 = 'Avg Generated Volume ';
    _dashboardController.lineChartLegend2 = 'Avg Converted Volume';
    for (int i = 0; i < _dashboardController.monthList.length; i++) {
      _lineChartGenerated.add(ChartData(
          _thisYearData[i].avgGeneratedVolume.toDouble(),
          _dashboardController.monthList[i]));

      _lineChartConverted.add(ChartData(
          _thisYearData[i].avgConvertedVolume.toDouble(),
          _dashboardController.monthList[i]));
    }
  }

  getCountAndAverageDataForLineChart() {
    print("Count and Average $_thisYearData");
    _lineChartGenerated = [];
    _lineChartConverted = [];
    _dashboardController.lineChartLegend1 = 'Avg Lead Generated ';
    _dashboardController.lineChartLegend2 = 'Avg Lead Converted';
    for (int i = 0; i < _dashboardController.monthList.length; i++) {
      _lineChartGenerated.add(ChartData(
          _thisYearData[i].avgLeadGenerated.toDouble(),
          _dashboardController.monthList[i]));

      _lineChartConverted.add(ChartData(
          _thisYearData[i].avgLeadConverted.toDouble(),
          _dashboardController.monthList[i]));
    }
  }

getYearlyData()async{
  await _dashboardController.getYearlyViewDetails(widget.empID).then((value) {
    print("::::::$value ::::::");
    print("IN VIEW");
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
      yearMonth = _yearMonthList[1];
    });
    _thisYearData = _dashboardController
        .dashboardYearlyViewModel.dashboardYearlyModels
        .where((DashboardYearlyModels i) => i.showYear == yearMonth)
        .toList();
    print(
        "This year data length${_thisYearData.length} yearMonth $yearMonth");
    getCountAndActualDataForBarGraph();
    _dataForDataGrid = _dashboardController.dashboardYearlyViewModel.mtdCount;
    print(_dataForDataGrid);
  });
}

  @override
  void initState() {
    print("Initstate Called");
    getYearlyData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print("Build Called");
    return SingleChildScrollView(
      child: RepaintBoundary(
        key: previewContainer,
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
                              getVolumeAndActualDataForBarGraph();
                            else
                              getCountAndActualDataForBarGraph();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: yearMonth == null
                          ? Container(child: Text("Unable to fetch data"),padding: EdgeInsets.all(12),)
                          : DropdownButtonHideUnderline(
                              child: Obx(
                              () => _dashboardController.gotYearlyData==true?
                              DropdownButton(
                                  value: yearMonth,
                                  iconEnabledColor: HexColor('FF8500'),
                                  items: _yearMonthList
                                      .map<DropdownMenuItem>(
                                          (e) => DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      ))
                                      .toList(),
                                  onTap: () {
                                    print("On Tap called");
                                  },
                                  onChanged: (_) {
                                    print("On changed called");
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
                    scale: 0.7,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: actualOrAverage,
                            iconEnabledColor: HexColor('FF8500'),
                            items: ['Actual', 'Average']
                                .map((e) => DropdownMenuItem(
                                      child: Text(e,
                                        style: TextStyle(
                                            fontSize: SizeConfig.safeBlockHorizontal*3.3,
                                            color: ColorConstants.blackColor,
                                            fontFamily: "Muli"),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (_) {
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
              actualOrAverage == "Actual"
                  ? Theme(
                data: ThemeData(highlightColor: Colors.amberAccent,),
                    child: Scrollbar(
                      thickness: 8,
                      radius: Radius.circular(12),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: SizeConfig.screenWidth * 1.3,
                            height: SizeConfig.screenHeight /2.5,
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
//              DataGridForYTD(controller: _controller),

              _dashboardController.dashboardYearlyViewModel==null?Container():
              _dashboardController.dashboardYearlyViewModel.mtdVolume==null?Center(child: CircularProgressIndicator(),):
              _ytdIsVolume? _returnDataGridForVolume(_dashboardController.dashboardYearlyViewModel.mtdVolume):_returnDataGridForCount(_dashboardController.dashboardYearlyViewModel.mtdCount),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();

    if (boundary.debugNeedsPaint) {
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes() async {
    Get.dialog(Center(child: CircularProgressIndicator()));
    var pngBytes = await _capturePng();
    final directory = (await getExternalStorageDirectory()).path;
    imgFile = new File('$directory/screenshot$yearMonth.png');
    imgFile.writeAsBytes(pngBytes);
    print('Screenshot Path:' + imgFile.path);
    _dashboardController.getDetailsForSharingReport(imgFile);
    Get.back();
  }

  Widget _returnDataGridForCount(MtdCount data) {
    return Column(
      children: [
        Container(
          height: SizeConfig.screenHeight / 20,
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
          height: SizeConfig.screenHeight / 20,
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

class ChartData {
  ChartData(this.count, this.month);
  final double count;
  final String month;
}



