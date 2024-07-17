import '../Class/category_classes.dart';
import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget reusableHeaderButton(String title, String imgUrl) {
  return Container(
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: ColorConst.buttonColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        SvgPicture.asset(
          imgUrl,
          height: 20,
          width: 20,
          color: Colors.white,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        )
      ],
    ),
  );
}

Widget buttonTwo() {
  return Container(
    height: 40,
    width: 60,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      color: ColorConst.buttonColor,
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SvgPicture.asset(
        Images.svgMenu,
        height: 20,
        color: Colors.white,
      ),
    ),
  );
}

Widget newCourseBuilder(SecondCourseBuilder coursesCategories) {
  return Card(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.white70, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('★★★★',
                  style: TextStyle(color: Colors.yellow, fontSize: 19)),
              Text(
                coursesCategories.price,
                style: TextStyle(
                    color: ColorConst.buttonColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        Image.asset(
          Images.pngBlog,
          height: 100,
          width: 200,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 11, top: 8),
          child: Text(
            coursesCategories.subtitle,
            style: TextStyle(
                color: ColorConst.buttonColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 16,
                  ),
                  Text(
                    coursesCategories.nameOfTutor,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      coursesCategories.time,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget reusableTitleTwo(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
    ),
  );
}
