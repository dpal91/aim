import 'dart:convert';
import 'dart:developer';

import '../Model/model.dart';
import '../../Quizes/Model/quiz_by_id_model.dart';
import '../../../Service/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPageController extends GetxController {
  var isLoading = true.obs;
  QuizeByIdModel? quizQuesAnsData;

  Future<void> getQuesAns(int id) async {
    isLoading(true);
    try {
      var data = await ApiService.get(key: "quize_question_list?quiz_id=$id");
      var res = QuizQuesAns.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        quizQuesAnsData = quizeByIdModelFromJson(data);
        update();
        isLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }

  Future<void> getSectionalQuiz(int id) async {
    isLoading(true);
    try {
      var data =
          await ApiService.get(key: "section_question_list?webinar_id=$id");
      log(data.toString());
      var res = QuizQuesAns.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        quizQuesAnsData = quizeByIdModelFromJson(data);
        update();
        isLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
