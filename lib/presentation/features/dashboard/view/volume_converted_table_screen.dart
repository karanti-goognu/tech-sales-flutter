import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VolumeConvertedTable extends StatefulWidget {
  @override
  _VolumeConvertedTableState createState() => _VolumeConvertedTableState();
}

class _VolumeConvertedTableState extends State<VolumeConvertedTable> {
  final DataGridController _controller = DataGridController();
  final EmployeeDataSource _employeeDataSource = EmployeeDataSource();

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
        Text('MTD Vol. Converted',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text('Total Count-20'),
      Container(
        child: SfDataGrid(
          controller: _controller,
          source: _employeeDataSource,
          gridLinesVisibility: GridLinesVisibility.none,
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
      )
        ],
      ),
    );
  }
}
