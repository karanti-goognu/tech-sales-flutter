import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/controller/dashboard_controller.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/month_to_date.dart';
import 'package:flutter_tech_sales/presentation/features/dashboard/view/year_to_date.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';

import 'package:screenshot/screenshot.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static GlobalKey previewContainer = new GlobalKey();
  File imgFile;
  Random random = Random();
  DashboardController _dashboardController = Get.find();

  Future<Uint8List> _capturePng() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _capturePng();
    }

    var image = await boundary.toImage();
    var byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData.buffer.asUint8List();
  }

  void _printPngBytes() async {
    var pngBytes = await _capturePng();
    var bs64 = base64Encode(pngBytes);
    int num = random.nextInt(100);
    final directory = (await getExternalStorageDirectory()).path;
    imgFile = new File('$directory/screenshot$num.png');
    imgFile.writeAsBytes(pngBytes);
    print('Screenshot Path:' + imgFile.path);
    _dashboardController.getDetailsForSharingReport(imgFile);
    // print(pngBytes);
    // print(bs64);
  }

  ScreenshotController screenshotController = ScreenshotController();
  // Uint8List _imageFile;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: previewContainer,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('MY DASHBOARD'),
              backgroundColor: ColorConstants.appBarColor,
              actions: [
                Transform.scale(
                  scale: 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        print("Hello");
                        _printPngBytes();
                        // _screenShot();
                        // _imageFile = null;
                        // screenshotController
                        //     .capture(delay: Duration(milliseconds: 10))
                        //     .then((Uint8List image) async {
                        //   print(image);
                        //   _imageFile = image;
                        //   Get.dialog(
                        //       Container(
                        //         child: Image.memory(
                        //           _imageFile,
                        //           height: 100,
                        //           width: 100,
                        //           fit: BoxFit.contain,
                        //         ),
                        //       ),
                        //       barrierDismissible: true);
                        // }).catchError((onError) {
                        //   print(onError);
                        // });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.share),
                          Text('Share'),
                        ],
                      ),
                      color: HexColor('#f9a61a'),
                    ),
                  ),
                )
              ],
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "MONTH TO DATE",
                  ),
                  Tab(
                    text: "YEAR TO DATE",
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigator(),
            floatingActionButton: BackFloatingButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: TabBarView(
              children: [MonthToDate(), YearToDate()],
            )),
        // ),
      ),
    );
  }
}
