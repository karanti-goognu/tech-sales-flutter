import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineSeriesForYTD extends StatefulWidget {
  const LineSeriesForYTD({
    Key key,
    @required this.chartData,
    @required this.chartData2,
  }) : super(key: key);

  final List<ChartData> chartData;
  final List<ChartData> chartData2;

  @override
  _LineSeriesForYTDState createState() => _LineSeriesForYTDState();
}

class _LineSeriesForYTDState extends State<LineSeriesForYTD> {
  DashboardController _dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            labelRotation: 90,
            visibleMaximum: 12

//            labelPlacement: LabelPlacement.betweenTicks,
//            interval: 5
        ),
        // title: ChartTitle(text: 'Half yearly sales analysis'),
        legend: Legend(isVisible: true, position:LegendPosition.top),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<ChartData, String>>[
          LineSeries<ChartData, String>(
              dataSource: widget.chartData,
            xValueMapper: (ChartData data, _) => data.month,
            yValueMapper: (ChartData data, _) => data.count,
              name: _dashboardController.lineChartLegend1.toString(),
              dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
               LineSeries<ChartData, String>(
              dataSource: widget.chartData2,
                 xValueMapper: (ChartData data, _) => data.month,
                 yValueMapper: (ChartData data, _) => data.count,
              name: _dashboardController.lineChartLegend2.toString(),
              dataLabelSettings: DataLabelSettings(isVisible: true),
              )
        ]);
  }
}
