import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Service/service.dart';
import '../../../Utils/Wdgets/snackbar.dart';

class AddToFavouriteController extends GetxController {
  var isLoading = false.obs;
  bool isFav = false;

  Future addToFav(String slug) async {
    isLoading(true);
    try {
      var body = {"slug": slug};
      var data = await ApiService.post(key: "favorites/toggle", body: body);
      var res = json.decode(data);
      if (res['statusCode'] == 200) {
        // isFav = !isFav;
        if (res['message'].toString().contains("Delete successful")) {
          isFav = false;
          SnackBarService.showSnackBar(Get.context!, "Bookmarked Removed");
        } else if (res['message'].toString().contains("Create successful")) {
          isFav = true;
          SnackBarService.showSnackBar(Get.context!, "Bookmarked");
        }
        GetStorage().write("isFav$slug", isFav);
        isLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
