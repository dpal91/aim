import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import '../Model/notification_model.dart';

class NotificationController extends GetxController {
  var isLoading = true.obs;
  var notificationdata = <NotificationData>[].obs;
  @override
  void onInit() {
    // TODO: implement
    getNotificationData();
    super.onInit();
  }

  Future getNotificationData() async {
    isLoading(true);
    var id = await GetStorage().read(RoutesName.id);

    try {
      var data = await ApiService.get(
          key: 'notifications?user_id=$id&notification_type=phone');
      var res = NotificationModel.fromJson(json.decode(data));

      if (res.statusCode == 200) {
        notificationdata.value = res.data!.notifications!.data!;
        isLoading(false);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
