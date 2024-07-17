import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../Model/quiz_by_id_model.dart';

class SectionalController extends GetxController {
  var isLoading = true.obs;
  List<Data> quizQuesAnsData = [];

  Future<bool> getSectionalQuiz(int id) async {
    isLoading(true);
    try {
      var data =
          await ApiService.get(key: "section_question_list?webinar_id=$id");
      quizQuesAnsData.clear();
      final res = jsonDecode(data);
      if (res['statusCode'] == 200) {
        for (var element in res['data']) {
          quizQuesAnsData.add(Data.fromJson(element));
        }
        update();
        isLoading(false);
        update();
        return true;
      }
      return false;
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
      return false;
    }
  }
}
