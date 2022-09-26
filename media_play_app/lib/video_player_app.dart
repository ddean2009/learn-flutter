import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '媒体播放器',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;
  late Future<void> playerFuture;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.network(
      'https://flv.bn.netease.com/1c04bfd72901f0661b486465e09cfdc01754c20db0686786f4e20a5f7d271ba0de6c1177a0da1c4c2d7c367e20ee16d4a90ac7ff4ea664820ba1b401f3e53f135f72cdff855e78ca5fb7849fb6ff7ccb9de1613ad3bfc59db83493b5f18a0a27f15048df6585361cd67c3b37551e10981c40dcdfdb77b7e6.mp4',
    );

    playerFuture = videoPlayerController.initialize();

    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('这是播放器'),
      ),

      body: FutureBuilder(
        future: playerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (videoPlayerController.value.isPlaying) {
              videoPlayerController.pause();
            } else {
              videoPlayerController.play();
            }
          });
        },
        child: Icon(
          videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}