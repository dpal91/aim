import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevated_button.dart';
import '../../Account%20Setup/Model/otp_arguments.dart';
import '../../Login/Controllers/phone_controller.dart';
import '../../Login/Widgets/otp_fields.dart';
import '../Controllers/signuo_landing_controller.dart';

// ignore: must_be_immutable
class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({Key? key}) : super(key: key);
  PhoneController controller = PhoneController();
  SignupLandingController signupcontroller = SignupLandingController();
  OTPArguments phone = Get.arguments;
  @override
  Widget build(BuildContext context) {
    log(phone.phoneNumber.toString() + "Phone");
    return Scaffold(
      appBar: MyAppBar(
        title: "Confirm Otp",
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(
        () {
          controller.phoneNumberController.text = phone.phoneNumber;
          signupcontroller.phoneNumberController.text = phone.phoneNumber;
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "OTP is been sent to your registered phone number, Please enter OTP to proceed",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 80),
                  FilledRoundedPinPut(controller: controller.otpController),
                  const SizedBox(height: 80),
                  MyElevatedButton(
                    isLoading: controller.isLoading.value,
                    label: "Confirm",
                    onPressed: () {
                      if (controller.otpController.text.length == 4) {
                        if (phone.isLogin) {
                          controller.verifyOtp(
                            phoneNumber: phone.phoneNumber,
                            otp: controller.otpController.text,
                          );
                        } else {
                          if (controller.otpController.text == phone.otp) {
                            signupcontroller.signup(
                              phone.categoryId!,
                              phone.otp,
                              phone.fullName.toString(),
                              phone.password.toString(),
                              phone.email.toString(),
                            );
                          }
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
