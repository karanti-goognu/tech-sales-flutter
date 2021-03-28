import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final EmployeeDataSource _employeeDataSource = EmployeeDataSource();


class DataGridForYTD extends StatefulWidget {
  const DataGridForYTD({
    Key key,
    @required DataGridController controller,
  }) : _controller = controller, super(key: key);

  final DataGridController _controller;

  @override
  _DataGridForYTDState createState() => _DataGridForYTDState();
}

class _DataGridForYTDState extends State<DataGridForYTD> {
  DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        color: HexColor('#000001F')
      ),
    child: SfDataGrid(
    controller: widget._controller,
    source: _employeeDataSource,
    gridLinesVisibility: GridLinesVisibility.none,
    verticalScrollPhysics: NeverScrollableScrollPhysics(),
    columns: [
      GridNumericColumn(
//        mappingName: 'id',
        headerText: 'MTD',
        width: 60,
        padding: EdgeInsets.zero,
        headerPadding: EdgeInsets.zero,
      ),
      GridTextColumn(
//        mappingName: 'name',
        headerText: '    Tgt',
        width: 75,
        headerPadding: EdgeInsets.zero,
      ),
      GridTextColumn(
//        mappingName: 'designation',
        headerText: 'Pro. Rata',
        width: 60,
        headerPadding: EdgeInsets.zero,
      ),
      GridNumericColumn(
//        mappingName: 'salary',
        headerText: 'Act',
        width: 60,
        headerPadding: EdgeInsets.zero,
      ),
      GridNumericColumn(
//        mappingName: 'salary',
        headerText: 'Act%',
        width: 80,
        headerPadding: EdgeInsets.zero,
      ),
    ],
        ),
            );
  }
}