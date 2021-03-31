import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';

class BarGraphForYTD extends StatefulWidget {
  const BarGraphForYTD({
    Key key,
    @required this.chartData,
    @required this.chartData2,
  }) : super(key: key);

  final List<ChartData> chartData;
  final List<ChartData> chartData2;

  @override
  _BarGraphForYTDState createState() => _BarGraphForYTDState();
}

class _BarGraphForYTDState extends State<BarGraphForYTD> {
  DashboardController _dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {
    return
//      Obx(()=>
        SfCartesianChart(
        legend: Legend(isVisible: true,position: LegendPosition.top, ),
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
//          axisLine: AxisLine(color: Colors.pinkAccent),
            majorGridLines: MajorGridLines(width: 0),
            labelRotation: 90,
            visibleMaximum: 12

//            labelPlacement: LabelPlacement.betweenTicks,
//            interval: 5
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: true,
        ),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: widget.chartData,
            name: _dashboardController.barGraphLegend1.toString(),
            xValueMapper: (ChartData data, _) => data.month,
            yValueMapper: (ChartData data, _) => data.count,
            dataLabelSettings: DataLabelSettings(
                isVisible: true, textStyle: const TextStyle(fontSize: 10)),
          ),
          ColumnSeries<ChartData, String>(
            dataSource: widget.chartData2,
            name: _dashboardController.barGraphLegend2.toString(),
            xValueMapper: (ChartData data, _) => data.month,
            yValueMapper: (ChartData data, _) => data.count,
            dataLabelSettings: DataLabelSettings(
                isVisible: true, textStyle: const TextStyle(fontSize: 10)),
          ),
        ])
//      )
    ;
  }
}
