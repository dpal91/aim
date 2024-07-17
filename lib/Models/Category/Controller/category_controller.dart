import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Utils/Constants/routes.dart';
import '../Model/category_model.dart';
import '../../../Service/service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var trendingCategory = <TrendingCategory>[].obs;
  var browseCategory = <BrowseCategory>[].obs;
  String selectedVal = "Loading..";
  int selectedId = 0;

  var isLoading = true.obs;

  var isCategoryLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCategoryies();
  }

  Future getCategoryies() async {
    try {
      var data = await ApiService.get(key: "category_list");
      var res = categoryModelFromJson(data);

      if (res.statusCode == 200) {
        trendingCategory.value = res.trendingCategory;
        browseCategory.value = res.browseCategory;
        selectedVal = res.browseCategory[0].title;
        // selectedId = res.browseCategory[0].id;
        isLoading(false);
        isCategoryLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
      isCategoryLoading(false);
    }
  }

  void changeCategory(int id) async {
    isCategoryLoading(true);
    final response = await ApiService.post(
      key: 'update_category',
      body: {
        'cat_id': id.toString(),
      },
    );
    final res = jsonDecode(response);
    if (res['statusCode'] == 200) {
      GetStorage().write(RoutesName.categoryId, id);
      getCategoryies();
      isCategoryLoading(false);
      isLoading(false);
      Get.offAllNamed(RoutesName.bottomNavigation);
    } else {
      isCategoryLoading(false);
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text("Category Already Selected"),
        ),
      );
    }
  }
}
