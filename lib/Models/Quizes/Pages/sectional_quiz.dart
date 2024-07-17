import 'dart:convert';
import 'dart:developer';

import '../../AllCources/Controller/all_courses_controller.dart';
import '../../AllCources/Model/all_courses_details_model.dart';
import '../../../Utils/Constants/constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import '../../QuizQuesandAns/Controller/controller.dart';
import '../../QuizQuesandAns/Page/sectional_quiz_player.dart';
import '../Controller/sectional_controller.dart';

class SectionalQuiz extends StatefulWidget {
  final String? slug;
  const SectionalQuiz({
    Key? key,
    this.slug,
  }) : super(key: key);

  @override
  State<SectionalQuiz> createState() => _SectionalQuizState();
}

class _SectionalQuizState extends State<SectionalQuiz> {
  final courseController = Get.put(AllCoursesController());
  bool isLoading = true;
  Course? courseDetails;
  @override
  void initState() {
    super.initState();
    getData();
  }

  QuizPageController controller = Get.put(QuizPageController());

  @override
  void dispose() {
    controller.isLoading(false);
    super.dispose();
  }

  getData() async {
    final data = await courseController.getDetails(widget.slug!);
    courseDetails = data!.data!.course;
    setState(() {
      isLoading = false;
    });
    controller.getQuesAns(getCOntents()[0]['quiz']['id']);
  }

  List getCOntents() {
    List newContents = [];

    for (var element in courseDetails!.chapters!) {
      for (var item in element['chapter_items']) {
        newContents.add(item);
      }
    }
    return newContents;
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

  totalMarks() {
    int total = 0;
    // for (var element in courseDetails!.chapters!) {
    //   for (var item in element['chapter_items']) {
    //     if (item['type'] == 'quiz') {
    //       total += int.parse(item['quiz']['total_marks'].toString());
    //     }
    //   }
    // }
    return total;
  }

  totalTime() {
    int total = 0;
    for (var element in getCOntents()) {
      total = total + int.parse(element['quiz']['time'].toString());
    }
    return total;
  }

  totalPassMark() {
    int total = 0;
    for (var element in getCOntents()) {
      total = total + int.parse(element['quiz']['pass_mark'].toString());
    }
    return total;
  }

  Future<List<int>?> startQuiz(int quizid) async {
    String url = "quizzes/$quizid/start?device_type=android";
    final response = await ApiService.get(key: url);
    log("Quiz Start: $response");
    final data = jsonDecode(response);
    if (data['statusCode'] == 200) {
      final id = data['data']['newQuizStart']['id'];
      return [
        id,
        data['data']['attempt_count'],
      ];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizPageController>(
      init: QuizPageController(),
      builder: (asdf) {
        // log("Quiz Data: ${asdf.quizQuesAnsData!.toJson()}");
        if (isLoading || asdf.isLoading.value) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          backgroundColor: ColorConst.primaryColor,
          body: SafeArea(
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: SizedBox(
                    height: Get.height * .15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: kToolbarHeight,
                          child: Row(
                            children: [
                              IconButton(
                                splashRadius: 25,
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                courseDetails!.title!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomScrollView(
                              slivers: [
                                SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Center(
                                      //     child: Image.asset(
                                      //   Images.pngQbank,
                                      //   height: 200,
                                      //   width: 160,
                                      // )),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/question-mark.png',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "${getCOntents().length} Sections",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  'Total Sections in Quiz',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/clock.png',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${totalTime()} Minutes',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  'Total Duration of Quiz',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/pencil.png',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${getCOntents()[0]['quiz']['attempt'] ?? "Unlimited"} Attempts',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  'Number of Attempts',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 100,
                                            color: Colors.grey,
                                            width: 1,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/medal.png',
                                                  height: 40,
                                                  width: 40,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${totalPassMark()} Marks',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                const Text(
                                                  'Passing Marks of Quiz',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Instructions",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      reuseableText(
                                        text:
                                            "Tap on Options to select your answer.",
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      reuseableText(
                                        text:
                                            "You can change your answer anytime before submitting.",
                                      ),
                                      if (getCOntents().any((element) =>
                                          element['quiz']['negative_mark'] !=
                                          null))
                                        reuseableText(
                                          text:
                                              "There will be -${getCOntents().firstWhere((element) => element['quiz']['negative_mark'] != null)['quiz']['negative_mark']} Marks for a wrong answer.",
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Sections",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // for (var element in getCOntents())
                                      //   Column(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.start,
                                      //     children: [
                                      //       Text(
                                      //         "${getCOntents().indexOf(element) + 1}. ${element['quiz']['title'].toString().capitalizeFirst!}",
                                      //         style: const TextStyle(
                                      //           fontSize: 16,
                                      //           fontWeight: FontWeight.bold,
                                      //         ),
                                      //       ),
                                      //       Text(
                                      //           "   Passing Marks: ${element['quiz']['pass_mark']} Marks"),
                                      //       Text(
                                      //           "   Time: ${element['quiz']['time']} Minutes"),
                                      //     ],
                                      //   ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Get.dialog(
                                          const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          barrierDismissible: false,
                                        );
                                        List<int> attemptCountList = [];
                                        List<int> newQuizIdList = [];
                                        bool isAttemptOver = false;
                                        for (var element
                                            in getCOntents().reversed) {
                                          await startQuiz(element['quiz']['id'])
                                              .then((value) async {
                                            if (value == null) {
                                              isAttemptOver = true;
                                              Get.back();
                                              SnackBarService.showSnackBar(
                                                context,
                                                "Your Attempts are over.",
                                              );
                                              return;
                                            }
                                            attemptCountList.add(value[1]);
                                            newQuizIdList.add(value[0]);
                                          });
                                        }
                                        if (attemptCountList.length !=
                                            getCOntents().length) {
                                          Get.back();

                                          return;
                                        }
                                        if (!isAttemptOver) {
                                          final sectionalController = Get.put(
                                            SectionalController(),
                                          );
                                          final data = await sectionalController
                                              .getSectionalQuiz(
                                            courseDetails!.id!,
                                          );
                                          Get.back();
                                          if (data) {
                                            Get.to(
                                              () => SectionalQuizPlayer(
                                                webinarid: courseDetails!.id!,
                                                negativemark: getCOntents()
                                                        .firstWhere((element) =>
                                                            element['quiz'][
                                                                'negative_mark'] !=
                                                            null)['quiz']
                                                    ['negative_mark'],
                                                title: courseDetails!.title!,
                                              ),
                                              arguments: [
                                                newQuizIdList,
                                                attemptCountList
                                              ],
                                            );
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            SnackBarService.showSnackBar(
                                              context,
                                              "Something Went Wrong. Try Again!",
                                            );
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            ColorConst.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Start Quiz',
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.play_arrow,
                                            size: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  reuseableText({
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Transform.rotate(
              angle: 90 * 3.14 / 180,
              child: Image.asset(
                'assets/point.png',
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
