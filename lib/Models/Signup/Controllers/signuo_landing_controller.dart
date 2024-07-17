import 'dart:convert';
import 'dart:developer';

import '../../Account Setup/Model/otp_arguments.dart';
import '../../Account Setup/Model/otp_model.dart';
import '../../Account Setup/Model/signup_profile_model.dart';
import '../../Login/Model/otp_model.dart';
import '../Model/social_login_model.dart';
import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupLandingController extends GetxController {
  var isLoading = false.obs;
  var isConfirm = "".obs;
  String phonenumber = "";
  int selectedId = 0;

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  Future sendOtp(
    int id,
  ) async {
    isLoading(true);
    if (codeController.text.isEmpty) {
      codeController.text = "+91";
    }
    Map body = {
      "mobile": phoneNumberController.text.replaceAll("+91", ""),
      "country_code": "+91",
    };
    try {
      var data = await ApiService.post(key: "resend_otp", body: body);
      var resData = json.decode(data);
      var res = OTPModel.fromJson(resData);
      if (res.statusCode == 200) {
        Get.toNamed(
          RoutesName.otpVerificationPage,
          arguments: OTPArguments(
            phoneNumber: phonenumber,
            otp: res.data!.toString(),
            isLogin: false,
            categoryId: id,
            password: passwordController.text,
            email: emailController.text,
            fullName: fullnameController.text,
          ),
        );
        isLoading(false);
      } else {
        isLoading(false);
        SnackBarService.showSnackBar(Get.context!, res.message!);
      }
    } catch (e) {
      isLoading(false);
    }
    // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance; // Change here
    // String? token = await firebaseMessaging.getToken();
    // FirebaseAuth auth = FirebaseAuth.instance;
    // await auth.verifyPhoneNumber(
    //   phoneNumber: "+91${phoneNumberController.text}",
    //   timeout: const Duration(seconds: 0),
    //   verificationCompleted: (PhoneAuthCredential credential) async {
    //     await auth.signInWithCredential(credential);
    //     isLoading(false);
    //   },
    //   verificationFailed: (FirebaseAuthException e) {
    //     isLoading(false);
    //     log(e.message!);
    //     Get.snackbar('Oops!', 'Failed to send OTP');
    //   },
    //   codeSent: (String verificationId, int? resendToken) async {
    //     await GetStorage().write("verificationId", verificationId);
    //     await signup(id);
    //     Get.toNamed(RoutesName.otpVerificationPage, arguments: phonenumber);
    //     isLoading(false);
    //   },
    //   codeAutoRetrievalTimeout: (String verificationId) {
    //     isLoading(false);
    //   },
    // );
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
    }
  }

  Future signup(
    int id,
    String otp,
    String fullName,
    String password,
    String email,
  ) async {
    isLoading(true);
    if (codeController.text.isEmpty) {
      codeController.text = "+91";
    }
    Map body = {
      'full_name': fullName,
      'email': email,
      'password': password,
      "mobile": phoneNumberController.text.replaceAll("+91", ""),
      "category_id": id.toString(),
      "country_code": "+91",
    };
    log('this is signUp request $body');
    // GetStorage().write('userName', fullnameController.text);
    // GetStorage().write(RoutesName.categoryId, id.toString());
    try {
      var data = await ApiService.post(key: "register_user", body: body);
      var resData = jsonDecode(data);
      var res = SignupProfileModel.fromJson(resData);
      if (res.statusCode == 200) {
        GetStorage().write(RoutesName.token, res.responseData!.token);
        GetStorage().write(RoutesName.id, res.responseData!.id);
        GetStorage().write(RoutesName.categoryId,
            int.parse(res.responseData!.courseCategoryId!));
        GetStorage().write('userName', res.responseData!.fullName);
        GetStorage().write(RoutesName.isTeacher, true);
        Get.offAllNamed(RoutesName.bottomNavigation);
        isLoading(false);
      } else {
        isLoading(false);
        SnackBarService.showSnackBar(Get.context!, res.message!);
      }
    } catch (e) {
      isLoading(false);
    }
  }

  bool isSignedIn = false;

  Future<UserCredential> googleSignIn() async {
    // Trigger the authentication flow
    // if (await GoogleSignIn().isSignedIn()) {
    //   await GoogleSignIn().signOut();
    // }
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future socialLogin({required String email, required String socialId}) async {
    isLoading(true);
    Map body = {
      'email': email,
      'social_type': '1',
      "social_id": socialId,
    };
    try {
      var data = await ApiService.post(key: "social_login", body: body);
      var res = socialLoginModelFromJson(data);
      log(data.toString());
      if (res.statusCode == 200) {
        // print(data);
        GetStorage().write(RoutesName.token, res.data!.token);
        GetStorage().write(RoutesName.id, res.data!.id);
        // GetStorage().write(RoutesName.categoryId, res.data!.);
        GetStorage().write('userName', res.data!.fullName);
        Get.offAndToNamed(RoutesName.bottomNavigation);
        debugPrint(res.data.toString());
        isLoading(false);
      } else {
        isLoading(false);
        SnackBarService.showSnackBar(Get.context!, res.message);
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
    }
  }
}
