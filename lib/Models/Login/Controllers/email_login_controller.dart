import 'dart:convert';
import 'dart:developer';

import '../Model/otp_model.dart';
import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EmailLoginController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future emailLogin({String? email, String? password}) async {
    Map body = {
      "email": email?.trim() ?? emailController.text.trim(),
      'password': password?.trim() ?? passwordController.text.trim(),
    };
    try {
      isLoading(true);
      var data = await ApiService.post(key: "Signin", body: body);
      log(data.toString());
      var res = ProfileModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        log(res.data!.toJson().toString());
        box.write("userName", res.data!.fullName);
        box.write("userImage", res.data!.profileImage);
        box.write(RoutesName.token, res.data!.token);
        box.write(RoutesName.id, res.data!.id);
        box.write(RoutesName.categoryId, res.data!.courseCategoryId);
        SnackBarService.showSnackBar(Get.context!, res.message!);
        Get.offAllNamed(RoutesName.bottomNavigation);
        isLoading(false);
        // update();
      } else {
        isLoading(false);
        SnackBarService.showSnackBar(Get.context!, res.message!);
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
    }
  }
}
