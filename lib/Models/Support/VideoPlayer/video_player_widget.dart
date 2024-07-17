import '../../AllCources/Controller/all_courses_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: AllCoursesController(),
        builder: (conn) => controller.value.isInitialized
            ? Container(
                child: buildVideo(),
              )
            : const SizedBox(
                height: 200, child: Center(child: CircularProgressIndicator())),
      );

  Widget buildVideo() => buildVideoPlayer();

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}
