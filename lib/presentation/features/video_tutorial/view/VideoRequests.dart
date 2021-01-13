import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/model/TsoAppTutorialListModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_speed_dial_material_design/flutter_speed_dial_material_design.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/controller/tutorial_list_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_tech_sales/utils/size/size_config.dart';
import 'package:flutter_tech_sales/widgets/bottom_navigator.dart';
import 'package:video_player/video_player.dart';

class VideoRequests extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _VideoRequestsState();
  }

class _VideoRequestsState extends State<VideoRequests> {

  TsoAppTutorialListModel tsoAppTutorialListModel;
  TutorialListController eventController = Get.find();

  var data;
  getAppTutorialListData() async {
    await eventController.getAccessKey().then((value) async {
      data = await eventController.getAppTutorialListData(value.accessKey);
    });
  }

  @override
  void initState() {
    getAppTutorialListData().whenComplete(() {
      setState(() {
        tsoAppTutorialListModel = data;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: 120,
        centerTitle: false,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "VIDEO TUTORIAL".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: "Muli"),
                ),
              ],
            )
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
        Container(
          height: 68.0,
          width: 68.0,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.amber,
              child: Icon(
                Icons.keyboard_backspace,
                color: Colors.black,
              ),
              onPressed: () {
                // gv.fromLead = false;
                Get.toNamed(
                  Routes.HOME_SCREEN,
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigator(),
        body: data == null
            ? Center(
          child: CircularProgressIndicator(),
        )
       : Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              totalCountTutorials(),
              SizedBox(
                height: 5,
              ),
              tsoAppTutorialListModel.tsoAppTutorial != null
              ? Expanded(
                child: ListView.builder(
                    itemCount: tsoAppTutorialListModel
                        .tsoAppTutorial.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          activityVideo(context, index);
                          // _updateServiceRequestController.siteId = serviceRequestComplaintListModel
                          //     .srComplaintListModal[index]
                          //     .srComplaintId;
                          // Get.to(
                          //   RequestUpdation(
                          //       id: tsoAppTutorialListModel
                          //           .tsoAppTutorial[index]
                          //           .id),
                          //   transition: Transition.rightToLeft,
                          // );
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          borderOnForeground: true,
                          elevation: 6,
                          margin: EdgeInsets.all(5.0),
                          color: Colors.white,
                          child: Container(
                            height: 120,
                            padding: EdgeInsets.fromLTRB(8, 4, 8, 0),
                            child: bottomRowWithRequestId(index),
                          ),
                        ),
                      );
                    }),
              ) :
                   Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    tsoAppTutorialListModel.respMsg,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Padding totalCountTutorials() {
    return Padding(
      padding:
      const EdgeInsets.only(top: 10.0, left: 15.0, bottom: 5, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tsoAppTutorialListModel.totalCount != null
                ? "Total Count - ${tsoAppTutorialListModel.totalCount}"
                : "Total Count - 0",
            style: TextStyle(
              fontFamily: "Muli",
              fontSize: 12,
              // color: HexColor("#FFFFFF99"),
            ),
          ),

        ],
      ),
    );
  }

  Widget bottomRowWithRequestId(int index) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.grey,
            child: Image.asset('assets/images/Container.png', width: 92, height: 52,),
            margin: EdgeInsets.only(top: 0, left: 0, right: 10),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${tsoAppTutorialListModel.tsoAppTutorial[index].description}",
                    style: TextStyle(
                        color: HexColor('#002A64'),
                        fontSize: 14,
                        fontFamily: "Muli",
                    ),
                  textAlign: TextAlign.left,
                  ),
                Text("${tsoAppTutorialListModel.tsoAppTutorial[index].category}",
                  style: TextStyle(
                      color: HexColor('#002A64'),
                      fontSize: 14,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.bold
                    //fontWeight: FontWeight.normal
                  ),
                )
              ],
            ),
          ),
        ],
    );
  }

  void activityVideo(BuildContext context, int index){
    var videoUrl = VideoPlayerController.network("${tsoAppTutorialListModel.tsoAppTutorial[index].category}");
    var alertDialog = AlertDialog(
        title: Text("videoclip"),
        actions: <Widget>[
          FlatButton(
              child: Text('Finish'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
    );
    showDialog(context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }
}
