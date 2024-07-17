import '../Controller/controller.dart';
import '../VideoPlayer/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideo extends StatefulWidget {
  const FullScreenVideo({Key? key, required this.controller}) : super(key: key);
  final VideoPlayerController controller;

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo>
    with SingleTickerProviderStateMixin {
  // late VideoPlayerController controller;
  late AnimationController animatedController;
  bool isPlaying = false;
  bool visible = true;
  final asset = 'assets/video/samplevideo.mp4';
  ChapterController chapterController = Get.put(ChapterController());
  List speeds = <double>[0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  Future landscapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future reset() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    landscapeMode();
    super.initState();
    // controller = VideoPlayerController.asset(asset)
    //   ..addListener(() => setState(() {}))
    //   ..setLooping(true)
    //   ..initialize().then((value) => controller.pause());
    animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        visible = !visible;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    reset();
    // controller.dispose();
  }

  String videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(": ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: [
        buildVideoPlayer(),
        buildPlayPause(),
        buildCurrentDuration(),
        buildFullScreen(context),
        buildSpeed(),
        buildForward(),
        buildBackward(),
        videoIndecator()
      ]),
    );
  }

  Widget videoIndecator() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Row(children: [
              Expanded(
                child: VideoProgressIndicator(
                  widget.controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    backgroundColor: Colors.grey.shade300,
                    playedColor: Colors.red,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildForward() {
    return Positioned.fill(
        child: Padding(
      padding: const EdgeInsets.only(right: 70),
      child: Align(
          alignment: Alignment.centerRight,
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: IconButton(
              onPressed: !visible
                  ? () {
                      setState(() {
                        visible = !visible;
                      });
                    }
                  : () {
                      widget.controller.seekTo(
                          widget.controller.value.position +
                              const Duration(seconds: 5));
                    },
              icon: const Icon(
                Icons.fast_forward_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          )),
    ));
  }

  Widget buildBackward() {
    return Positioned.fill(
        child: Padding(
      padding: const EdgeInsets.only(left: 70),
      child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: IconButton(
              onPressed: !visible
                  ? () {
                      setState(() {
                        visible = !visible;
                      });
                    }
                  : () {
                      widget.controller.seekTo(
                          widget.controller.value.position -
                              const Duration(seconds: 5));
                    },
              icon: const Icon(
                Icons.fast_rewind_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          )),
    ));
  }

  Widget buildVideoPlayer() {
    return InkWell(
        onTap: () {
          setState(() {
            visible = !visible;
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                overlays: []);
          });
        },
        child: VideoPlayerWidget(controller: widget.controller));
  }

  Widget buildPlayPause() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.center,
        child: InkWell(
          onTap: !visible
              ? () {
                  setState(() {
                    visible = !visible;
                  });
                }
              : () {
                  setState(() {
                    isPlaying
                        ? widget.controller.pause()
                        : widget.controller.play();
                    isPlaying
                        ? animatedController.reverse()
                        : animatedController.forward();
                    isPlaying = !isPlaying;
                  });
                },
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: animatedController,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCurrentDuration() {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: ValueListenableBuilder(
                valueListenable: widget.controller,
                builder: ((context, VideoPlayerValue value, child) {
                  return Text(
                    "${videoDuration(value.position)}/${videoDuration(value.duration)}",
                    style: const TextStyle(color: Colors.white),
                  );
                })),
          ),
        ),
      ),
    );
  }

  Widget buildFullScreen(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: !visible
              ? () {
                  setState(() {
                    visible = !visible;
                  });
                }
              : () {
                  Navigator.pop(context);
                },
          child: AnimatedOpacity(
            opacity: visible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Icon(Icons.fullscreen_exit_rounded, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSpeed() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: PopupMenuButton<double>(
              icon: const Icon(Icons.settings, color: Colors.white),
              initialValue: widget.controller.value.playbackSpeed,
              onSelected: widget.controller.setPlaybackSpeed,
              itemBuilder: (context) {
                return speeds
                    .map<PopupMenuEntry<double>>((speed) =>
                        PopupMenuItem(value: speed, child: Text("${speed}x")))
                    .toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
