import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
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
  // static GlobalKey previewContainer = new GlobalKey();
  // static const androidMethodChannel = const MethodChannel('team.native.io/screenshot');

  // Future<Null> _screenShot() async{
  //   try{
  //     print("Hello");
  //     RenderRepaintBoundary boundary = previewContainer.currentContext.findRenderObject();
  //     ui.Image image = await boundary.toImage();
  //     final directory = (await getExternalStorageDirectory()).path;
  //     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //     File imgFile =new File('$directory/screenshot.png');
  //     imgFile.writeAsBytes(pngBytes);
  //     Uri fileURI= new Uri.file('$directory/screenshot.png');
  //     print('Screenshot Path:'+imgFile.path);
  //     await androidMethodChannel.invokeMethod('takeScreenshot',{'filePath':imgFile.path});
  //   }
  //   on PlatformException catch(e){
  //     print("Exception while taking screenshot:"+e.toString());
  //   }
  // }

  ScreenshotController screenshotController = ScreenshotController();
    Uint8List _imageFile;


  @override
  Widget build(BuildContext context) {
    return 
    // RepaintBoundary(key: previewContainer, child: 
    Screenshot(
      controller: screenshotController,
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
                  onPressed: (){
            _imageFile = null;
            screenshotController
                .capture(delay: Duration(milliseconds: 10))
                .then((Uint8List image) async {
                  print(image);
              _imageFile = image;
              Get.dialog(
                Container(
                  // height: 200,
                  child: Image.memory(_imageFile,height: 100,
                  width:100,fit: BoxFit.contain,),),
                  barrierDismissible: true
              );
              // showDialog(
              //   context: context,
              //   builder: (context) => Scaffold(
                
              //     // appBar: AppBar(
              //     //   title: Text("CAPURED SCREENSHOT"),
              //     // ),
              //     body: Container(
              //       height: 200,
              //         child: Column(
              //       children: [
              //         _imageFile != null ? Image.memory(_imageFile) : Container(),
              //       ],
              //     )),
              //   ),
              // );
            }).catchError((onError) {
              print(onError);
            });
          
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
