import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../Service/service.dart';

class SubmitQuizController extends GetxController {
  var isLoading = true.obs;

  Future<bool> submitquiz(
      int quizid, int nquizid, List<Map<String, dynamic>> result, int attempt,
      {int? courseId}) async {
    var qdata = {};
    for (var i = 0; i < result.length; i++) {
      if (result[i]["selectedAnswer"] != null) {
        qdata.addIf(
            result[i]["selectedAnswer"] != null,
            result[i]['question'].toString(),
            {"answer": result[i]["selectedAnswer"]});
      }
    }
    try {
      log("data: $qdata");
      var bodydata = {
        "device_type": "android",
        "attempt_number": (attempt).toString(),
        "question": qdata,
        "quiz_result_id": nquizid.toString(),
        "course_id": courseId.toString(),
      };
      log("Submit:---> $bodydata");
      final response = await http.post(
        Uri.parse("${ApiService.baseUrl}quizzes/$quizid/store-result"),
        body: jsonEncode(bodydata),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('token')}',
        },
      );
      log("Submit:---> ${response.reasonPhrase}");
      return true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
      return false;
    }
  }
}
