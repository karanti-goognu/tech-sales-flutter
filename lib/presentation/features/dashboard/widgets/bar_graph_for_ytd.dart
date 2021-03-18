import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarGraphForYTD extends StatelessWidget {
  const BarGraphForYTD({
    Key key,
    @required this.chartData,
  }) : super(key: key);

  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
      ColumnSeries<ChartData, String>(
          dataSource: chartData,
          name: 'Leads Generation',
          xValueMapper: (ChartData data, _) => data.month,
          yValueMapper: (ChartData data, _) => data.count),
      ColumnSeries<ChartData, String>(
          dataSource: chartData,
          name: 'Leads Conversion',
          xValueMapper: (ChartData data, _) => data.month,
          yValueMapper: (ChartData data, _) => data.count),
    ]);
  }
}