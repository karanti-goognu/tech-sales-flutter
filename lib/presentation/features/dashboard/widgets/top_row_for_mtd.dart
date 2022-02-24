import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/month_to_date.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TopRowForMTD extends StatelessWidget {
  const TopRowForMTD({
    Key? key,
    required bool currentMothDetailsVolume,
    required DashboardController dashboardController,
  })  : _currentMothDetailsVolume = currentMothDetailsVolume,
        _dashboardController = dashboardController,
        super(key: key);

  final bool _currentMothDetailsVolume;
  final DashboardController _dashboardController;

  @override
  Widget build(BuildContext context) {
 //   print("Dash-- ${(int.parse(_dashboardController.convertedCount.toString()) / int.parse(_dashboardController.convTargetCount.toString()))}");
//    print((int.parse(_dashboardController.convTargetCount.toString()) / int.parse(_dashboardController.generatedCount.toString())).toInt());
    return Expanded(
        child: _currentMothDetailsVolume == false
            ? Obx(() => Stack(
          children: [
            SfCircularChart(
                margin: EdgeInsets.zero,
                // backgroundColor: Colors.yellow,
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Container(
                      alignment: Alignment.topCenter,
                      height: 80,
                      width: 80,
                      child: Text.rich(
                        TextSpan(
                            text:
                            "${((int.parse(_dashboardController.convertedCount.toString()) / int.parse(_dashboardController.convTargetCount.toString())).isNaN || ((int.parse(_dashboardController.convertedCount.toString()) / int.parse(_dashboardController.convTargetCount.toString())).isInfinite))
                                ? 0 :
                            ((int.parse(_dashboardController.convertedCount.toString()) / int.parse(_dashboardController.convTargetCount.toString()))*100).round()}%\n",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal!*6,
                                color: HexColor('#002A64'),
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "Site conversion efficiency",
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
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.right,
                  backgroundColor: Colors.white,
                  width: (MediaQuery.of(context).size.width / 2).toString(),
                  title: LegendTitle(),
                ),
                series: <CircularSeries>[
                  DoughnutSeries<ChartDataForMTD, String>(
                      dataSource: [
                        ChartDataForMTD(
                            'Converted-${_dashboardController.convertedCount}',
                            _dashboardController.convertedCount.toDouble(),
                            Color(0xff39B54A)),
                        ChartDataForMTD(
                            'Generated-${_dashboardController.generatedCount}',
                            _dashboardController.generatedCount.toDouble(),
                            Color(0xff00ADEE)),
                        ChartDataForMTD(
                            'Conv. Target-${_dashboardController.convTargetCount}',
                            _dashboardController.convTargetCount.toDouble(),
                            Color(0xff007CBF)),
                        ChartDataForMTD(
                            'Remaining Tgt-${_dashboardController.remainingTargetCount}',
                            _dashboardController.remainingTargetCount.toDouble(),
                            Color(0xffFFCD00)),
                      ],
                      innerRadius: '65.0',
                      pointColorMapper: (ChartDataForMTD data, _) => data.color,
                      strokeColor: Colors.red,
                      xValueMapper: (ChartDataForMTD data, _) => data.x,
                      yValueMapper: (ChartDataForMTD data, _) => data.y)
                ]),
            Positioned(
                bottom: 0,right: 0,
                child:
                _dashboardController.mwpPlanApproveStatus.toString()!="APPROVE"?
                Text("MWP plan not approved", style: TextStyle(color: Colors.red, fontSize: SizeConfig.blockSizeHorizontal!*2.5,

                ),):Container())
          ],
        ))
            : Obx(()=>Column(
          children: [
            Expanded(
              flex: 9,
              child:
              _dashboardController
                  .generatedVolume==0?
              Center(child: Text("Target is not yet set"),)
                  :SfRadialGauge(
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                        radiusFactor: 1.3,
                        startAngle: 180,
                        endAngle: 0,
                        canScaleToFit: true,
                        minimum: 0,
                        maximum: int.parse(_dashboardController
                            .generatedVolume
                            .toString())
                            .toDouble(),
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: int.parse(_dashboardController
                                  .generatedVolume
                                  .toString())
                                  .toDouble(),
                              color: HexColor('00ADEE'),
                              startWidth: 15,
                              endWidth: 15),
                          GaugeRange(
                              startValue: 0,
                              endValue:  int.parse(_dashboardController
                                  .convertedVolume
                                  .toString()).toDouble(),
                              color: HexColor('39B54A'),
                              startWidth: 15,
                              endWidth: 15),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(
                            value:
//                            (int.parse(_dashboardController
//                                .convertedCount
//                                .toString()) /
//                                int.parse(_dashboardController
//                                    .generatedCount
//                                    .toString()))
//                                .isNaN ? 0 :
                            int.parse(_dashboardController
                                .convertedVolume
                                .toString()).toDouble(),
                            needleColor: Colors.black12,
                          )
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              widget: Container(
                                  child: Text(
                                      "${(int.parse(_dashboardController.convertedVolume.toString()) / int.parse(_dashboardController.convTargetVolume.toString())).isNaN || ((int.parse(_dashboardController.convertedVolume.toString()) / int.parse(_dashboardController.convTargetVolume.toString())).isInfinite)
                                          ? 0 : ((int.parse(_dashboardController.convertedVolume.toString()) / int.parse(_dashboardController.convTargetVolume.toString()))*100).round()}%",
                                      style: TextStyle(
//                                           fontSize: 25,
                                          fontWeight: FontWeight.bold))),
                              angle: 190,
                              positionFactor: 0.3)
                        ])
                  ]),
            ),
            Expanded(
                flex: 4,
                child:
                Column(
//                GridView.count(
//                  crossAxisCount: 2,
//                  physics: NeverScrollableScrollPhysics(),
//                  shrinkWrap: true,
//                  childAspectRatio: 7,
                  children: [
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap:  () =>
                                    Get.toNamed(Routes.DASHBOARD_SITE_LIST,),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: Text(
                                            "Generated-${_dashboardController.generatedVolume} MT",
                                            style: TextStyle(
                                                fontSize: SizeConfig.blockSizeHorizontal!*3.6
                                            ),
                                            textAlign: TextAlign.center),
                                      ),
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  color: Colors.blue.withOpacity(0.3),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.toNamed(
                                    Routes.DASHBOARD_VOLUME_CONVERTED),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                          "Converted-${_dashboardController.convertedVolume} MT",
                                          style: TextStyle(
                                              fontSize: SizeConfig.blockSizeHorizontal!*3.6
                                          ),
                                          textAlign: TextAlign.center),
                                      IconButton(
                                        onPressed: (){},
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  color: Colors.green.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(
                                    "Remaining Tgt-${_dashboardController.remainingTargetVolume} MT",
                                    style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal*3.6
                                    ),
                                    textAlign: TextAlign.center),
                                color: Colors.yellow.withOpacity(0.3),
                                alignment: Alignment.center,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                    "Conv. Target-${_dashboardController.convTargetVolume} MT",
                                    style: TextStyle(
                                        fontSize: SizeConfig.safeBlockHorizontal*3.6
                                    ),
                                    textAlign: TextAlign.center),
                                color: Colors.indigo.withOpacity(0.3),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ],
        )));
  }
}
