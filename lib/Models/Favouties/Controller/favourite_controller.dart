import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../Model/favourite_model.dart';

class FavouriteController extends GetxController {
  var favouriteList = <FavouriteData>[].obs;
  var isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    getFavouriteList();
  }

  Future<void> getFavouriteList() async {
    try {
      isLoading(true);
      var data = await ApiService.get(key: "favorites/toggle_list");
      var res = favouriteModelFromJson(data);

      if (res.statusCode == 200) {
        favouriteList.assignAll(res.data);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
