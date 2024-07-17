// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:elera/Models/AllCources/Controller/all_courses_controller.dart';
import 'package:elera/Models/AllCources/Model/all_courses_details_model.dart';
import 'package:elera/Utils/Constants/constants_colors.dart';
import 'package:elera/Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../../../Utils/Constants/routes.dart';
import '../../LearningPage/Controller/controller.dart';

class DemoStudyMaterial extends StatefulWidget {
  final String title;
  const DemoStudyMaterial({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<DemoStudyMaterial> createState() => _DemoStudyMaterialState();
}

class _DemoStudyMaterialState extends State<DemoStudyMaterial> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AllCoursesController>(
        init: AllCoursesController(),
        builder: (controller) => Scaffold(
          appBar: MyAppBar(
            backgroundColor: ColorConst.primaryColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: widget.title,
            titleColor: Colors.white,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          body: controller.isLoading.value
              ? const SafeArea(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : WebViewPlus(
                  javascriptMode: JavascriptMode.unrestricted,
                  zoomEnabled: false,
                  onWebViewCreated: (wcontroller) {
                    wcontroller.loadUrl(Uri.dataFromString(
                      controller.allCoursesDetailsData!.description ?? "",
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'),
                    ).toString());
                  },
                  onPageFinished: (url) {
                    print('Page finished loading: $url');
                  },
                  onWebResourceError: (error) {
                    print('Web resource error: ${error.description}');
                    // Handle the error and display an appropriate message
                  },
                ),
        ),
      ),
    );
  }

  Widget learningTile({
    required Course? course,
  }) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
        itemCount: course!.chapters!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: Card(
              elevation: 5.0,
              shadowColor: ColorConst.primaryColor.withOpacity(0.5),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey.shade100,
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: ExpansionTile(
                  collapsedIconColor: Colors.black,
                  iconColor: Colors.black,
                  tilePadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  onExpansionChanged: (isExpanded) {},
                  initiallyExpanded: index == 0,
                  // backgroundColor: ColorConst.,
                  // collapsedBackgroundColor: ColorConst.primaryColor,
                  leading: const Icon(
                    Icons.file_copy_rounded,
                    color: Colors.grey,
                  ),
                  title: Text(
                    course.chapters![index]['title'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${course.chapters![index]['chapter_items'].length} items',
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
                            course.chapters![index]['chapter_items'].length,
                        itemBuilder: (BuildContext context, int i) {
                          final data =
                              course.chapters![index]['chapter_items'][i];
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
                                      course.chapters![index]['chapter_items']
                                          [i],
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
                                          arguments: course.chapters![index]
                                                  ['chapter_items'][i]['quiz']
                                              ['id'],
                                        );
                                      }
                                      if (data['type'] == 'session') {
                                        Get.toNamed(
                                          RoutesName.meetingDetailsPage,
                                          arguments: {
                                            'id': data['item_id'],
                                            'imageCover': '',
                                            'title': data['session']['title'],
                                            'discription': data['session']
                                                    ['description'] ??
                                                "",
                                            'sessionId': data['session']
                                          },
                                        );
                                      }
                                      LearningPageController().openFile(
                                        type: course.chapters![index]
                                            ['chapter_items'][i]['type'],
                                        url: course.chapters![index]
                                                ['chapter_items'][i]['fileData']
                                            ['file'],
                                      );
                                    },
                                    child: Text(
                                      getText(data['type']),
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
    }
    return "Loading...";
  }
}
