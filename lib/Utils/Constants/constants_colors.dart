import 'package:flutter/material.dart';

class ColorConst {
  static Color border = const Color(0xFFEEEEEE);
  // static Color primaryColor = const Color(0xFF1564C0);
  // static Color buttonColor = const Color(0xFF1564C0);
  static Color primaryColor = const Color(0xFF0F75BC);
  static Color buttonColor = const Color(0xFF0F75BC);
  static Color greyTextColor = const Color(0xFF9E9E9E);
  static Color errorColor = Colors.red;
  static Color greenColor = const Color(0xff4CBB17);
  static Color scafoldColor = Colors.grey[200]!.withOpacity(.5);
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
