import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineSeriesForYTD extends StatelessWidget {
  const LineSeriesForYTD({
    Key key,
    @required this.chartData,
  }) : super(key: key);

  final List<ChartData> chartData;
  

  @override
  Widget build(BuildContext context) {

  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
    List<_SalesData> data2 = [
    _SalesData('Jan', 3),
    _SalesData('Feb', 8),
    _SalesData('Mar', 34),
    _SalesData('Apr', 2),
    _SalesData('May', 40)
  ];

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
      
        // title: ChartTitle(text: 'Half yearly sales analysis'),
        legend: Legend(isVisible: true, position:LegendPosition.top),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_SalesData, String>>[
          LineSeries<_SalesData, String>(
              dataSource: data,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Leads Gen. Avg',
              dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
               LineSeries<_SalesData, String>(
              dataSource: data2,
              xValueMapper: (_SalesData sales, _) => sales.year,
              yValueMapper: (_SalesData sales, _) => sales.sales,
              name: 'Leads Conv. Avg',
              dataLabelSettings: DataLabelSettings(isVisible: true),
              )
        ]);
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}