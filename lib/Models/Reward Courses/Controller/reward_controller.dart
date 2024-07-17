import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../../Reward%20Courses/Model/reward_model.dart';

class RewardController extends GetxController {
  var isLoading = true.obs;
  var rewardDetails = <RewardWebinarsData>[].obs;

  @override
  void onInit() async {
    await getRewards();
    super.onInit();
  }

  Future getRewards() async {
    try {
      var data = await ApiService.get(key: "reward-courses");
      var res = RewardModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        rewardDetails.value = res.data!.webinars!.data!;
        isLoading(false);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
