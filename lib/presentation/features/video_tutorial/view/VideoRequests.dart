import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/data/model/TsoAppTutorialListModel.dart';
import 'package:flutter_tech_sales/routes/app_pages.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/functions/convert_to_hex.dart';
import 'package:flutter_tech_sales/presentation/features/video_tutorial/controller/tutorial_list_controller.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:flutter_tech_sales/widgets/customFloatingButton.dart';
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

    internetChecking().then((result) => {
      if (result == true)
        {
        getAppTutorialListData().whenComplete(() {
          setState(() {
            tsoAppTutorialListModel = data;});
        })
        }else{
        Get.snackbar(
            "No internet connection.", "Make sure that your wifi or mobile data is turned on.",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM),
        // fetchSiteList()
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.appBarColor,
        toolbarHeight: 90,
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
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SpeedDialFAB(speedDial: speedDial, customStyle: customStyle),
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
                  padding: EdgeInsets.zero,
                    itemCount: tsoAppTutorialListModel
                        .tsoAppTutorial.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.VIDEO_PLAYER, arguments: [
                            tsoAppTutorialListModel.tsoAppTutorial[index].url,
                            tsoAppTutorialListModel.tsoAppTutorial[index].description
                          ]);

                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context) =>
                            //         Video(videoData: tsoAppTutorialListModel
                            //             .tsoAppTutorial[index],)
                            // ));
                          // activityVideo(context, index);
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          clipBehavior: Clip.antiAlias,
                          borderOnForeground: true,
                          elevation: 6,
                          color: Colors.white,
                          child: Container(
                            // height: 120,
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
    return Padding(
      // padding: const EdgeInsets.fromLTRB(16,24.0,24.0,27),
      padding: const EdgeInsets.fromLTRB(0,0,0,0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 120,
              color: Colors.grey,
              child: Image.network('${tsoAppTutorialListModel.tsoAppTutorial[index].thumbnailUrl}', fit: BoxFit.fill,),
            ),
            // SizedBox(width: 10,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
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
                          fontSize: 10,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.bold
                        //fontWeight: FontWeight.normal
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
      ),
    );
  }

  void activityVideo(BuildContext context, int index){
   // var _controller = VideoPlayerController.network("${tsoAppTutorialListModel.tsoAppTutorial[index].category}");
    var alertDialog = AlertDialog(
        titlePadding: EdgeInsets.all(10),
        contentPadding: EdgeInsets.all(0),
        content: Container(
          color: Colors.black,
          height: 230,width: 300,
          child: VideoPlayerScreen(url:'https://mobileqacloud.dalmiabharat.com//tso/tutorial/lead_creation_module.mp4'),
        ),
        title: Text("${tsoAppTutorialListModel.tsoAppTutorial[index].description}", style: TextStyle(fontSize: 12),),
    );
    showDialog(context: context,
        builder: (BuildContext context){
          return alertDialog;
        }
    );
  }
}
class VideoPlayerScreen extends StatefulWidget {
  final url;
  VideoPlayerScreen({Key key, this.url}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
   // print('####'+widget.url);
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      widget.url,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.backgroundColorBlue,
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}