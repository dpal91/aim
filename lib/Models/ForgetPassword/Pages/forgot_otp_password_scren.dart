import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevated_button.dart';
import '../../Account Setup/Model/otp_arguments.dart';
import '../../Login/Widgets/otp_fields.dart';
import '../Controller/forgot_password_controller.dart';

class ForgotPasswordOTPVerificationPage extends StatefulWidget {
  const ForgotPasswordOTPVerificationPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordOTPVerificationPage> createState() =>
      _ForgotPasswordOTPVerificationPageState();
}

class _ForgotPasswordOTPVerificationPageState
    extends State<ForgotPasswordOTPVerificationPage> {
  ForgotPasswordController controller = ForgotPasswordController();
  OTPArguments phone = Get.arguments;

  updateVisibilty() {
    controller.otpController.addListener(() {
      if (controller.otpController.text.length == 4) {
        controller.updatePasswordVisibilty(true);
      } else {
        controller.updatePasswordVisibilty(false);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    updateVisibilty();
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
          // signupcontroller.phoneNumberController.text = phone.phoneNumber;
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
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Obx(
                    () => controller.isPasswordVisible.value
                        ? Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: TextField(
                              controller: controller.passwordController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter New Password',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 15,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 40),
                  MyElevatedButton(
                    isLoading: controller.isLoading.value,
                    label: "Confirm",
                    onPressed: () {
                      if (controller.otpController.text.length == 4 &&
                          controller.passwordController.text.isNotEmpty) {
                        controller.verifyOTP();
                        // controller.verifyOtp(
                        //   phoneNumber: phone.phoneNumber,
                        //   otp: controller.otpController.text,
                        // );
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
