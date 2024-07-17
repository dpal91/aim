import '../Controller/all_courses_controller.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/routes.dart';
import '../../LearningPage/Controller/controller.dart';
import '../Model/all_courses_details_model.dart';
import '../Pages/text_lesson_page.dart';

class PaidOneLinerPage extends StatefulWidget {
  final String? title;
  final String slugl;
  const PaidOneLinerPage({Key? key, this.title, required this.slugl})
      : super(key: key);

  @override
  State<PaidOneLinerPage> createState() => _PaidOneLinerPageState();
}

class _PaidOneLinerPageState extends State<PaidOneLinerPage> {
  Course? course;
  final learningPageController = Get.put(LearningPageController());

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final controller = Get.put(AllCoursesController());
    final data = await controller.getDetails(widget.slugl);
    setState(() {
      course = data!.data!.course;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        titleColor: Colors.white,
        backgroundColor: ColorConst.primaryColor,
      ),
      body: GetBuilder<AllCoursesController>(
        init: AllCoursesController(),
        builder: (data) {
          return Obx(
            () => data.islinearLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : courseContent(),
          );
        },
      ),
    );
  }

  courseContent() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
        itemCount: course!.chapters!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 5,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 5,
                //     horizontal: 5,
                //   ),
                //   child: Text(
                //     course!.chapters![index]['title'],
                //     style: const TextStyle(
                //       fontSize: 15,
                //       fontWeight: FontWeight.w800,
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                contentbuilder(index),
              ],
            ),
          );
        },
      ),
    );
  }

  List getCOntents(int index) {
    List newContents = [];
    for (var element in course!.chapters![index]['chapter_items']) {
      if (checkFileType(element).contains("Demo") == false) {
        newContents.add(element);
      }
    }

    return newContents;
  }

  ListView contentbuilder(int index) {
    List newContents = getCOntents(index);

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      shrinkWrap: true,
      itemCount: newContents.length,
      itemBuilder: (BuildContext context, int i) {
        final data = newContents[i];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
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
          child: ListTile(
            onTap: () {
              if (data['type'] == "quiz") {
                Get.toNamed(
                  RoutesName.quizDetailsPageTwo,
                  arguments: newContents[i]['quiz']['id'],
                );
                return;
              }
              if (data['type'] == 'session') {
                Get.toNamed(
                  RoutesName.meetingDetailsPage,
                  arguments: {
                    'id': data['item_id'],
                    'imageCover': '',
                    'title': data['session']['title'],
                    'discription': data['session']['description'] ?? "",
                    'sessionId': data['session']
                  },
                );
                return;
              }
              if (data['type'] == 'text_lesson') {
                Get.to(
                  () => TextLessonPage(
                    description: data['text_lesson']['content'],
                    title: data['text_lesson']['title'],
                  ),
                );
                return;
              }
              final learningPageController = Get.put(
                LearningPageController(),
              );
              learningPageController.openFile(
                type: newContents[i]['type'],
                url: newContents[i]['fileData']['file'],
              );
            },
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    checkFileType(
                      newContents[i],
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      //
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
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Image.asset(
                'assets/short-note.png',
                height: 25,
              ),
            ),
          ),
        );
      },
    );
  }

  Icon getIcon(var data) {
    if (data == 'quiz') {
      return const Icon(Icons.quiz);
    }
    if (data == 'session') {
      return const Icon(Icons.school);
    }

    return const Icon(Icons.file_copy);
  }

  String getText(var data) {
    if (data == 'quiz') {
      return "Start";
    } else if (data == 'file') {
      return "View";
    } else if (data == 'session') {
      return "Join";
    }
    return "View";
  }

  String checkFileType(var data) {
    if (data['type'] == 'quiz') {
      return data['quiz']['title'];
    } else if (data['type'] == 'file') {
      return data['fileData']['title'];
    } else if (data['type'] == 'session') {
      return data['session']['title'];
    } else if (data['type'] == 'text_lesson') {
      return data['text_lesson']['title'];
    }
    return "Loading...";
  }
}
