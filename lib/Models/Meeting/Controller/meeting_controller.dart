import 'dart:convert';
import 'dart:developer';

import '../Models/meeting_model.dart';
import '../Pages/meeting_web_view.dart';
import '../../../Service/service.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingController extends GetxController {
  var isLoading = true.obs;
  var isLoadingmeeting = false.obs;
  var meetingList = <MeetingData>[].obs;

  @override
  void onInit() {
    getMeetingData();
    super.onInit();
  }

  Future getMeetingData() async {
    try {
      var data = await ApiService.get(key: "meetings/manage_meeting");
      var res = MeetingModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        meetingList.value = res.data!;
        isLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
      update();
    }
  }

  Future getMeetingLink(int id) async {
    isLoadingmeeting(true);
    update();
    try {
      var data = await ApiService.post(
          key: "meetings/joinToBigBlueButton?id=$id", body: {});
      var res = json.decode(data);
      if (res['statusCode'] == 200) {
        Get.to(
          () => MeetingWebView(
            url: res['url'],
            allow: true,
          ),
        );
        isLoadingmeeting(false);
        update();
      } else {
        SnackBarService.showSnackBar(Get.context!, res['message']);
        isLoadingmeeting(false);
        update();
      }
      log(res.toString());
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoadingmeeting(false);
      update();
    }
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }
}
