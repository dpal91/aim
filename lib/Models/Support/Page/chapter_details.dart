import '../Controller/controller.dart';
import 'full_screen_video.dart';
import '../VideoPlayer/video_player_widget.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../Utils/Wdgets/elevated_button.dart';
import '../../../Utils/Wdgets/other.dart';

class ChapterDetails extends StatefulWidget {
  const ChapterDetails({Key? key}) : super(key: key);

  @override
  State<ChapterDetails> createState() => _ChapterDetailsState();
}

class _ChapterDetailsState extends State<ChapterDetails>
    with SingleTickerProviderStateMixin {
  // late VideoPlayerController controller;
  late AnimationController animatedController;
  bool isPlaying = false;
  bool visible = true;
  final asset = 'assets/video/samplevideo.mp4';
  ChapterController controller = Get.put(ChapterController());
  List speeds = <double>[0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];

  @override
  void initState() {
    super.initState();
    // controller =
    //     VideoPlayerController.network(chapterController.chapterData!.videoDemo!)
    //       ..addListener(() => setState(() {}))
    //       ..setLooping(true)
    //       ..initialize().then((value) => controller.pause());
    animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
      appBar: const MyAppBar(title: 'Chapter Details'),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(controller.chapterData!.title!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 17)),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'New Learning Page',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.black54),
                          ),
                        ),
                        if (controller.videoController!.value.isInitialized)
                          Stack(children: [
                            buildVideoPlayer(),
                            buildPlayPause(),
                            buildCurrentDuration(),
                            buildFullScreen(context),
                            buildSpeed(),
                            buildForward(),
                            buildBackward(),
                          ]),
                        videoIndecator(),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                reusableRowWidget('Type', 'MP4',
                                    Icons.document_scanner, Colors.green),
                                const SizedBox(height: 10),
                                reusableRowWidget(
                                    'Publish Date',
                                    '01 Mar 2022',
                                    Icons.calendar_month_outlined,
                                    Colors.green),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                reusableRowWidget(
                                    'Volume',
                                    '3.95 MB',
                                    Icons.sim_card_download_sharp,
                                    Colors.green),
                                const SizedBox(height: 10),
                                reusableRowWidget('Downloadable', 'No',
                                    Icons.sim_card_download_sharp, Colors.green)
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     reusableRowWidget(
                        //         'Volume', '3.95 MB', Icons.sim_card_download_sharp),
                        //     const SizedBox(width: 10),
                        //     reusableRowWidget(
                        //         'Downloadable', 'No', Icons.sim_card_download_sharp)
                        //   ],
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(controller.chapterData!.seoDescription ?? "",
                            style: const TextStyle(
                                fontSize: 11, color: Colors.black54)),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('I have read this lesson',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black54)),
                            Icon(
                              Icons.toggle_off_outlined,
                              size: 30,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              );
      }),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
        child: MyElevatedButton(
          label: isPlaying ? "Pause" : 'Play',
          onPressed: () {
            setState(() {
              isPlaying
                  ? controller.videoController!.pause()
                  : controller.videoController!.play();
              isPlaying
                  ? animatedController.reverse()
                  : animatedController.forward();
              isPlaying = !isPlaying;
              visible = !visible;
            });
          },
        ),
      ),
    );
  }

  Widget videoIndecator() {
    return Row(children: [
      Expanded(
        flex: 5,
        child: VideoProgressIndicator(
          controller.videoController!,
          allowScrubbing: true,
          colors: VideoProgressColors(
            backgroundColor: Colors.grey.shade300,
            playedColor: Colors.red,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    ]);
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
                      controller.videoController!.seekTo(
                          controller.videoController!.value.position +
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
                      controller.videoController!.seekTo(
                          controller.videoController!.value.position -
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
          });
        },
        child: VideoPlayerWidget(controller: controller.videoController!));
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
                        ? controller.videoController!.pause()
                        : controller.videoController!.play();
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
          child: ValueListenableBuilder(
              valueListenable: controller.videoController!,
              builder: ((context, VideoPlayerValue value, child) {
                return Text(
                  "${videoDuration(value.position)}/${videoDuration(value.duration)}",
                  style: const TextStyle(color: Colors.white),
                );
              })),
        ),
      ),
    );
  }

  Widget buildFullScreen(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomRight,
        child: InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FullScreenVideo(
                      controller: controller.videoController!))),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Icon(Icons.fullscreen, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget buildSpeed() {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.topRight,
        child: PopupMenuButton<double>(
          icon: const Icon(Icons.settings, color: Colors.white),
          initialValue: controller.videoController!.value.playbackSpeed,
          onSelected: controller.videoController!.setPlaybackSpeed,
          itemBuilder: (context) {
            return speeds
                .map<PopupMenuEntry<double>>((speed) =>
                    PopupMenuItem(value: speed, child: Text("${speed}x")))
                .toList();
          },
        ),
      ),
    );
  }
}
