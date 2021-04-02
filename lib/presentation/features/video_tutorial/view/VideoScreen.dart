import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';
import 'package:flutter_tech_sales/utils/global.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final videoData;

  Video({this.videoData});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController videoPlayerController;

  initState() {
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
    videoPlayerController = VideoPlayerController.network(widget.videoData.url);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      showControls: true,
      // fullScreenByDefault: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          title: Text(widget.videoData.description),
          backgroundColor: ColorConstants.backgroundColorBlue),
      body: Container(
        child: Chewie(
          controller: chewieController,
        ),
      ),
    );
  }
}
