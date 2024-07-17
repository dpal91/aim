import 'dart:developer';

import 'package:confetti/confetti.dart';
import '../../Quizes/Controller/result_by_id_controller.dart';
import '../../Quizes/Model/quiz_result_model.dart';
import '../../Quizes/Quiz%20Details/Pages/review_answer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';

class SectionalResultPage extends StatefulWidget {
  const SectionalResultPage({Key? key}) : super(key: key);

  @override
  State<SectionalResultPage> createState() => _SectionalResultPageState();
}

class _SectionalResultPageState extends State<SectionalResultPage> {
  var percent = 80;
  bool isPlaying = false;
  final controller = ConfettiController();
  ResultByIdController resultByIdController = Get.put(ResultByIdController());
  List<QuizData> data = [];
  bool isLoading = true;
  List<int> ids = [];
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    setState(() {
      ids = Get.arguments;
    });
    for (var i = 0; i < ids.length; i++) {
      getData(ids[i]);
    }
    super.initState();
  }

  getData(int id) async {
    data.clear();
    log(Get.arguments.toString());
    final res = await resultByIdController.getQuiz(id);
    if (res != null) {
      data.add(res);
      if (data.length == Get.arguments.length) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  bool isRefreshing = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  skipped() {
    int total = 0;
    for (int i = 0; i < data.length; i++) {
      List<String> questionIds = [];
      data[i].userAnswers.forEach((key, value) {
        if (key != "attempt_number") {
          questionIds.add(key);
        }
      });
      total += questionIds.length;
    }
    return totalQuestions() - total;
  }

  int totalMarks() {
    int total = 0;
    for (int i = 0; i < data.length; i++) {
      final marks = data[i].quizResult.quiz.totalMark;
      total += marks;
    }
    return total;
  }

  double myMarks() {
    double total = 0;
    for (int i = 0; i < data.length; i++) {
      total += double.parse(data[i].quizResult.userGrade.toString());
    }
    return total;
  }

  int getCorrectAnswers() {
    int total = 0;
    for (int i = 0; i < data.length; i++) {
      total += getfromIds(data[i].userAnswers, true);
      log(data[i].userAnswers.toString());
    }
    return total;
  }

  int getWrongAnswers() {
    int total = 0;
    for (int i = 0; i < data.length; i++) {
      total += getfromIds(data[i].userAnswers, false);
    }
    return total;
  }

  int getfromIds(Map<String, dynamic> answers, bool correct) {
    List<String> questionIds = [];
    answers.forEach((key, value) {
      if (key != "attempt_number") {
        questionIds.add(key);
      }
    });
    List<String> correctAnswers = [];
    for (var i = 0; i < questionIds.length; i++) {
      correctAnswers.addIf(answers[questionIds[i]]['status'] == correct,
          answers[questionIds[i]]['status'].toString());
    }
    return correctAnswers.length;
  }

  getStatus() {
    if (myMarks() >= totalMarks() * 0.6) {
      return 'passed';
    } else if (myMarks() < totalMarks() * 0.6) {
      return 'failed';
    } else {
      return 'waiting';
    }
  }

  totalQuestions() {
    int total = 0;
    for (int i = 0; i < data.length; i++) {
      total += data[i].quizResult.quiz.quizQuestions.length;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorConst.primaryColor,
            statusBarIconBrightness: Brightness.light,
          ),
          backgroundColor: ColorConst.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            "Quiz Result",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            top: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              reuseablebox(
                color: Colors.redAccent,
                icon: Icons.restart_alt,
                text: "Play Again",
                onTap: () {
                  Get.back();
                },
              ),
              reuseablebox(
                color: Colors.green,
                icon: Icons.share,
                text: "Share Result",
                onTap: () async {
                  final dir = await getApplicationDocumentsDirectory();
                  screenshotController
                      .captureAndSave(
                    dir.path,
                  )
                      .then((value) async {
                    await Share.shareFiles(
                      ['$value'],
                      text:
                          "Hey, I just took a quiz on AimPariksha and scored ${myMarks().toStringAsFixed(2)} out of ${totalMarks()}. Download the app now to take the quiz and improve your knowledge. https://play.google.com/store/apps/details?id=com.aimparikshaa.app",
                    );
                  });
                },
              ),
              reuseablebox(
                color: Colors.orange,
                icon: Icons.home,
                text: "Home",
                onTap: () {
                  Get.offAllNamed(RoutesName.bottomNavigation);
                },
              ),
            ],
          ),
        ),
        body: isLoading
            ? const Center(
                child: Center(child: CircularProgressIndicator()),
              )
            : isRefreshing
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: Get.height * 0.3,
                            color: ColorConst.primaryColor,
                            width: Get.width,
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              margin: const EdgeInsets.all(20),
                              height: 350,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(3, 0),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Row(),
                                  Text(
                                    getStatus() == 'passed'
                                        ? "Congratulations! You have scored"
                                        : getStatus() == 'failed'
                                            ? "Oh no! You have scored"
                                            : "Waiting to finish the quiz",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.blue,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ConfettiWidget(
                                          confettiController: controller,
                                          shouldLoop: false,
                                          blastDirectionality:
                                              BlastDirectionality.explosive,
                                        ),
                                        Center(
                                          child: Text(
                                            myMarks().toString(),
                                            style: const TextStyle(
                                              fontSize: 40,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Out of ${totalMarks()}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Your Results are here: ",
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: Colors.green,
                                                radius: 10,
                                                child: Icon(
                                                  Icons.done,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${getCorrectAnswers()} / ${totalQuestions()}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Correct",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 32,
                                        width: 1,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: Colors.orange,
                                                radius: 10,
                                                child: Icon(
                                                  Icons.fast_forward,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${skipped()} / ${totalQuestions()}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Skipped",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 32,
                                        width: 1,
                                        color: Colors.grey,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: Colors.red,
                                                radius: 10,
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${getWrongAnswers()} / ${totalQuestions()}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Incorrect",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Your Quiz Results: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  for (var element in data)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.green,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    element
                                                        .quizResult.quiz.title,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    Get.to(
                                                      () => ReviewAnswers(
                                                        questionList: element
                                                            .quizResult
                                                            .quiz
                                                            .quizQuestions,
                                                        userAnswers:
                                                            element.userAnswers,
                                                        title: element
                                                            .quizResult
                                                            .quiz
                                                            .title,
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Review",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Marks: ${element.quizResult.userGrade}",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  reuseablebox({
    required Color color,
    required IconData icon,
    required String text,
    required Function()? onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
