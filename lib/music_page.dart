import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {

  Duration duration = const Duration(seconds: 0);

  final _player = AudioPlayer();
  int _index = 0;
  final _musics = [
    'braz',
    'dvrs',
    'interworld'
  ];
  final _names = [
    'Brazilian Phonk',
    'Close eyes',
    'Interworld Metamorphosis'
  ];

  void _getTotalDuration() {
    _player.getDuration().then((value) {
      duration = value ?? const Duration(microseconds: 0);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _getTotalDuration();
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(20),
              Lottie.asset('assets/anim/anim_1.json',width: 300,height: 300, animate: _player.state == PlayerState.playing),
              const Gap(120),
              Text(_names[_index],style: const TextStyle(fontSize: 25,color: Colors.white),),
              const Gap(30),
              StreamBuilder(
                stream: _player.onPositionChanged,
                builder: (context, snapshot) {
                  return ProgressBar(
                    progress: snapshot.data ?? const Duration(seconds: 0),
                    baseBarColor: Colors.white,
                    thumbColor: Colors.blueGrey,
                    thumbGlowColor: Colors.blue,
                    total: duration,
                    onSeek: (v) {
                      _player.seek(v);
                      setState(() {

                      });
                    },
                  );
                },
              ),
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: () {
                    setState(() {

                    });
                    if(_index > 0) {
                      _index--;
                      _backOrForward();
                    }
                  }, icon: const Icon(CupertinoIcons.backward_end,color: Colors.white,)),
                  IconButton(onPressed: _playFromNetwork, icon:  Icon(_player.state == PlayerState.playing ? CupertinoIcons.pause_circle : CupertinoIcons.play_circle,color: Colors.white,size: 40,)),
                  IconButton(onPressed: () {
                    setState(() {

                    });
                    if(_index < _musics.length - 1) {
                      _index++;
                      _backOrForward();
                    }
                  }, icon: Icon(CupertinoIcons.forward_end, color: Colors.white,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _backOrForward() async {
    setState(() {

    });
    await _player.play(AssetSource('audio/${_musics[_index]}.mp3'));
  }

  void _playOrPause() async {
    if(_player.state == PlayerState.playing) {
      await _player.pause();
    } else {
      await _player.play(AssetSource('audio/${_musics[_index]}.mp3'));
    }
    setState(() {

    });
  }
  void _playFromNetwork() async {
    await _player.play(UrlSource("https://file-examples.com/storage/febcc861de6574e979a4c35/2017/11/file_example_MP3_2MG.mp3"));
  }
}
