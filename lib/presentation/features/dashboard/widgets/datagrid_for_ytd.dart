import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final EmployeeDataSource _employeeDataSource = EmployeeDataSource();


class DataGridForYTD extends StatelessWidget {
  const DataGridForYTD({
    Key key,
    @required DataGridController controller,
  }) : _controller = controller, super(key: key);

  final DataGridController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
              child: SfDataGrid(
    controller: _controller,
    source: _employeeDataSource,
    gridLinesVisibility: GridLinesVisibility.none,
    verticalScrollPhysics: NeverScrollableScrollPhysics(),
    columns: [
      GridNumericColumn(mappingName: 'id', headerText: 'MTD'),
      GridTextColumn(mappingName: 'name', headerText: 'Tgt'),
      GridTextColumn(mappingName: 'designation', headerText: 'Pro. Rata'),
      GridNumericColumn(mappingName: 'salary', headerText: 'Act'),
      GridNumericColumn(
        mappingName: 'salary',
        headerText: 'Act%',
      ),
    ],
        ),
            );
  }
}