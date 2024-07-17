import '../../../Service/service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../Model/my_results_model.dart';

class MyResultsController extends GetxController {
  MyResultsModel? resultsModel;
  int total = 0;

  var isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await getQuiz();
  }

  Future getQuiz({int page = 1, bool isReloading = false}) async {
    try {
      var data = await ApiService.get(
          key: "quizzes/my-results?device_type=phone&page=$page");
      var res = myResultsModelFromJson(data);

      if (res.statusCode == 200) {
        if (resultsModel == null || isReloading) {
          resultsModel = res;
        } else {
          resultsModel!.data.quizzesResults.data
              .addAll(res.data.quizzesResults.data);
        }
        total = res.data.quizzesResults.total;
        isLoading(false);
        update();
        return res;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
