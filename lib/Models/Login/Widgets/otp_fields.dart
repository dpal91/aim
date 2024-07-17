import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../ForgetPassword/Controller/forgot_password_controller.dart';

class FilledRoundedPinPut extends StatefulWidget {
  final TextEditingController controller;
  const FilledRoundedPinPut({Key? key, required this.controller})
      : super(key: key);

  @override
  State<FilledRoundedPinPut> createState() => _FilledRoundedPinPutState();
}

class _FilledRoundedPinPutState extends State<FilledRoundedPinPut> {
  ForgotPasswordController controller = ForgotPasswordController();
  // final controller = TextEditingController();
  final focusNode = FocusNode();

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   focusNode.dispose();
  //   super.dispose();
  // }

  bool showError = false;

  @override
  Widget build(BuildContext context) {
    const length = 4;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(222, 231, 240, .57);

    return SizedBox(
      height: 68,
      child: PinCodeTextField(
        appContext: context,
        length: length,
        onChanged: (value) {},
        controller: widget.controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          activeFillColor: fillColor,
          activeColor: borderColor,
          inactiveColor: borderColor,
          selectedColor: borderColor,
          selectedFillColor: fillColor,
          inactiveFillColor: fillColor,
          disabledColor: borderColor,
        ),
      ),
      // child: Pinput(
      //   androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      //   length: length,
      //   controller: widget.controller,
      //   focusNode: focusNode,
      //   defaultPinTheme: defaultPinTheme,
      //   onCompleted: (pin) {
      //     setState(() => showError = pin != '5555');
      //   },
      //   focusedPinTheme: defaultPinTheme.copyWith(
      //     height: 68,
      //     width: 64,
      //     decoration: defaultPinTheme.decoration!.copyWith(
      //       border: Border.all(color: borderColor),
      //     ),
      //   ),
      //   errorPinTheme: defaultPinTheme.copyWith(
      //     decoration: BoxDecoration(
      //       color: errorColor,
      //       borderRadius: BorderRadius.circular(8),
      //     ),
      //   ),
      // ),
    );
  }
}
