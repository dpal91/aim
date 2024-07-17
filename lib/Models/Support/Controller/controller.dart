import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../Service/service.dart';
import '../Model/chapter_model.dart';

class ChapterController extends GetxController {
  var isLoading = true.obs;
  ChapterData? chapterData;
  final asset = 'assets/video/samplevideo.mp4';
  VideoPlayerController? videoController;

  @override
  void onInit() {
    getChapterData(Get.arguments);
    super.onInit();
  }

  @override
  void dispose() {
    videoController!.dispose();
    super.dispose();
  }

  Future getChapterData(int id) async {
    try {
      var data = await ApiService.get(key: "demo_video_details?course_id=$id");
      var res = ChapterModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        chapterData = res.data;
        // videoController = VideoPlayerController.network(chapterData!.videoDemo!)
        videoController = VideoPlayerController.asset(asset)
          ..addListener(() => update())
          ..setLooping(true)
          ..initialize().then((value) => videoController!.pause());
        update();
        isLoading(false);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
