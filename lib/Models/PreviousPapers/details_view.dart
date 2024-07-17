import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Constants/constants_colors.dart';
import '../../Utils/Constants/routes.dart';
import '../../Utils/Wdgets/appbar.dart';
import '../AllCources/Controller/all_courses_controller.dart';
import '../AllCources/Pages/text_lesson_page.dart';
import '../LearningPage/Controller/controller.dart';

class DetailsPage extends StatefulWidget {
  final AllCoursesController controller;
  final int index;
  const DetailsPage({Key? key, required this.controller, required this.index})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.controller.allCoursesDetailsData!.title!,
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
        fontSize: 13,
      ),
      body: contentbuilder(widget.index, widget.controller),
    );
  }

  List getCOntents(int index, AllCoursesController controller) {
    List newContents = [];
    for (var element in controller.allCoursesDetailsData!.chapters![index]
        ['chapter_items']) {
      newContents.add(element);
    }
    return newContents;
  }

  ListView contentbuilder(int index, AllCoursesController controller) {
    List newContents = getCOntents(index, controller);

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
              child: Text(
                (i + 1).toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
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
    return "";
  }

  String getText(var data) {
    if (data == 'quiz') {
      return "Attempt";
    } else if (data == 'file') {
      return "View";
    } else if (data == 'session') {
      return "Join";
    }
    return "View";
  }
}
