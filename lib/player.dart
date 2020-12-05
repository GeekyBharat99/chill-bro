import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final link;

  const VideoPlayer({Key key, @required this.link}) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    this.initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.link);
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      allowedScreenSleep: false,
      autoInitialize: true,
      looping: false,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            "Something went wrong or Low Speed Internet, please let us know that this is not working, we will try to fix it.",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: _chewieController != null &&
                _chewieController.videoPlayerController.value.initialized
            ? Chewie(
                controller: _chewieController,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ),
      ),
    ));
  }
}
