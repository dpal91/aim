import 'dart:convert';

import '../../../QuizQuesandAns/Controller/controller.dart';
import '../../../../Service/service.dart';
import '../../../../Utils/Constants/constants_colors.dart';
import '../../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/Constants/routes.dart';
import '../../../../Utils/Wdgets/snackbar.dart';

class QuizDetailsPageTwo extends StatefulWidget {
  const QuizDetailsPageTwo({Key? key}) : super(key: key);

  @override
  State<QuizDetailsPageTwo> createState() => _QuizDetailsPageTwoState();
}

class _QuizDetailsPageTwoState extends State<QuizDetailsPageTwo> {
  QuizPageController controller = Get.put(QuizPageController());

  @override
  void initState() {
    super.initState();
    controller.getQuesAns(Get.arguments);
  }

  @override
  void dispose() {
    controller.isLoading(false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: MyAppBar(
        //   title: 'Quiz',
        //   backgroundColor: ColorConst.primaryColor,
        //   titleColor: Colors.white,
        //   leading: InkWell(
        //     onTap: () {
        //       Get.back();
        //     },
        //     child: const Icon(
        //       Icons.arrow_back_ios_new,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        body: Container(
          decoration: BoxDecoration(
            color: ColorConst.primaryColor,
          ),
          child: SafeArea(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final quiz = controller.quizQuesAnsData!.data;
              if (quiz.quizQuestions.isEmpty) {
                return Column(
                  children: [
                    MyAppBar(
                      title: 'Quizzes',
                      backgroundColor: ColorConst.primaryColor,
                      titleColor: Colors.white,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "No question for this quize available!",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                  ],
                );
              }
              return Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 60,
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
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    quiz.title,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
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
                                                    '${quiz.quizQuestions.length} Questions',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text(
                                                    'Total Questions of Quiz',
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
                                                    '${quiz.time} Minutes',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    '${quiz.attempt ?? "Unlimited"} Attempts',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                    '${quiz.passMark} Marks',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                          height: 20,
                                        ),
                                        reuseableText(
                                          text:
                                              "${quiz.quizQuestions.first.grade} Marks for a correct answer and no marks for incorrect answer.",
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0, vertical: 10),
                              child: SizedBox(
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    );
                                    startQuiz(
                                            controller.quizQuesAnsData!.data.id)
                                        .then((value) {
                                      if (value == null) {
                                        return;
                                      }
                                      if (value[1] ==
                                          controller
                                              .quizQuesAnsData!.data.attempt) {
                                        Get.back();
                                        // ignore: use_build_context_synchronously
                                        SnackBarService.showSnackBar(
                                          context,
                                          "Your Attempts are over.",
                                        );
                                        return;
                                      }
                                      Get.back();
                                      Get.offAndToNamed(
                                        RoutesName.quizQuesAndAnswerPage,
                                        arguments: [value[0], value[1]],
                                      );
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorConst.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        30,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
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

  Future<List<int>?> startQuiz(int quizid) async {
    String url = "quizzes/$quizid/start?device_type=android";
    final response = await ApiService.get(key: url);
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
}
