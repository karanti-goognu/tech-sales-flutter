import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';



class DataGridForYTD extends StatefulWidget {
  const DataGridForYTD({
    Key? key,
    required DataGridController controller,
  }) : _controller = controller, super(key: key);

  final DataGridController _controller;

  @override
  _DataGridForYTDState createState() => _DataGridForYTDState();
}

class _DataGridForYTDState extends State<DataGridForYTD> {


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return
        Column(
          children: [
            Container(
              height: SizeConfig.screenHeight!/20,
              color: HexColor('707070'),
              child: Row(
              children: [
                Expanded(
                  child: Text("MTD", style: TextStyle(color: HexColor('FFFFFF')),textAlign: TextAlign.center,),
                ),
                Expanded(
                  child: Text("Tgt", style: TextStyle(color: HexColor('FFFFFF')),textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text("Pro. Rata", style: TextStyle(color: HexColor('FFFFFF')),textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text("Act", style: TextStyle(color: HexColor('FFFFFF')),textAlign: TextAlign.center),
                ),
                Expanded(
                  child: Text("Act%", style: TextStyle(color: HexColor('FFFFFF')),textAlign: TextAlign.center),
                )
              ],
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.12),
//              height: SizeConfig.screenHeight/11,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Conv", textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          child: Text("100", textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text("90", textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text("80", textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text("80%",textAlign: TextAlign.center),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Slab", textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          child: Text("50", textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text("45", textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text("30", textAlign: TextAlign.center),
                        ),
                        Expanded(
                          child: Text("60%",textAlign: TextAlign.center),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )

          ],
        );
//      Container(
//      decoration: BoxDecoration(
//        border: Border.all(color: Colors.black26),
//        color: HexColor('#000001F')
//      ),
//    child: SfDataGrid(
//    controller: widget._controller,
//    source: _employeeDataSource,
//    gridLinesVisibility: GridLinesVisibility.none,
//    verticalScrollPhysics: NeverScrollableScrollPhysics(),
//    columns: [
//      GridNumericColumn(
////        mappingName: 'id',
//        headerText: 'MTD',
//        width: 60,
//        padding: EdgeInsets.zero,
//        headerPadding: EdgeInsets.zero,
//      ),
//      GridTextColumn(
////        mappingName: 'name',
//        headerText: '    Tgt',
//        width: 75,
//        headerPadding: EdgeInsets.zero,
//      ),
//      GridTextColumn(
////        mappingName: 'designation',
//        headerText: 'Pro. Rata',
//        width: 60,
//        headerPadding: EdgeInsets.zero,
//      ),
//      GridNumericColumn(
////        mappingName: 'salary',
//        headerText: 'Act',
//        width: 60,
//        headerPadding: EdgeInsets.zero,
//      ),
//      GridNumericColumn(
////        mappingName: 'salary',
//        headerText: 'Act%',
//        width: 80,
//        headerPadding: EdgeInsets.zero,
//      ),
//    ],
//        ),
//            );
  }
}