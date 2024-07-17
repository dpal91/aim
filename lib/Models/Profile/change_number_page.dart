import 'dart:convert';

import '../../Utils/Wdgets/appbar.dart';
import '../../Utils/Wdgets/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Service/service.dart';
import '../../Utils/Constants/routes.dart';

class ChangeNumberPage extends StatefulWidget {
  final Map<String, dynamic> profileDetails;
  const ChangeNumberPage({Key? key, required this.profileDetails})
      : super(key: key);

  @override
  State<ChangeNumberPage> createState() => _ChangeNumberPageState();
}

class _ChangeNumberPageState extends State<ChangeNumberPage> {
  bool isCodeSent = false;
  final _phoneController = TextEditingController();
  String phone = '';

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.profileDetails['mobile'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Change Number',
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                text: 'Current Number: ',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text: widget.profileDetails['mobile'],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Please enter your new mobile number to receive OTP',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Mobile Number',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (isCodeSent)
              const Row(
                children: [
                  SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Auto-detecting OTP. Please wait...',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_phoneController.text.isEmpty) {
                  SnackBarService.showSnackBar(context, 'Please enter number');
                  return;
                }
                if (_phoneController.text.length != 10) {
                  SnackBarService.showSnackBar(
                    context,
                    'Please enter a valid number',
                  );
                  return;
                }
                if (_phoneController.text == widget.profileDetails['mobile']) {
                  SnackBarService.showSnackBar(
                    context,
                    'Old and new number are same',
                  );
                  return;
                }
                FocusManager.instance.primaryFocus?.unfocus();
                showSureDialog();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(Get.width, 50),
              ),
              child: const Text('Change Number'),
            ),
          ],
        ),
      ),
    );
  }

  sendOtp() async {
    Get.dialog(
      const Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 5,
              ),
              Text(
                'Sending OTP...',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${_phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          final user =
              await FirebaseAuth.instance.signInWithCredential(credential);
          if (user.user != null) {
            changeNumber();
          }
        } on FirebaseAuthException catch (e) {
          SnackBarService.showSnackBar(
            context,
            e.message.toString(),
          );
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        SnackBarService.showSnackBar(
          context,
          e.message.toString(),
        );
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        setState(() {
          phone = _phoneController.text;
          isCodeSent = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        SnackBarService.showSnackBar(
          context,
          'Failed to send OTP. Please try again',
        );
      },
      timeout: const Duration(seconds: 60),
    );
  }

  changeNumber() async {
    Get.dialog(
      const Material(
        color: Colors.transparent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 5,
              ),
              Text(
                'Updating...',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    final response = await ApiService.post(
      key: 'update_profile',
      body: {
        "phone_no": phone,
      },
    );
    final data = jsonDecode(response.toString());
    if (data['statusCode'] == 200) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      Get.offAllNamed(RoutesName.bottomNavigation);
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }

  showSureDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'Are you sure you want to change your mobile number?\n\nMake sure the new number is in this Device.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              sendOtp();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
