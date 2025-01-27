import 'dart:developer';

// import 'package:country_picker/country_picker.dart';
import 'package:elera/Models/Signup/Controllers/signuo_landing_controller.dart';
import 'package:elera/Models/Signup/Pages/select_category_page.dart';
import 'package:elera/Utils/Constants/constans_assets.dart';
import 'package:elera/Utils/Constants/constants_colors.dart';
import 'package:elera/Utils/Wdgets/elevate_icon_button.dart';
import 'package:elera/Utils/Wdgets/elevated_button.dart';
import 'package:elera/Utils/Wdgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // SignUpPageState() {
  //   _selectedVal = courseList[1];
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  bool value = false;
  // String? _selectedVal = "JEE";
  SignupLandingController controller = Get.put(SignupLandingController());

  String countryCode = "91";
  int selectedId = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          controller.isLoading.value;
          return SingleChildScrollView(
            child: Column(children: [
              const SizedBox(height: 75),
              _body(),
              _footer(),
            ]),
          );
        }),
      ),
    );
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Image.asset(
            Images.loginFrame,
            height: 100,
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Text(
                "Create your Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            controller: controller.fullnameController,
            hintText: " Full Name",
            prefixIcon: const Icon(
              Icons.person,
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            controller: controller.emailController,
            hintText: "Email",
            prefixIcon: SvgPicture.asset(
              Images.svgEmail,
            ),
            validator: (value) {
              if (value!.isEmail == false) {
                return "Enter correct email";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: MyTextFormField(
                hintText: "+$countryCode",
                readOnly: true,
                onTap: () {
                  // (
                  //     context: context,
                  //     favorite: <String>['IN'],
                  //     showPhoneCode: true,
                  //     onSelect: (c) {
                  //       setState(() {
                  //         countryCode = c.phoneCode;
                  //         controller.codeController.text = c.phoneCode;
                  //       });
                  //     });showCountryPicker
                },
              )),
              const SizedBox(width: 5),
              Expanded(
                flex: 3,
                child: MyTextFormField(
                  controller: controller.phoneNumberController,
                  hintText: "Phone",
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            controller: controller.passwordController,
            hintText: "Password",
            obscureText: obscureText,
            prefixIcon: SvgPicture.asset(Images.svgLock),
            suffixIcon: GestureDetector(
              onTap: () => setState(() {
                obscureText = !obscureText;
              }),
              child: obscureText == false
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter a password";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          MyTextFormField(
            controller: controller.confirmPassController,
            hintText: "Confirm Password",
            obscureText: obscureText,
            prefixIcon: SvgPicture.asset(Images.svgLock),
            suffixIcon: GestureDetector(
              onTap: () => setState(() {
                obscureText = !obscureText;
              }),
              child: obscureText == false
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter a password";
              } else if (value != controller.passwordController.text) {
                return "Password doesn't match";
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 10),
          MyElevatedButton(
            isLoading: controller.isLoading.value,
            label: "Sign up",
            onPressed: () {
              if (controller.phoneNumberController.text.isEmpty ||
                  controller.phoneNumberController.text.length < 10) {
                SnackBarService.showSnackBar(
                    context, "Please Enter correct mobile number");
                return;
              } else if (_formKey.currentState!.validate()) {
                if (controller.codeController.text.isEmpty) {
                  controller.codeController.text = "91";
                }
                controller.phonenumber =
                    "+${controller.codeController.text}${controller.phoneNumberController.text}";
                Get.to(() => const SelectCategoryPage());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Column(
      children: [
        const SizedBox(height: 20),
        _divider(),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(color: ColorConst.greyTextColor),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () => Get.offAndToNamed(RoutesName.loginInPageEmail),
              child: Text(
                "Sign in",
                style: TextStyle(color: ColorConst.buttonColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // GetBuilder<SignupLandingController>(
        //   init: SignupLandingController(),
        //   initState: (_) {},
        //   builder: (controller) {
        // TODO :: will add in
        if (false)
          MyTextIconButton(
            label: "Continue with Google",
            icon: SvgPicture.asset(
              Images.svgGoogle,
              color: Colors.white,
            ),
            primary: Colors.red,
            onPressed: () async {
              final data = await controller.googleSignIn();
              log(data.user!.phoneNumber.toString());
              controller.emailController.text = data.user!.email!;
              controller.fullnameController.text = data.user!.displayName ?? "";
              controller.phoneNumberController.text =
                  data.user!.phoneNumber ?? "";
              await GoogleSignIn().signOut();
            },
          ),
        //   },
        // ),
      ],
    );
  }

  Widget _socialButtons({
    Widget? social1,
    Widget? social2,
    Widget? social3,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: social1,
        ),
        const SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: social2,
        ),
        const SizedBox(width: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: social3,
        ),
      ],
    );
  }

  Widget _divider() {
    return const Row(
      children: [
        Expanded(
            child: Divider(
          thickness: 2,
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("or"),
        ),
        Expanded(
            child: Divider(
          thickness: 2,
        )),
      ],
    );
  }
}
