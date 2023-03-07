import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoPlayerWidger extends StatefulWidget {
  final String url;
  VideoPlayerWidger(this.url);


  @override
  State<VideoPlayerWidger> createState() => _VideoPlayerWidgerState();
}

class _VideoPlayerWidgerState extends State<VideoPlayerWidger> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool initilizedCheck = false;
  @override
  void initState() {

    super.initState();
    videoPlayerController  = VideoPlayerController.network(widget.url);
    videoPlayerController.initialize().then((value) => {
      chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping:false
      ),
      initilizedCheck = true,
      setState((){}),
    });
  }
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: initilizedCheck ? Chewie(controller: chewieController) : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
