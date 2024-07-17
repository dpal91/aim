import '../Constants/constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/phone_number.dart';

class MyTextFormField extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;
  final int? maxLines;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final bool enable;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(PhoneNumber)? countryCodePickerValue;
  final String? Function(String?)? validator;
  final String? Function(String?)? onTextChange;
  const MyTextFormField({
    Key? key,
    this.prefixIcon,
    this.inputFormatters,
    this.maxLines,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.enable = true,
    this.initialValue,
    this.controller,
    this.onTextChange,
    this.keyboardType,
    this.countryCodePickerValue,
    this.validator,
  }) : super(key: key);

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool focus = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          focus = hasFocus;
        });
      },
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        controller: widget.controller,
        onTap: widget.onTap,
        readOnly: widget.readOnly!,
        initialValue: widget.initialValue,
        enabled: widget.enable,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        onChanged: widget.onTextChange,
        decoration: InputDecoration(
          isDense: true,
          fillColor: focus
              ? const Color(0xFF335EF7).withOpacity(0.2)
              : Colors.grey.shade100,
          filled: true,
          border: InputBorder.none,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorConst.buttonColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorConst.errorColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: ColorConst.errorColor)),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: widget.prefixIcon,
          ),
          prefixIconConstraints: const BoxConstraints(minHeight: 5),
          suffixIcon: widget.suffixIcon,
        ),
        obscureText: widget.obscureText,
      ),
    );
  }
}
