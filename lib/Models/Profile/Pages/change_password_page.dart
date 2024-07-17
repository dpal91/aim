import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/snackbar.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  changePasswordPage() async {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.dialog(
      const Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Changing Password...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    final response = await ApiService.post(
      key: 'change_password',
      body: {
        'old_password': oldPasswordController.text,
        'new_password': newPasswordController.text,
      },
    );
    final data = jsonDecode(response.toString());
    log(data.toString());
    if (data['statusCode'] == 200) {
      Get.back();
      Get.back();
      // ignore: use_build_context_synchronously
      SnackBarService.showSnackBar(context, data['message']);
    } else if (data['statusCode'] == 400) {
      Get.back();
      // ignore: use_build_context_synchronously
      SnackBarService.showSnackBar(
          context,
          data['message'] == "Current password does not match!"
              ? "Old Password does not match!"
              : data['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Change Password',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Please enter the following details to change your password",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Old Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextField(
                controller: oldPasswordController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Old Password',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'New Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextField(
                controller: newPasswordController,
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
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Confirm Password',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                if (oldPasswordController.text.isEmpty) {
                  SnackBarService.showSnackBar(
                      context, 'Please enter old password');
                } else if (newPasswordController.text.isEmpty) {
                  SnackBarService.showSnackBar(
                      context, 'Please enter new password');
                } else if (confirmPasswordController.text.isEmpty) {
                  SnackBarService.showSnackBar(
                      context, 'Please enter confirm password');
                } else if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  SnackBarService.showSnackBar(
                      context, 'New password and confirm password not match');
                } else {
                  changePasswordPage();
                }
              },
              color: Colors.blue,
              textColor: Colors.white,
              height: 50,
              minWidth: double.infinity,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
