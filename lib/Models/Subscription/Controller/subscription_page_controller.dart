import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../Model/subscription_model.dart';

class SubscriptionPageController extends GetxController {
  SubscriptionModelData? subscribes;
  var isLoading = true.obs;
  @override
  void onInit() async {
    await getSubscriptionData();
    super.onInit();
  }

  Future<void> getSubscriptionData() async {
    try {
      var data = await ApiService.get(key: 'subscribes');
      var res = SubscriptionModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        subscribes = res.data;
        isLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
