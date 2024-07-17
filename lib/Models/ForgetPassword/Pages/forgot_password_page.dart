import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevated_button.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import '../../../Utils/Wdgets/textfield.dart';
import '../Controller/forgot_password_controller.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  String countryCode = "91";
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Forgot Password',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: Obx(() {
        var isLoading = controller.isLoading.value;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Image.asset(Images.pngForgotPass),
                const SizedBox(height: 40),
                const Text(
                  'Select which contact details should we use to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                // reusableListTile('via SMS:', '91829128', Icons.sms, isSMS),
                // reusableListTile('via Email:', 'angeley@yourdomail.com',
                //     Icons.forward_to_inbox_outlined, isEmail),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                        child: MyTextFormField(
                      hintText: "+$countryCode",
                      readOnly: true,
                      onTap: () {},
                    )),
                    const SizedBox(width: 5),
                    Expanded(
                      flex: 3,
                      child: MyTextFormField(
                        controller: controller.phoneNumberController,
                        hintText: "Phone",
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                MyElevatedButton(
                  isLoading: controller.isLoading.value,
                  label: "Send OTP",
                  onPressed: () {
                    if (controller.phoneNumberController.text.isEmpty ||
                        controller.phoneNumberController.text.length < 10) {
                      SnackBarService.showSnackBar(
                          context, "Please Entre correct mobile number");
                    } else {
                      if (controller.codeController.text.isEmpty) {
                        controller.codeController.text = "91";
                      }
                      controller.phonenumber =
                          "+${controller.codeController.text}${controller.phoneNumberController.text}";
                      controller.sendOtp();
                      // res.then((value) {
                      //   if (value['statusCode'] == 200) {
                      //     Get.toNamed(RoutesName.forgotPasswordOTPScreen,
                      //         arguments: controller.phonenumber);
                      //   }
                      // });
                    }
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget reusableListTile(
      String title, String subtitle, IconData iconData, bool isChecked) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isChecked ? ColorConst.buttonColor : Colors.transparent,
              width: 2)),
      child: ListTile(
        leading: CircleAvatar(
            radius: 35,
            backgroundColor: Colors.black12,
            child: Icon(
              iconData,
              color: ColorConst.buttonColor,
            )),
        title: Text(
          title,
          style: TextStyle(
              color: ColorConst.buttonColor,
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
