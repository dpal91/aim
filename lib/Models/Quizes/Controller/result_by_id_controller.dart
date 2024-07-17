import 'dart:developer';
import '../Model/quiz_result_model.dart';
import '../../../Service/service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ResultByIdController extends GetxController {
  var isLoading = true.obs;

  Future getQuiz(int id) async {
    log(id.toString());
    try {
      var data = await ApiService.get(key: "quizzes/$id/result");
      log(data.toString());
      final res = resultResultModelFromJson(data);

      if (res.statusCode == 200) {
        return res.data;
      } else {
        return null;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
