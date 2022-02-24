import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/month_to_date.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DspColumnChild extends StatelessWidget {
  const DspColumnChild({
    Key? key,
    required bool currentMothDspSlabVolume,
    required DashboardController dashboardController,
  })  : _currentMothDspSlabVolume = currentMothDspSlabVolume,
        _dashboardController = dashboardController,
        super(key: key);

  final bool _currentMothDspSlabVolume;
  final DashboardController _dashboardController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: _currentMothDspSlabVolume == false
            ? Obx(() => SfCircularChart(
            margin: EdgeInsets.zero,
            legend: Legend(
              isVisible: true,
              position: LegendPosition.right,
              backgroundColor: Colors.white,
              width: (MediaQuery.of(context).size.width / 2).toString(),
              title: LegendTitle(),
            ),
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                // height: '45.0',
                widget: Container(
                  alignment: Alignment.topCenter,
                  height: 88,
                  width: 85,
                  child: Text.rich(
                    TextSpan(
                        text:
                        "${(int.parse(_dashboardController.dspSlabConvertedCount.toString()) / int.parse(_dashboardController.dspTotalOpperCount.toString())).isNaN ? 0 : ((int.parse(_dashboardController.dspSlabConvertedCount.toString()) / int.parse(_dashboardController.dspTotalOpperCount.toString()))*100).round()}%\n",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal!*6,
                            color: HexColor('#002A64'),
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: "Site conversion efficiency on Count",
                            style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal!*2),
                          )
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                horizontalAlignment: ChartAlignment.center,
                verticalAlignment: ChartAlignment.center,
              ),
            ],
            series: <CircularSeries>[
              DoughnutSeries<ChartDataForMTD, String>(
                  dataSource: [
                    ChartDataForMTD(
                        'Total Opp\'ty-${_dashboardController.dspTotalOpperCount}',
                        _dashboardController.dspTotalOpperCount.toDouble(),
                        Color(0xff39B54A)),
                    ChartDataForMTD(
                        'DSP Target-${_dashboardController.dspTargetCount}',
                        _dashboardController.dspTargetCount.toDouble(),
                        Color(0xff00ADEE)),
                    ChartDataForMTD(
                        'Slab Converted-${_dashboardController.dspSlabConvertedCount}',
                        _dashboardController.dspSlabConvertedCount.toDouble(),
                        Color(0xff007CBF)),
                    ChartDataForMTD(
                        'Remaining Tgt-${_dashboardController.dspRemaingTargetCount}',
                        _dashboardController.dspRemaingTargetCount.toDouble(),
                        Color(0xffFFCD00)),
                  ],
                  innerRadius: '65.0',
                  pointColorMapper: (ChartDataForMTD data, _) => data.color,
                  xValueMapper: (ChartDataForMTD data, _) => data.x,
                  yValueMapper: (ChartDataForMTD data, _) => data.y)
            ]))
            : Obx(()=>Column(
          children: [
            Expanded(
              flex: 9,
              child:
              _dashboardController
                  .dspTotalOpperVolume==0?
              Center(child: Text("Target is not yet set"),)
                  :
              SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                        radiusFactor: 1.3,
                        startAngle: 180,
                        endAngle: 0,
                        canScaleToFit: true,
                        minimum: 0,
                        maximum: int.parse(_dashboardController
                            .dspTotalOpperVolume
                            .toString())
                            .toDouble(),
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue:  int.parse(_dashboardController
                                  .dspTotalOpperVolume
                                  .toString())
                                  .toDouble(),
                              color: HexColor('00ADEE'),
                              startWidth: 15,
                              endWidth: 15),
                          GaugeRange(
                              startValue: 0,
                              endValue :int.parse(_dashboardController
                                  .dspSlabConvertedVolume
                                  .toString())
                                  .toDouble(),
                              color: HexColor('39B54A'),
                              startWidth: 15,
                              endWidth: 15),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value:
//                            (int.parse(_dashboardController
//                                .convTargetCount
//                                .toString()) /
//                                int.parse(_dashboardController
//                                    .dspTotalOpperVolume
//                                    .toString()))
//                                .isNaN  ? 0 :
                            int.parse(_dashboardController
                                .dspSlabConvertedVolume
                                .toString()).toDouble() ,
                            needleColor: Colors.black12,
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Container(
                                  child: Text(
                                      '${(int.parse(_dashboardController.dspSlabConvertedVolume.toString()) / int.parse(_dashboardController.dspTotalOpperVolume.toString())).isNaN ? 0 : (int.parse(_dashboardController.dspSlabConvertedVolume.toString()) / int.parse(_dashboardController.dspTotalOpperVolume.toString())*100).round()}%',
                                      style: TextStyle(
//                                                                    fontSize: 25,
                                          fontWeight: FontWeight.bold))),
                              angle: 190,
                              positionFactor: 0.3)
                        ])
                  ]),
            ),
            Expanded(
                flex: 3,
                child:
//                GridView.count(
//                  crossAxisCount: 2,
//                  physics: NeverScrollableScrollPhysics(),
//                  shrinkWrap: true,
//                  childAspectRatio: 7,
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  width: SizeConfig.screenWidth,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Opportunity-${_dashboardController
                                .dspTotalOpperVolume} MT",textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal*3.6
                            ),),
                          alignment: Alignment.center,
                          color: Colors.blue.withOpacity(0.3),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            "Converted-${_dashboardController.dspSlabConvertedVolume} MT",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal*3.6
                            ),),
                          alignment: Alignment.center,
                          color: Colors.green.withOpacity(0.3),
                        ),
                      )
                    ],
                  ),
                )),
            SizedBox(height: 5,)
          ],
        )));
  }
}
