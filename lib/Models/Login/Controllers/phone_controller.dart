import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import '../../Account%20Setup/Model/otp_arguments.dart';
import '../../Account%20Setup/Model/otp_model.dart';
import '../Model/otp_model.dart';

class PhoneController extends GetxController {
  var isLoading = false.obs;
  var otp = false.obs;
  var verificationCode = "".obs;
  String phonenumber = "";
  String verificationId = '';

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  String verify = "";

  Future sendOtp() async {
    isLoading(true);
    if (codeController.text.isEmpty) {
      codeController.text = "+91";
    }
    sendNewOTP();

    // FirebaseAuth auth = FirebaseAuth.instance;
    // await auth.verifyPhoneNumber(
    //   phoneNumber: phonenumber,
    //   verificationCompleted: (PhoneAuthCredential credential) async {},
    //   verificationFailed: (FirebaseAuthException e) {
    //     SnackBarService.showSnackBar(Get.context!, e.message!);
    //     print(e.message);
    //     isLoading(false);
    //   },
    //   codeSent: (String verificationId, int? resendToken) async {
    //     this.verificationId = verificationId;
    //     GetStorage().write("verificationId", verificationId);
    //     update();
    //     isLoading(false);

    //     // await GetStorage().write("verificationId", verificationId);
    //     Get.toNamed(RoutesName.otpVerificationPage, arguments: phonenumber);
    //   },
    //   timeout: const Duration(seconds: 0),
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     isLoading(false);
    //   },
    // );
  }

  // void verifyFirebaseOtp(
  //   String smsCode,
  // ) async {
  //   isLoading(true);

  //   try {
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: GetStorage().read('verificationId'),
  //       smsCode: otpController.text,
  //     );
  //     var card = await FirebaseAuth.instance.signInWithCredential(credential);

  //     if (card.user != null) {
  //       verifyOtp();
  //     } else {
  //       SnackBarService.showSnackBar(Get.context!, "Something went wrong");
  //       isLoading(false);
  //     }

  //     //verifyOtp();
  //   } on FirebaseAuthException catch (e) {
  //     SnackBarService.showSnackBar(Get.context!, "${e.message}");
  //     isLoading(false);
  //   } catch (e) {
  //     SnackBarService.showSnackBar(Get.context!, "Something went wrong $e");
  //     isLoading(false);
  //   }
  // }

  void sendNewOTP() async {
    isLoading(true);
    // if (codeController.text.isEmpty) {
    //   codeController.text = "91";
    // }
    Map body = {
      "mobile": phoneNumberController.text,
      "country_code": "+91",
    };
    try {
      var data = await ApiService.post(key: "resend_otp", body: body);
      debugPrint(data.toString());
      var resData = json.decode(data);
      log(resData.toString());
      var res = OTPModel.fromJson(resData);
      if (res.statusCode == 200) {
        log(res.data.toString());
        Get.toNamed(
          RoutesName.otpVerificationPage,
          arguments: OTPArguments(
            phoneNumber: phonenumber,
            otp: res.data!.toString(),
            isLogin: true,
          ),
        );
        isLoading(false);
      } else {
        isLoading(false);
        SnackBarService.showSnackBar(Get.context!, res.message!);
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
    }
  }

  void verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    isLoading(true);
    Map body = {
      "mobile": phoneNumber.replaceAll("+91", ""),
      "otp": otp,
      "country_code": "+91",
    };
    try {
      var data = await ApiService.post(key: "verify_otp", body: body);
      debugPrint(data.toString());
      var resData = json.decode(data);
      var res = ProfileModel.fromJson(resData);
      if (res.statusCode == 200) {
        GetStorage().write(RoutesName.token, res.data!.token);
        GetStorage().write(RoutesName.id, res.data!.id);
        GetStorage().write(RoutesName.categoryId, res.data!.courseCategoryId);
        GetStorage().write('userName', res.data!.fullName);
        GetStorage().write(RoutesName.isTeacher, true);
        Get.offAllNamed(RoutesName.bottomNavigation);
        isLoading(false);
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
