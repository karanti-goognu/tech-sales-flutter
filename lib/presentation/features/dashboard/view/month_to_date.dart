import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/volume_converted_table_screen.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/volume_generated_site_view.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MonthToDate extends StatefulWidget {
  @override
  _MonthToDateState createState() => _MonthToDateState();
}

class _MonthToDateState extends State<MonthToDate> {
  bool _currentMothDetailsVolume = false;

  final List<ChartData> chartData = [
    ChartData('Converted-30', 75, Color(0xff39B54A)),
    ChartData('Generated-40', 25, Color(0xff00ADEE)),
    ChartData('Conv. Target-45', 0, Color(0xff007CBF)),
    ChartData('Remaining Tgt-15', 0, Color(0xffFFCD00)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left:16.0,right: 16.0),
        child: ListView(
          children: [
            Container(
              height: 600,
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'February Details',
                              style: TextStyle(fontSize: 18),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'All target achievement are shown on Pro rata basis',
                              style: TextStyle(fontSize: 12),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Leads (Count)',
                              style: TextStyle(fontSize: 16),
                            ),
                            Transform.scale(
                                scale: 0.6,
                                child: CupertinoSwitch(
                                  value: _currentMothDetailsVolume,
                                  onChanged: (_) {
                                    setState(
                                        () => _currentMothDetailsVolume = _);
                                  },
                                  activeColor: Colors.amber,
                                )),
                            Text(
                              'Volume (MT)',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Expanded(
                            child: _currentMothDetailsVolume == false
                                ? SfCircularChart(
                                    margin: EdgeInsets.zero,
                                    // backgroundColor: Colors.yellow,
                                    annotations: <CircularChartAnnotation>[
                                      CircularChartAnnotation(
                                        // height: '45.0',
                                        widget: Container(
                                          // padding: EdgeInsets.all(20),
                                          alignment: Alignment.bottomCenter,
                                          height: 75,
                                          width: 75,
                                          // color: Colors.pink,
                                          child: Text(
                                            "Site conversion efficiency",
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        horizontalAlignment:
                                            ChartAlignment.center,
                                        verticalAlignment:
                                            ChartAlignment.center,
                                      ),
                                    ],
                                    legend: Legend(
                                      isVisible: true,
                                      position: LegendPosition.right,
                                      backgroundColor: Colors.white,
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  2)
                                              .toString(),
                                      title: LegendTitle(),
                                    ),
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                          dataSource: chartData,
                                          innerRadius: '55.0',
                                          pointColorMapper:
                                              (ChartData data, _) => data.color,
                                          xValueMapper: (ChartData data, _) =>
                                              data.x,
                                          yValueMapper: (ChartData data, _) =>
                                              data.y)
                                    ])
                                : Column(
                                  children: [
                                    Expanded(
                                      flex:8,
                                      child: SfRadialGauge(
                                          enableLoadingAnimation: true,
                                          axes: <RadialAxis>[
                                              RadialAxis(
                                                radiusFactor: 1.3,
                                                  startAngle: 180,
                                                  endAngle: 0,
                                                canScaleToFit: true,
                                                  minimum: 0,
                                                  maximum: 750,
                                                  ranges: <GaugeRange>[
                                                    GaugeRange(
                                                        startValue: 0,
                                                        endValue: 500,
                                                        color: Colors.green,
                                                        startWidth: 10,
                                                        endWidth: 10),
                                                    GaugeRange(
                                                        startValue: 500,
                                                        endValue: 750,
                                                        color: Colors.orange,
                                                        startWidth: 10,
                                                        endWidth: 10),
                                                  ],
                                                  pointers: <GaugePointer>[
                                                    NeedlePointer(
                                                        value: 500,
                                                        needleColor: Colors.black12,
                                                    )
                                                  ],
                                                  annotations: <GaugeAnnotation>[
                                                    GaugeAnnotation(
                                                        widget: Container(
                                                            child: const Text('67%',
                                                                style: TextStyle(
//                                                                    fontSize: 25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold))),
                                                        angle: 190,
                                                        positionFactor: 0.3)
                                                  ])
                                            ]),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: GridView.count(crossAxisCount: 2,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        childAspectRatio: 8,

                                        children: [
                                        Container(child: Row(
                                          children: [
                                            Text("Waheguru"),
                                            IconButton(icon: Icon(Icons.arrow_forward_ios),
                                                onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>VolumeGeneratedSiteList())))
                                          ],
                                        ),
                                        color: Colors.blue,),
                                        Container(child: Row(
                                          children: [
                                            Text("Waheguru"),
                                            IconButton(icon: Icon(Icons.arrow_forward_ios),
                                                onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>VolumeConvertedTable()))
                                            )
                                          ],
                                        ),
                                          color: Colors.green,),
                                        Container(child: Text("Waheguru"),
                                          color: Colors.yellow,),
                                        Container(child: Text("Waheguru"),
                                          color: Colors.indigo,)
                                      ],)
                                    ),
                                  ],
                                )),
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    flex: 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              'DSP Slab Coversion',
                              style: TextStyle(fontSize: 18),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Total Slab Opportunities',
                              style: TextStyle(fontSize: 11),
                            ),
                            Expanded(child: Container())
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Slab (Count)',
                              style: TextStyle(fontSize: 16),
                            ),
                            Transform.scale(
                                scale: 0.6,
                                child: CupertinoSwitch(
                                    value: false, onChanged: (_) {})),
                            Text(
                              'Volume (MT)',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        Expanded(
                            child: SfCircularChart(
                                margin: EdgeInsets.zero,
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.right,
                                  backgroundColor: Colors.white,
                                  width: (MediaQuery.of(context).size.width / 2)
                                      .toString(),
                                  title: LegendTitle(),
                                ),
                                annotations: <CircularChartAnnotation>[
                              CircularChartAnnotation(
                                // height: '45.0',
                                widget: Container(
                                  // padding: EdgeInsets.all(20),
                                  alignment: Alignment.bottomCenter,
                                  height: 75,
                                  width: 75,
                                  // color: Colors.pink,
                                  child: Text(
                                    "Site conversion efficiency on Count",
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                horizontalAlignment: ChartAlignment.center,
                                verticalAlignment: ChartAlignment.center,
                              ),
                            ],
                                series: <CircularSeries>[
                              DoughnutSeries<ChartData, String>(
                                  dataSource: chartData,
                                  innerRadius: '55.0',
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y)
                            ])),
                      ],
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Show January (Prev.) Data',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: ColorConstants.appBarColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color color;
}
