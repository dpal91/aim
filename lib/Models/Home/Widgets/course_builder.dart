import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/global_data.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/dialog_login.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../AllCources/Pages/all_courses_pages_details.dart';
import '../Pages/study_material_page.dart';

Widget coursesBuilder(
  dynamic data,
  BuildContext context,
  int index, {
  bool isDemo = false,
  bool isStudy = false,
  bool istest = false,
}) {
  AllCoursesController allCoursesController = Get.find<AllCoursesController>();
  return InkWell(
    onTap: () async {
      debugPrint('LOG : ');
      if (isSkippedButtonPressed && !isDemo) {
        DialogLogin().dialog(context);
      } else {
        if (isStudy) {
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );
          await allCoursesController.getAllCourseDetails(
            data[index].slug!,
          );
          Get.back();
          Get.to(
            () => DemoStudyMaterial(
              title: data[index].title!,
            ),
          );
        } else if (istest) {
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );
          await allCoursesController.getAllCourseDetails(
            data[index].slug!,
          );
          Get.back();
          Get.toNamed(
            RoutesName.quizDetailsPageTwo,
            arguments: allCoursesController.allCoursesDetailsData!.chapters![0]
                ['chapter_items'][0]['quiz']['id'],
          );
        } else {
          allCoursesController.getAllCourseDetails(
            data[index].slug!,
          );
          Get.to(
            () => AllCoursesPageDetails(
              isDemo: isDemo,
              latestWebinars: isDemo ? data : null,
              notIncludedLatestWebinars: isDemo ? data[index] : null,
            ),
          );
        }
      }
    },
    child: Container(
      width: 160,
      // height: isDemo ? null : 205,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: 90,
            imageUrl: RoutesName.baseImageUrl + data[index].thumbnail!,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data[index].title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    data[index].price == null ? '' : '₹ ${data[index].price}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffee6c4d),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: ColorConst.primaryColor,
            height: 35,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
