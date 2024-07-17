import 'dart:convert';

import '../Model/category_details_model.dart';
import '../../../Service/service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CategoryDetailsController extends GetxController {
  var isLoading = true.obs;
  var categoryDetails = <WebninarData>[].obs;
  // int? subCategoryId;

  @override
  void onInit() async {
    if (Get.arguments.length > 2) {
      await getCategoryiesDetails(
          id: int.parse("${Get.arguments[0]}"),
          subId: int.parse("${Get.arguments[2]}"));
    } else {
      await getCategoryiesDetails(id: int.parse("${Get.arguments[0]}"));
    }

    //await getCategoryiesDetails(int.parse("${Get.arguments[0]}"), int.parse("${Get.arguments[2]}"));
    // subCategoryId = Get.arguments[2];
    super.onInit();
  }

  Future getCategoryiesDetails({required int id, int? subId}) async {
    try {
      var data = await ApiService.get(
          key: subId == null
              ? "course_category_wise?category_id=$id"
              : "course_category_wise?category_id=$id&sub_category_id=$subId");
      var res = CategoryDetailsModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        categoryDetails.value = res.data!.webinars!.data!;
        isLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
