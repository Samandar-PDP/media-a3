import 'package:flutter/material.dart';
import 'package:media_player_a3/video_page.dart';

import 'music_page.dart';

void main() {
  runApp(const MediaApp());
}

class MediaApp extends StatelessWidget {
  const MediaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const VideoPage(),
    );
  }
}
