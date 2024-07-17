import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayeWidget extends StatelessWidget {
  const VideoPlayeWidget({Key? key, required this.controller})
      : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Stack(
          children: [
            Container(
              height: 200,
              alignment: Alignment.topCenter,
              child: buildVideo(),
            ),
          ],
        )
      : const SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );

  buildVideo() => buildVideoPlayer();

  buildVideoPlayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}
