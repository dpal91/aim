import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../Models/search_model_class.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  // Data? data;

  var searchList = <Data>[].obs;

  Future getSearchData(String? searchKey) async {
    if (searchKey != null) {
      isLoading(true);
      try {
        var data = await ApiService.get(key: 'search?search_key=$searchKey');
        var res = SearchModelClass.fromJson(json.decode(data));
        if (res.statusCode == 200) {
          searchList.value = res.data!;
          isLoading(false);
          update();
        }
      } on Exception catch (e) {
        debugPrint(e.toString());
        isLoading(false);
      }
    } else {
      searchList.clear();
    }
  }
}
