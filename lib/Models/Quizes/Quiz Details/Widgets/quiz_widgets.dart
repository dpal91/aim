import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../Utils/Constants/constants_colors.dart';

Widget reusableFooterButton(String title, String imgUrl) {
  return Container(
    height: 40,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    color: ColorConst.buttonColor,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SvgPicture.asset(
            imgUrl,
            height: 20,
            width: 20,
            color: Colors.white,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          )
        ],
      ),
    ),
  );
}
