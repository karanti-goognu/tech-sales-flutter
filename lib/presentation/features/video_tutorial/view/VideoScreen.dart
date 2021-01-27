import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tech_sales/utils/constants/color_constants.dart';


class Video extends StatefulWidget {
  final  videoData;
  Video({this.videoData});
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  VideoPlayerController videoPlayerController;
  initState(){
    videoPlayerController= VideoPlayerController.network('https://mobileqacloud.dalmiabharat.com//tso/tutorial/lead_creation_module.mp4');
    chewieController=ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16/9,
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

  ChewieController chewieController ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(widget.videoData),backgroundColor: ColorConstants.backgroundColorBlue),
      body: Container(
        child: Chewie(
          controller: chewieController,
        ),
      ),

    );
  }
}