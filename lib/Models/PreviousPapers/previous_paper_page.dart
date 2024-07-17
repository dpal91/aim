import 'dart:convert';

import 'package:dio/dio.dart';
import '../AllCources/Controller/all_courses_controller.dart';
import 'sections_page.dart';
import '../../Utils/Constants/constants_colors.dart';
import '../../Utils/Wdgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Service/service.dart';

class PreviousPapersPage extends StatefulWidget {
  const PreviousPapersPage({Key? key}) : super(key: key);

  @override
  State<PreviousPapersPage> createState() => _PreviousPapersPageState();
}

class _PreviousPapersPageState extends State<PreviousPapersPage> {
  List<dynamic> quizlist = [];
  bool isLoading = false;
  int currentPage = 1;
  int totalItems = 0;

  getAllQuiz({
    bool isUpdate = false,
  }) async {
    setState(() {
      isLoading = true;
    });
    if (isUpdate) {
      currentPage++;
    }
    final response = await ApiService.post(
      key: 'previousyearpaper?page=$currentPage',
      body: {
        "type": "previousyearpaper",
      },
    );

    if (response != null) {
      final data = jsonDecode(response)['webinars']['data'];
      quizlist = data;
      totalItems = jsonDecode(response)['totalWebinars'];
      currentPage = jsonDecode(response)['webinars']['current_page'];
    }
    tags.clear();
    tags.add("All");
    for (var element in quizlist) {
      tags.add(element['tags'][0]['title']);
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<String> tags = [];

  @override
  void initState() {
    super.initState();
    getAllQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Previous Year Papers",
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
      ),
      body: reusableTabQuizzes(),
    );
  }

  String selectedTag = "All";

  final quizrefreshcontroller = RefreshController(initialRefresh: false);

  Widget reusableTabQuizzes() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return DefaultTabController(
      length: tags.length,
      child: Column(
        children: [
          // SizedBox(
          //   height: 35,
          //   width: Get.width,
          //   child: ListView(
          //     shrinkWrap: true,
          //     scrollDirection: Axis.horizontal,
          //     padding: const EdgeInsets.symmetric(
          //       horizontal: 10,
          //     ),
          //     children: [
          //       InkWell(
          //         onTap: () {
          //           setState(() {
          //             selectedTag = "All";
          //           });
          //         },
          //         borderRadius: BorderRadius.circular(10),
          //         child: Container(
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 10,
          //           ),
          //           decoration: BoxDecoration(
          //             color: selectedTag == "All"
          //                 ? ColorConst.primaryColor.withOpacity(0.15)
          //                 : Colors.transparent,
          //             borderRadius: BorderRadius.circular(10),
          //             border: Border.all(
          //               color: ColorConst.primaryColor,
          //               width: 0.5,
          //             ),
          //           ),
          //           child: Center(
          //             child: Text(
          //               "All",
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontSize: 16,
          //                 fontWeight: selectedTag == "All"
          //                     ? FontWeight.w600
          //                     : FontWeight.normal,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       ...tags.map(
          //         (e) => Row(
          //           children: [
          //             const SizedBox(
          //               width: 10,
          //             ),
          //             InkWell(
          //               onTap: () {
          //                 setState(() {
          //                   selectedTag = e;
          //                 });
          //               },
          //               borderRadius: BorderRadius.circular(10),
          //               child: Container(
          //                 padding: const EdgeInsets.symmetric(
          //                   horizontal: 10,
          //                 ),
          //                 decoration: BoxDecoration(
          //                   color: selectedTag == e
          //                       ? ColorConst.primaryColor.withOpacity(0.15)
          //                       : Colors.transparent,
          //                   borderRadius: BorderRadius.circular(10),
          //                   border: Border.all(
          //                     color: ColorConst.primaryColor,
          //                     width: 0.5,
          //                   ),
          //                 ),
          //                 child: Center(
          //                   child: Text(
          //                     e,
          //                     style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: 16,
          //                       fontWeight: selectedTag == e
          //                           ? FontWeight.w600
          //                           : FontWeight.normal,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),

          TabBar(
            onTap: (index) {
              setState(() {
                selectedTag = tags[index];
              });
            },
            tabs: [
              for (var element in tags)
                Tab(
                  child: Text(
                    element,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: selectedTag == element
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
            ],
          ),

          Expanded(
            child: SmartRefresher(
              controller: quizrefreshcontroller,
              onRefresh: () async {
                getAllQuiz();
                quizrefreshcontroller.refreshCompleted();
              },
              enablePullDown: true,
              enablePullUp: true,
              onLoading: () async {
                if (quizlist.length < totalItems) {
                  getAllQuiz(isUpdate: true);
                  quizrefreshcontroller.loadComplete();
                } else {
                  quizrefreshcontroller.loadNoData();
                }
              },
              child: TabBarView(
                children: List.generate(tags.length, (i) {
                  final dataPaper = getList();
                  return quizlist.isEmpty
                      ? const Center(
                          child: Text('No Data Found'),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataPaper.length,
                          itemBuilder: (BuildContext context, index) {
                            final quiz = dataPaper[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoButton(
                                onPressed: () {
                                  final controller =
                                      Get.put(AllCoursesController());
                                  controller.getAllCourseDetails(quiz['slug']);
                                  Get.to(
                                    () => SectionsPage(
                                      title: quiz['title'],
                                    ),
                                  );
                                },
                                padding: EdgeInsets.zero,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            quiz['title'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getList() {
    if (selectedTag == "All") {
      return quizlist;
    } else {
      return quizlist
          .where((element) => element['tags'][0]['title'] == selectedTag)
          .toList();
    }
  }

  downloadPdf(String? url) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    Get.back();
    if (url != null) {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        await Dio().download(
          url,
          '/storage/emulated/0/Download/LiveDivine/${url.substring(0, 15)}.pdf',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Downloaded'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permission Denied'),
          ),
        );
      }
    } else {
      Get.snackbar('Error', 'No Pdf Found');
    }
  }
}
