import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../AllCources/Model/all_courses_details_model.dart';
import '../../AllCources/Pages/text_lesson_page.dart';
import '../../Support/Class/classes.dart';
import '../../Support/Class/lists.dart';
import '../Controller/controller.dart';

class LearningPage extends StatefulWidget {
  final Course? course;
  final bool hasBought;
  const LearningPage({Key? key, required this.course, required this.hasBought})
      : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  Course? course;
  final learningPageController = Get.put(LearningPageController());

  @override
  void initState() {
    super.initState();
    setState(() {
      course = widget.course;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: course?.title ?? "",
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
      ),
      body: courseContent(),
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: Text(
                    course!.chapters![index]['title'],
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
              if (data['type'] == "text_lesson") {
                Get.to(
                  () => TextLessonPage(
                    title: data['text_lesson']['title'],
                    description: data['text_lesson']['content'],
                  ),
                );
                return;
              }
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
                if (widget.hasBought)
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: ColorConst.primaryColor,
                    child: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                  )
                else
                  const Icon(Icons.lock)
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

  Widget reusableTabOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, index) {
          return ExpansionPanelList.radio(
            children: [
              ...expandedTile
                  .map((tile) => ExpansionPanelRadio(
                      value: tile.title,
                      headerBuilder: (context, isExpanded) =>
                          buildAdvanceTile(tile),
                      body: InkWell(
                        onTap: () {
                          Get.toNamed(RoutesName.chapterDetails,
                              arguments: Get.arguments);
                        },
                        child: Column(
                          children: [
                            ...tile.tiles.map(buildAdvanceTile).toList(),
                          ],
                        ),
                      )))
                  .toList(),
            ],
          );
        },
      ),
    );
  }

  Widget reusableTabTwo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (BuildContext context, index) {
          return reusableCard(Images.pngSecurity);
        },
      ),
    );
  }

  Widget reusableCard(String imgUrl) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        color: Colors.grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 10, bottom: 10),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: ColorConst.buttonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(
                        Images.pngSecurity,
                        color: Colors.white,
                      )),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Entrance Quiz',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          '5 Questions |',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '10 minutes',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAdvanceTile(AdvancedTile tile) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        color: Colors.grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 10, bottom: 10),
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: ColorConst.buttonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(
                        tile.imgUrl,
                        color: Colors.white,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tile.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      tile.subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 9,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget learningTile() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
        itemCount: course!.chapters!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade100)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ExpansionTile(
                collapsedIconColor: Colors.white,
                iconColor: Colors.white,
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                onExpansionChanged: (isExpanded) {},
                initiallyExpanded: index == 0,
                backgroundColor: ColorConst.primaryColor,
                collapsedBackgroundColor: ColorConst.primaryColor,
                leading: const Icon(
                  Icons.file_copy_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  course!.chapters![index]['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  '${course!.chapters![index]['chapter_items'].length} items',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: null,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          course!.chapters![index]['chapter_items'].length,
                      itemBuilder: (BuildContext context, int i) {
                        final data =
                            course!.chapters![index]['chapter_items'][i];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade100,
                            ),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(
                                  checkFileType(
                                    course!.chapters![index]['chapter_items']
                                        [i],
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                const CircleAvatar(
                                  radius: 10,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                  ),
                                ),
                              ],
                            ),
                            // contentPadding: const EdgeInsets.all(0),
                            leading: getIcon(data['type']),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
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
