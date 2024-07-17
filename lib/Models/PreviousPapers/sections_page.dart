import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Constants/constants_colors.dart';
import '../../Utils/Wdgets/appbar.dart';
import '../AllCources/Controller/all_courses_controller.dart';
import 'details_view.dart';

class SectionsPage extends StatefulWidget {
  final String title;
  const SectionsPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<SectionsPage> createState() => _SectionsPageState();
}

class _SectionsPageState extends State<SectionsPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCoursesController>(
      init: AllCoursesController(),
      builder: (controller) {
        return Scaffold(
          appBar: MyAppBar(
            fontSize: 13,
            backgroundColor: ColorConst.primaryColor,
            title: widget.title,
            titleColor: Colors.white,
          ),
          body: Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return courseContent(controller);
            },
          ),
        );
      },
    );
  }

  courseContent(AllCoursesController controller) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
        itemCount: controller.allCoursesDetailsData!.chapters!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(
                () => DetailsPage(
                  controller: controller,
                  index: index,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              child: Container(
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade100,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 2,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: ColorConst.primaryColor,
                      child: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        controller.allCoursesDetailsData!.chapters![index]
                            ['title'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 12,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
