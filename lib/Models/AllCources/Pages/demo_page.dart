import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../LearningPage/Controller/controller.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  List data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Demo Content',
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
      ),
      body: Get.arguments.length == 0
          ? const Center(child: Text('No Demo Content Available'))
          : courseContent(),
    );
  }

  getremovedContent() {
    List newContents = [];
    for (var element in Get.arguments) {
      for (var i = 0; i < element['chapter_items'].length; i++) {
        if (checkFileType(element['chapter_items'][i]).contains("Demo")) {
          newContents.add(element);
        }
      }
    }
    return newContents;
  }

  courseContent() {
    if (getremovedContent().length == 0) {
      return const Center(child: Text('No Demo Content Available'));
    }
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
        itemCount: getremovedContent().length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final data = getremovedContent();
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: Text(
                    data[index]['title'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                contentbuilder(index, data),
              ],
            ),
          );
        },
      ),
    );
  }

  List getCOntents(int index, List data) {
    List newContents = [];
    for (var element in data[index]['chapter_items']) {
      if (checkFileType(element).contains("Demo")) {
        newContents.add(element);
      }
    }
    return newContents;
  }

  ListView contentbuilder(int index, List data) {
    List newContents = getCOntents(index, data);
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
            title: Row(
              children: [
                Text(
                  checkFileType(
                    newContents[i],
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (data['type'] == "quiz") {
                      Get.toNamed(
                        RoutesName.quizDetailsPageTwo,
                        arguments: newContents[i]['quiz']['id'],
                      );
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
                    }
                    final learningPageController =
                        Get.find<LearningPageController>();
                    learningPageController.openFile(
                      type: newContents[i]['type'],
                      url: newContents[i]['fileData']['file'],
                    );
                  },
                  child: Text(
                    getText(
                      data['type'],
                    ),
                  ),
                )
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
    }
    return "";
  }
}
