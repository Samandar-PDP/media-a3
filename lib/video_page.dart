import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VidePageState();
}

class _VidePageState extends State<VideoPage> {

  late VideoPlayerController _playerController;

  @override
  void initState() {
    _playerController = VideoPlayerController.asset(
      'assets/video/video1.mp4'
    )..initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 15 / 10,
              child: VideoPlayer(
                _playerController,
              ),
            ),
            const Gap(20),
            IconButton(onPressed: () async {
              if(_playerController.value.isPlaying) {
                await _playerController.pause();
              } else {
                await _playerController.play();
              }
            }, icon: Icon(CupertinoIcons.play))
          ],
        ),
      ),
    );
  }
}
