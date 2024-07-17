import 'dart:convert';

import '../Model/forgot_password_sucess.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Account Setup/Model/forgot_password.dart';
import '../../Account Setup/Model/otp_arguments.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  String phonenumber = "";

  var isPasswordVisible = false.obs;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void updatePasswordVisibilty(bool status) {
    isPasswordVisible.value = status;
  }

  Future sendOtp() async {
    isLoading(true);
    Map body = {
      "mobile": phonenumber.replaceAll("+91", ""),
      "country_code": "+91",
    };
    try {
      var data = await ApiService.post(key: "forgotpassword", body: body);
      var res = json.decode(data);
      var resData = ForgotPassword.fromJson(res);
      if (resData.statusCode == 200) {
        Get.toNamed(
          RoutesName.forgotPasswordOTPScreen,
          arguments: OTPArguments(
            phoneNumber: phonenumber,
            otp: resData.data!.mobileOtp.toString(),
            isLogin: false,
          ),
        );
        isLoading(false);
        return res;
      } else {
        isLoading(false);
        SnackBarService.showSnackBar(Get.context!, res.message!);
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
    }
  }

  Future verifyOTP() async {
    isLoading(true);
    Map body = {
      "otp": otpController.text,
      "password": passwordController.text,
    };
    try {
      var data = await ApiService.post(key: "set_new_password", body: body);
      var res = json.decode(data);
      var resData = ForgotPasswordSuccess.fromJson(res);
      if (resData.statusCode == 200) {
        SnackBarService.showSnackBar(
          Get.context!,
          "Your Password has been updated. Please Login with Your Email and Updated Password or you can login with your Mobile Number",
        );
        Get.toNamed(RoutesName.loginInPageEmail);
        isLoading(false);
        return res;
      } else {
        isLoading(false);
        SnackBarService.showSnackBar(Get.context!, res.message!);
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
    }
  }

  // Future
}
