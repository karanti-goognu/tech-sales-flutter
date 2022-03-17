

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController videoPlayerController;
  String? videoUrl="", videoDes="";


  initState() {
    var data = Get.arguments;
    videoUrl= data[0];
    videoDes= data[1];
    internetChecking().then((result) => {
          if (result == true)
            {}
          else
            {
              Get.snackbar("No internet connection.",
                  "Make sure that your wifi or mobile data is turned on.",
                  colorText: Colors.white,
                  backgroundColor: Colors.red,
                  snackPosition: SnackPosition.BOTTOM),
            }
        });
    videoPlayerController = VideoPlayerController.network(videoUrl!);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      showControls: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  late ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text(videoDes!),
          backgroundColor: ColorConstants.backgroundColorBlue),
      body: Container(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
