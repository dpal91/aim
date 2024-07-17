import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import '../../AllCources/Model/all_courses_details_model.dart';
import '../../VideoPlayer/my_video_player_widget.dart';
import '../Widgets/file_view.dart';

class LearningPageController extends GetxController {
  var isLoading = true.obs;
  Course? allCoursesDetailsData;

  @override
  void onInit() async {
    Get.arguments != null ? await getAllCourseDetails(Get.arguments) : null;
    super.onInit();
  }

  Future getAllCourseDetails(String slug) async {
    isLoading(true);
    try {
      var data = await ApiService.get(key: "course_detail?slug=$slug");
      var res = AllCoursesDetailsModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        allCoursesDetailsData = res.data!.course;
        isLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }

  closeFunction() {
    isLoading.value = false;
  }

  Future<void> openFile({required String type, required String url}) async {
    if (url.contains(".jpg") ||
        url.contains(".png") ||
        url.contains('.jpeg') ||
        url.contains('.pdf') ||
        url.contains('.pptx') ||
        url.contains('.xlsx')) {
      final String baseUrl =
          RoutesName.baseImageUrl + url.replaceAll(' ', '%20');

      Get.to(() => FileView(url: baseUrl));
    } else {
      Get.to(() => MyVideoPlayerWidget(videoUrl: url));
    }
  }
}
