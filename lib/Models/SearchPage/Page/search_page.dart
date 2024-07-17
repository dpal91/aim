import 'dart:developer';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';

import '../../../Utils/Wdgets/textfield.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../AllCources/Pages/all_courses_pages_details.dart';
import '../../Home/Pages/study_material_page.dart';
import '../Controller/search_page_controller.dart';
import '../Models/search_model_class.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final SearchController controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConst.scafoldColor,
      appBar: MyAppBar(
        backgroundColor: ColorConst.primaryColor,
        title: 'Search',
        titleColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 10.0, right: 10.0, bottom: 8, top: 10),
            child: SizedBox(
              height: 50,
              child: MyTextFormField(
                hintText: "Search",
                onTextChange: (String? value) {
                  controller.getSearchData(value);
                  return null;
                },
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 4),
                  child: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Obx(() {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.searchList.isEmpty
                    ? const Center(
                        child: Text('No Data Found'),
                      )
                    : crashCoursesTwo(controller.searchList);
          }),
        ],
      ),
    );
  }

  Widget crashCoursesTwo(List<Data> data) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (BuildContext context, index) {
          return InkWell(
            onTap: () async {
              final coursecontroller = Get.find<AllCoursesController>();
              log(controller.searchList[index].type!);
              if (controller.searchList[index].type == "webinar" ||
                  controller.searchList[index].type == "course") {
                coursecontroller.getAllCourseDetails(
                  controller.searchList[index].slug!,
                );
                Get.to(
                  () => AllCoursesPageDetails(
                    isDemo: (controller.searchList[index].price == null ||
                            controller.searchList[index].price == 0)
                        ? true
                        : false,
                  ),
                );
              }
              if (controller.searchList[index].type == "study" &&
                  (data[index].price != null || data[index].price != 0)) {
                coursecontroller.getAllCourseDetails(
                  controller.searchList[index].slug!,
                );
                Get.to(
                  () => AllCoursesPageDetails(
                    isDemo: (controller.searchList[index].price == null ||
                            controller.searchList[index].price == 0)
                        ? true
                        : false,
                  ),
                );
              }
              if (controller.searchList[index].type == "study" &&
                  (data[index].price == null || data[index].price == 0)) {
                Get.dialog(
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  barrierDismissible: false,
                );
                await coursecontroller.getAllCourseDetails(
                  data[index].slug!,
                );
                Get.back();
                Get.to(
                  () => DemoStudyMaterial(
                    title: data[index].title!,
                  ),
                );
              }
            },
            child: Container(
              height: Get.height * 0.13,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.38,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        RoutesName.baseImageUrl +
                            controller.searchList[index].thumbnail!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            data[index].title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.searchList[index].price == null
                                  ? "Free"
                                  : "₹ ${controller.searchList[index].price}",
                              style: TextStyle(
                                  color:
                                      controller.searchList[index].price == null
                                          ? Colors.red
                                          : Colors.green,
                                  fontSize: 17),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorConst.primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Center(
                                child: Text(
                                  "View",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
