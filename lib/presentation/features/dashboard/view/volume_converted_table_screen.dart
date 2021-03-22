import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class VolumeConvertedTable extends StatefulWidget {
  @override
  _VolumeConvertedTableState createState() => _VolumeConvertedTableState();
}

class _VolumeConvertedTableState extends State<VolumeConvertedTable> {
  final DataGridController _controller = DataGridController();
  final EmployeeDataSource _employeeDataSource = EmployeeDataSource();
  DashboardController _dashboardController = Get.find();

  @override
  void initState() {
    _dashboardController.getDashboardMtdConvertedVolumeList();
    print('${_dashboardController.mtdConvertedVolumeList.supplyQty}test');
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
          Text('Total Count-20'),
          Container(
            child: SfDataGrid(
              controller: _controller,
              source: _employeeDataSource,
              headerRowHeight: 40,
              gridLinesVisibility: GridLinesVisibility.none,
              columns: [
                GridNumericColumn(
                    mappingName: 'id',
                    headerText: 'Site ID​',
                    width: 60,
                    padding: EdgeInsets.zero,
                    headerPadding: EdgeInsets.zero,
                ),
                GridTextColumn(
                    mappingName: 'name',
                    headerText: '    Current Stage​',
                    width: 125,
                    headerPadding: EdgeInsets.zero,
                ),
                GridTextColumn(
                    mappingName: 'designation',
                    headerText: 'Brand​',
                    width: 60,
                    headerPadding: EdgeInsets.zero,
                ),
                GridNumericColumn(
                    mappingName: 'salary',
                    headerText: 'Qty',
                    width: 60,
                    headerPadding: EdgeInsets.zero,
                ),
                GridNumericColumn(
                    mappingName: 'salary',
                    headerText: 'Supply Date',
                    width: 100,
                    headerPadding: EdgeInsets.zero,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
