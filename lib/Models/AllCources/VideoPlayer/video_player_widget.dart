import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import '../Controller/all_courses_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final Function(bool) onFullScreen;
  const VideoPlayerWidget({
    Key? key,
    required this.controller,
    required this.onFullScreen,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool showControls = true;

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    widget.controller.addListener(() {
      if (widget.controller.value.position ==
          widget.controller.value.duration) {
        setState(() {
          showControls = true;
        });
      }
    });
  }

  final List<double> _speeds = [0.25, 0.5, 1.0, 1.5, 2.0];
  double selected = 1.0;
  showSpeedDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Select Speed'),
        content: SizedBox(
          width: isFullScreen ? Get.width * 0.5 : Get.width * 0.8,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _speeds.length,
            itemBuilder: (context, index) => ListTile(
              leading: selected == _speeds[index]
                  ? const Icon(Icons.check)
                  : const SizedBox(),
              onTap: () {
                widget.controller.setPlaybackSpeed(_speeds[index]);
                setState(() {
                  selected = _speeds[index];
                });
                Get.back();
              },
              title: Text('${_speeds[index]}x'),
            ),
          ),
        ),
      ),
    );
  }

  Timer? _showControlstimer;

  startTimer() {
    _showControlstimer = Timer(
      const Duration(seconds: 3),
      () {
        setState(() {
          showControls = false;
        });
        _showControlstimer?.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) => GetBuilder(
        init: AllCoursesController(),
        builder: (context) {
          if (widget.controller.value.isInitialized) {
            return WillPopScope(
              onWillPop: () async {
                if (MediaQuery.of(Get.context!).orientation ==
                    Orientation.portrait) {
                  return true;
                } else {
                  await SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                      overlays: SystemUiOverlay.values);
                  widget.onFullScreen(false);
                  setState(() {
                    isFullScreen = false;
                  });
                  return false;
                }
              },
              child: isFullScreen
                  ? Container(
                      color: Colors.black,
                      height: Get.height,
                      width: Get.width,
                      child: Stack(
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  showControls = !showControls;
                                });
                                if (showControls) {
                                  startTimer();
                                } else {
                                  _showControlstimer?.cancel();
                                }
                              },
                              child: buildVideo(),
                            ),
                          ),
                          if (showControls) controls(),
                        ],
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: widget.controller.value.aspectRatio,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                showControls = !showControls;
                              });
                              if (showControls) {
                                startTimer();
                              } else {
                                _showControlstimer?.cancel();
                              }
                            },
                            child: buildVideo(),
                          ),
                          if (showControls) controls(),
                        ],
                      ),
                    ),
            );
          } else {
            return const SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );

  Widget buildVideo() => buildVideoPlayer();

  buildVideoPlayer() => AspectRatio(
        aspectRatio: widget.controller.value.aspectRatio,
        child: VideoPlayer(widget.controller),
      );

  bool isMutted = false;
  bool isFullScreen = false;

  skip10Seconds() {
    widget.controller.seekTo(
      Duration(
        seconds: widget.controller.value.position.inSeconds + 10,
      ),
    );
    _showControlstimer?.cancel();
    startTimer();
  }

  rewind10Seconds() {
    widget.controller.seekTo(
      Duration(
        seconds: widget.controller.value.position.inSeconds - 10,
      ),
    );
    _showControlstimer?.cancel();
    startTimer();
  }

  controls() {
    return InkWell(
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (MediaQuery.of(Get.context!).orientation ==
                            Orientation.portrait) {
                          Get.back();
                        } else {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown,
                          ]);
                          SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.manual,
                            overlays: SystemUiOverlay.values,
                          );
                          widget.onFullScreen(false);

                          setState(() {
                            isFullScreen = false;
                            showControls = false;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showSpeedDialog();
                      },
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        rewind10Seconds();
                      },
                      icon: const Icon(
                        Icons.replay_10,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                        _showControlstimer?.cancel();
                        showControls = true;
                        setState(() {});
                      } else {
                        widget.controller.play();
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 45,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 25,
                      onPressed: () {
                        skip10Seconds();
                      },
                      icon: const Icon(
                        Icons.forward_10,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: Get.width,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: widget.controller,
                        builder: ((context, VideoPlayerValue value, child) {
                          return ProgressBar(
                            progress: value.position,
                            total: value.duration,
                            onSeek: (duration) {
                              widget.controller.seekTo(duration);
                            },
                            timeLabelTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            timeLabelType: TimeLabelType.totalTime,
                            timeLabelLocation: TimeLabelLocation.sides,
                          );
                        }),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isMutted = !isMutted;
                          });
                          widget.controller.setVolume(isMutted ? 0 : 1);
                        },
                        icon: Icon(
                          !isMutted ? Icons.volume_up : Icons.volume_off,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {
                          if (isFullScreen) {
                            setState(() {
                              isFullScreen = false;
                            });
                            widget.onFullScreen(false);
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown,
                            ]);
                            SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.manual,
                              overlays: SystemUiOverlay.values,
                            );
                            setState(() {
                              showControls = false;
                            });
                          } else {
                            setState(() {
                              isFullScreen = true;
                            });
                            widget.onFullScreen(true);
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.landscapeLeft,
                              DeviceOrientation.landscapeRight,
                            ]);
                            SystemChrome.setEnabledSystemUIMode(
                              SystemUiMode.immersiveSticky,
                            );
                            setState(() {
                              showControls = false;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}
