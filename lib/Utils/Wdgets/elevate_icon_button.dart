import '../Constants/constants_colors.dart';
import 'package:flutter/material.dart';

class MyTextIconButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final Color? primary;
  final void Function()? onPressed;
  const MyTextIconButton({
    Key? key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.primary = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TextButton.icon(
              onPressed: onPressed,
              icon: icon,
              label: Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: TextButton.styleFrom(
                  elevation: 0,
                  side: BorderSide(color: ColorConst.border),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // primary: Colors.red,
                  backgroundColor: primary),
            ),
          ),
        ),
      ],
    );
  }
}

Widget MySolidButton(String text) {
  return Container(
      color: ColorConst.buttonColor,
      height: 40,
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ));
}

Widget MySolidButtontwo(String text) {
  return Container(
      color: ColorConst.buttonColor,
      padding: const EdgeInsets.all(5),
      child: Center(
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ));
}

Widget MyRoundedButton(String text) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: ColorConst.buttonColor,
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget MyRoundedButtonTwo(String text) {
  return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: ColorConst.buttonColor,
          borderRadius: BorderRadius.circular(5)),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
}
