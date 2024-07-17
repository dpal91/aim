import 'dart:convert';

import '../Model/quiz_model.dart';
import '../../../Service/service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../Current Affair/current_affair_model.dart';

class QuizController extends GetxController {
  OpensQuizesModel? quizModel;

  var isLoading = true.obs;
  int total = 0;

  @override
  void onInit() async {
    getQuiz();
    getAllSections();
    super.onInit();
  }

  Future getQuiz({int page = 1, bool isReloading = false}) async {
    try {
      var data = await ApiService.get(
          key: "quizzes/opens?device_type=phone&page=$page");
      var res = opensQuizesModelFromJson(data);
      if (res.statusCode == 200) {
        if (quizModel == null || isReloading) {
          quizModel = res;
        } else {
          quizModel!.data.quizzes.data.addAll(res.data.quizzes.data);
        }
        total = res.data.quizzes.total;
        isLoading(false);
        update();
        return res;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }

  RxBool isSectionalLoading = false.obs;
  int currentPage = 1;
  int totalItems = 0;
  CurrentAffairsModel? currentAffairsModel;

  // Get Seactional Quiz
  getAllSections({
    bool isUpdate = false,
  }) async {
    isSectionalLoading(true);

    if (isUpdate) {
      currentPage++;
    }
    final response = await ApiService.post(
      key: 'previousyearpaper?page=$currentPage',
      body: {
        "type": "section_time_test",
      },
    );
    if (response != null) {
      if (isUpdate) {
        currentAffairsModel!.webinars.data!.addAll(
          currentAffairsModelFromJson(response).webinars.data!,
        );
      } else {
        currentAffairsModel = currentAffairsModelFromJson(response);
      }
      totalItems = jsonDecode(response)['totalWebinars'];
      currentPage = jsonDecode(response)['webinars']['current_page'];
    }
    isSectionalLoading(false);
  }
}
