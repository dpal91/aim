import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Controller/result_by_id_controller.dart';
import '../../Model/quiz_result_model.dart';
import '../../Quiz%20Details/Pages/quiz_details_page_two.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizDetailsPageOne extends StatefulWidget {
  const QuizDetailsPageOne({Key? key}) : super(key: key);

  @override
  State<QuizDetailsPageOne> createState() => _QuizDetailsPageOneState();
}

class _QuizDetailsPageOneState extends State<QuizDetailsPageOne> {
  var percent = 80;
  bool isPlaying = false;
  final controller = ConfettiController();
  ResultByIdController resultByIdController = Get.put(ResultByIdController());
  QuizData? data;
  bool isLoading = true;
  String? profileImage;
  RxMap<String, dynamic> profileDetails = <String, dynamic>{}.obs;
  final List<ChartData> incorrectChartData = [];
  final List<ChartData> correctChartData = [];
  final List<ChartData> skippedChartData = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    profileImage = GetStorage().read("proImage");

    data = await resultByIdController.getQuiz(Get.arguments);
    if (data != null) {
      getCorrectAnswers();
      getIncorrectAnswers();
      getSkippedAnsewrs();
      setState(() {
        isLoading = false;
      });
      if (data!.quizResult.status == 'passed') {
        controller.play();
        Future.delayed(const Duration(seconds: 2), () {
          controller.stop();
        });
      }
    } else {
      getData();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Test Analysis',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.back();
          Get.back();
        },
        child: Container(
          height: 50,
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 227, 60, 119),
          ),
          child: const Center(
            child: Text(
              "Home",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: isLoading
          ? const Center(
              child: Center(child: CircularProgressIndicator()),
            )
          : SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.11,
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              height: 90,
                            ),
                            Text(
                              data!.quizResult.status == 'passed'
                                  ? "Congratulations! You have score ${getCorrectAnswers()} / ${data!.quizResult.quiz.quizQuestions.length}"
                                  : data!.quizResult.status == 'failed'
                                      ? "Oh no! You have scored ${getCorrectAnswers()} / ${data!.quizResult.quiz.quizQuestions.length}"
                                      : "Waiting to finish the quiz",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    PhysicalModel(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(10),
                                      shadowColor: Colors.grey[100]!,
                                      color: Colors.white,
                                      child: Container(
                                        height: Get.height * 0.1,
                                        width: Get.width * 0.26,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.grey[100]!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.12,
                                      width: Get.width * 0.26,
                                      child: Center(
                                        child: SfCircularChart(
                                          margin: const EdgeInsets.all(0),
                                          annotations: [
                                            CircularChartAnnotation(
                                              widget: Text(
                                                "${getCorrectAnswers()} / ${data!.quizResult.quiz.quizQuestions.length}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                          series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                              dataSource: correctChartData,
                                              startAngle: 270,
                                              radius: "45",
                                              endAngle: 90,
                                              pointColorMapper:
                                                  (ChartData data, _) =>
                                                      data.color,
                                              xValueMapper:
                                                  (ChartData data, _) => data.x,
                                              yValueMapper:
                                                  (ChartData data, _) => data.y,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: SizedBox(
                                        width: Get.width * 0.26,
                                        child: const Center(
                                          child: Text(
                                            "Correct",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Stack(
                                  children: [
                                    PhysicalModel(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(10),
                                      shadowColor: Colors.grey[100]!,
                                      color: Colors.white,
                                      child: Container(
                                        height: Get.height * 0.1,
                                        width: Get.width * 0.26,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.grey[100]!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.12,
                                      width: Get.width * 0.26,
                                      child: Center(
                                        child: SfCircularChart(
                                          annotations: [
                                            CircularChartAnnotation(
                                              widget: Text(
                                                "${getIncorrectAnswers()} / ${data!.quizResult.quiz.quizQuestions.length}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                          series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                                dataSource: incorrectChartData,
                                                startAngle: 270,
                                                endAngle: 90,
                                                radius: "45",
                                                pointColorMapper:
                                                    (ChartData data, _) =>
                                                        data.color,
                                                xValueMapper:
                                                    (ChartData data, _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, _) =>
                                                        data.y)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: SizedBox(
                                        width: Get.width * 0.26,
                                        child: const Center(
                                          child: Text(
                                            "Incorrect",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Stack(
                                  children: [
                                    PhysicalModel(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(10),
                                      shadowColor: Colors.grey[100]!,
                                      color: Colors.white,
                                      child: Container(
                                        height: Get.height * 0.1,
                                        width: Get.width * 0.26,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Colors.grey[100]!,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.12,
                                      width: Get.width * 0.26,
                                      child: Center(
                                        child: SfCircularChart(
                                          margin: const EdgeInsets.all(0),
                                          annotations: [
                                            CircularChartAnnotation(
                                              widget: Text(
                                                "${getSkippedAnsewrs()} / ${data!.quizResult.quiz.quizQuestions.length}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                          series: <CircularSeries>[
                                            DoughnutSeries<ChartData, String>(
                                              dataSource: skippedChartData,
                                              startAngle: 270,
                                              radius: "45",
                                              endAngle: 90,
                                              pointColorMapper:
                                                  (ChartData data, _) =>
                                                      data.color,
                                              xValueMapper:
                                                  (ChartData data, _) => data.x,
                                              yValueMapper:
                                                  (ChartData data, _) => data.y,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: SizedBox(
                                        width: Get.width * 0.26,
                                        child: const Center(
                                          child: Text(
                                            "Skipped",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: PhysicalModel(
                          elevation: 1,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: Colors.grey[100]!,
                          color: Colors.white,
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey[100]!,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                      ),
                                      child: Text(
                                        "Questions Distribution",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  width: Get.width,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: Get.width *
                                            (getCorrectAnswers() /
                                                data!.quizResult.quiz
                                                    .quizQuestions.length),
                                        decoration: const BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            bottomLeft: Radius.circular(25),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: Get.width *
                                            (getIncorrectAnswers() /
                                                data!.quizResult.quiz
                                                    .quizQuestions.length),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: getCorrectAnswers()
                                                      .toString() ==
                                                  "0"
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  bottomLeft:
                                                      Radius.circular(25),
                                                )
                                              : BorderRadius.circular(0),
                                        ),
                                      ),
                                      Container(
                                        height: 20,
                                        width: (Get.width *
                                                ((data!
                                                            .quizResult
                                                            .quiz
                                                            .quizQuestions
                                                            .length -
                                                        (getCorrectAnswers() +
                                                            getIncorrectAnswers())) /
                                                    data!
                                                        .quizResult
                                                        .quiz
                                                        .quizQuestions
                                                        .length)) -
                                            90,
                                        decoration: const BoxDecoration(
                                          color: Colors.pinkAccent,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            bottomRight: Radius.circular(25),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    numberWidget(
                                      getCorrectAnswers().toString(),
                                      "Correct",
                                      Colors.green,
                                    ),
                                    numberWidget(
                                      getIncorrectAnswers().toString(),
                                      "Wrong",
                                      Colors.red,
                                    ),
                                    numberWidget(
                                      getSkippedAnsewrs().toString(),
                                      "Unattempted",
                                      Colors.pinkAccent,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                Divider(
                                  color: Colors.grey[600],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => const QuizDetailsPageTwo(),
                                      arguments: data!.quizResult.quiz.id,
                                    );
                                    return;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    width: Get.width,
                                    child: Center(
                                      child: Text(
                                        "Re-Attempt",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green[900],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     reuseablebox(
                      //       color: Colors.redAccent,
                      //       icon: Icons.restart_alt,
                      //       text: "Play Again",
                      //       onTap: () {
                      //         Get.to(
                      //           () => const QuizDetailsPageTwo(),
                      //           arguments: data!.quizResult.quiz.id,
                      //         );
                      //         return;
                      //       },
                      //     ),
                      //     reuseablebox(
                      //       color: Colors.green,
                      //       icon: Icons.remove_red_eye,
                      //       text: "Review Answer",
                      //       onTap: () {
                      //         Get.to(
                      //           () => ReviewAnswers(
                      //             questionList:
                      //                 data!.quizResult.quiz.quizQuestions,
                      //             title: data!.quizResult.quiz.title,
                      //             userAnswers: data!.userAnswers,
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //     reuseablebox(
                      //       color: Colors.orange,
                      //       icon: Icons.home,
                      //       text: "Home",
                      //       onTap: () {
                      //         Get.back();
                      //       },
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 100,
                      child: Center(
                        child: Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                profileImage == "" || profileImage == null
                                    ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                                    : profileImage!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget numberWidget(
    String title,
    String subtitle,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          height: 22,
          width: 22,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
      ],
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

  getIncorrectAnswers() {
    List<String> questionIds = [];
    incorrectChartData.clear();
    data!.userAnswers.forEach((key, value) {
      if (key != "attempt_number") {
        questionIds.add(key);
      }
    });
    List<String> correctAnswers = [];
    for (var i = 0; i < questionIds.length; i++) {
      correctAnswers.addIf(data!.userAnswers[questionIds[i]]['status'] == false,
          data!.userAnswers[questionIds[i]]['status'].toString());
    }
    incorrectChartData.add(
      ChartData(
          'David', double.parse(correctAnswers.length.toString()), Colors.red),
    );
    incorrectChartData.add(ChartData(
        'Suman',
        double.parse(data!.quizResult.quiz.quizQuestions.length.toString()),
        Colors.grey[200]));
    return correctAnswers.length;
  }

  getCorrectAnswers() {
    List<String> questionIds = [];
    correctChartData.clear();
    data!.userAnswers.forEach((key, value) {
      if (key != "attempt_number") {
        questionIds.add(key);
      }
    });
    List<String> correctAnswers = [];
    for (var i = 0; i < questionIds.length; i++) {
      correctAnswers.addIf(data!.userAnswers[questionIds[i]]['status'] == true,
          data!.userAnswers[questionIds[i]]['status'].toString());
    }
    correctChartData.add(
      ChartData('David', double.parse(correctAnswers.length.toString()),
          Colors.green),
    );
    correctChartData.add(ChartData(
        'Suman',
        double.parse(data!.quizResult.quiz.quizQuestions.length.toString()),
        Colors.grey[200]));
    return correctAnswers.length;
  }

  getSkippedAnsewrs() {
    skippedChartData.clear();
    skippedChartData.add(
      ChartData(
        'David',
        data!.quizResult.quiz.quizQuestions.length -
            (data!.userAnswers
                    .map((key, value) => MapEntry(key, value))
                    .length -
                1),
        Colors.green,
      ),
    );
    // log(double.parse(getCorrectAnswers() + getIncorrectAnswers()).toString());
    skippedChartData.add(
      ChartData(
        'Suman',
        double.parse((getCorrectAnswers() + getIncorrectAnswers()).toString()),
        Colors.pinkAccent,
      ),
    );
    return data!.quizResult.quiz.quizQuestions.length -
        (data!.userAnswers.map((key, value) => MapEntry(key, value)).length -
            1);
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
