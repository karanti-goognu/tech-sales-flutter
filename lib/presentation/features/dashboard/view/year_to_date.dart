
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/datagrid_for_ytd.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/widgets/line_series_for_ytd.dart';
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
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Leads (Count)',
                  style: TextStyle(fontSize: 16),
                ),
                CupertinoSwitch(value: false, onChanged: (_) {}),
                Text(
                  'Volume (MT)',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform(
                  transform: Matrix4.identity()..scale(0.8),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          items: ['waheguru', 'waheguru']
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
                Transform(
                  transform: Matrix4.identity()..scale(0.8),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          items: ['waheguru', 'waheguru']
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (_) {}),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: LineSeriesForYTD(chartData: chartData),),
            // Expanded(child: BarGraphForYTD(chartData: chartData)),
            Expanded(child: DataGridForYTD(controller: _controller))
          ],
        ));
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
