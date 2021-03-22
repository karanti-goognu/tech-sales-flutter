import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/bar_graph_for_ytd.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/datagrid_for_ytd.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/line_series_for_ytd.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class YearToDate extends StatefulWidget {
  @override
  _YearToDateState createState() => _YearToDateState();
}

final List<Employee> _employees = <Employee>[];


class _YearToDateState extends State<YearToDate> {
  final List<ChartData> chartData = [
    ChartData(2000, 'Sept'),
    ChartData(2001, 'Oct'),
    ChartData(2002, 'Nov'),
    ChartData(2003, 'Dec'),
    ChartData(2004, 'Jan'),
    ChartData(2005, 'Feb'),
  ];
  final DataGridController _controller = DataGridController();
  DashboardController _dashboardController = Get.find();
  String actualOrAverage='Actual';

  static GlobalKey previewContainer = new GlobalKey();
  File imgFile;
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
    var pngBytes = await _capturePng();
    int num = random.nextInt(100);
    final directory = (await getExternalStorageDirectory()).path;
    imgFile = new File('$directory/screenshot$num.png');
    imgFile.writeAsBytes(pngBytes);
    print('Screenshot Path:' + imgFile.path);
    _dashboardController.getDetailsForSharingReport(imgFile);

  }


  @override
  void initState() {
    super.initState();
    populateData();
    print(_employees[0].id);
    // print(_employeeDataSource);
  }

  void populateData() {
    _employees.add(Employee(10001, 'James', 'Project Lead', 20000,10));
    _employees.add(Employee(10002, 'Kathryn', 'Manager', 30000,29));
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'Leads (Count)',
                    style: TextStyle(fontSize: 16),
                  ),
                  Transform.scale(
                      scale: 0.6,
                      child: CupertinoSwitch(value: false, onChanged: (_) {})),
                  Text(
                    'Volume (MT)',
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(child: Container(),),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                          color: HexColor('FF8500'),
                          boxShadow: [BoxShadow(
                              color: Colors.black12,
                              offset: Offset(4, 4),
                              spreadRadius: 2,
                              blurRadius: 4
                          )]
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          Text('Share'),
                        ],
                      ),
                    ),
                    onTap: () => _printPngBytes(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 0.7,
//                    transform: Matrix4.identity()..scale(0.7),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            iconEnabledColor: HexColor('FF8500'),
                            items: ['2020/21', '2020/21']
                                .map((e) => DropdownMenuItem(
                                      child: Text(
                                        e,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (_) {}),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
//                    transform: Matrix4.identity()..scale(0.7),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
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
                                      child: Text(e),
                              value: e,
                                    ))
                                .toList(),
                            onChanged: (_) {
                            setState(() {
                              actualOrAverage=_;
                            });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              actualOrAverage=="Actual"? BarGraphForYTD(chartData: chartData) :LineSeriesForYTD(chartData: chartData),
              // Expanded(child: BarGraphForYTD(chartData: chartData)),
              DataGridForYTD(controller: _controller)
            ],
          ),
        ),
      ),
    );
  }
}





class ChartData {
  ChartData(this.count, this.month);
  final int count;
  final String month;
}

// final List<Employee> _employees = <Employee>[];


class EmployeeDataSource extends DataGridSource<Employee> {
  @override
  List<Employee> get dataSource => _employees;

  @override
  getValue(Employee employee, String columnName) {
    switch (columnName) {
      case 'id':
        return employee.id;
        break;
      case 'name':
        return employee.name;
        break;
      case 'salary':
        return employee.salary;
        break;
      case 'designation':
        return employee.designation;
        break;
      default:
        return ' ';
        break;
    }
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary, this.perc);
  final int id;
  final String name;
  final String designation;
  final int salary;
  final int perc;
}
