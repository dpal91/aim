import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '../../Quizes/Controller/sectional_controller.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../Quizes/Model/quiz_by_id_model.dart';
import '../Controller/submit_quiz_controller.dart';
import '../QuizClasses/quiz_screen_classes.dart';
import 'sectional_result_page.dart';

class SectionalQuizPlayer extends StatefulWidget {
  final int webinarid;
  final String negativemark;
  final String title;
  const SectionalQuizPlayer({
    Key? key,
    required this.webinarid,
    required this.negativemark,
    required this.title,
  }) : super(key: key);

  @override
  State<SectionalQuizPlayer> createState() => _SectionalQuizPlayerState();
}

class _SectionalQuizPlayerState extends State<SectionalQuizPlayer> {
  List<QuizQuestion>? questionList;
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;
  int startsec = 60;
  int startmin = 4;
  SectionalController controller = Get.put(SectionalController());
  SubmitQuizController submitcontroller = Get.put(SubmitQuizController());

  List<Map<String, dynamic>> quizResult = [];
  List<bool> markforReview = [];
  ValueNotifier<double> valueNotifier = ValueNotifier(0.0);
  int selectedSection = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      questionList = controller.quizQuesAnsData.first.quizQuestions;
      startmin = controller.quizQuesAnsData.first.time - 1;
      newQuizIdList = Get.arguments[0];
      attemptCountList = Get.arguments[1];
    });

    for (var i = 0; i < questionList!.length; i++) {
      quizResult.add(
        {
          "question": questionList![i].id,
          "correctAnswer": questionList![i].quizzesQuestionsAnswers.indexOf(
                questionList![i]
                    .quizzesQuestionsAnswers
                    .firstWhere((element) => element.correct == 1),
              ),
          "selectedAnswer": null,
        },
      );
      markforReview.add(false);
    }
    startTimer();
  }

  ScrollController scrollController = ScrollController();
  int newQuizId = 0;
  Future<List<int>?> startQuiz(int quizid) async {
    // log("quizid: $quizid");
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
    log("error: ${data['message']}");
    return null;
  }

  submitquiz() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    submitcontroller
        .submitquiz(
      controller.quizQuesAnsData[selectedSection].id,
      newQuizIdList[selectedSection],
      quizResult,
      attemptCountList[selectedSection],
      courseId: widget.webinarid,
    )
        .then((value) {
      Get.back();
      if (value) {
        if (selectedSection + 1 == controller.quizQuesAnsData.length) {
          SnackBarService.showSnackBar(context, "Quiz Submit SuccessFully");
          Get.off(
            () => const SectionalResultPage(),
            arguments: newQuizIdList,
          );
        } else {
          startNextSection();
        }
      }
    });
  }

  List<int> newQuizIdList = [];
  List<int> attemptCountList = [];
  startNextSection() async {
    timer?.cancel();
    Get.dialog(
      const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Changing Section....",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
    setState(() {
      if (selectedSection != controller.quizQuesAnsData.length) {
        selectedSection++;
      }
    });
    _pageController.jumpToPage(0);
    setState(() {
      questionList = controller.quizQuesAnsData[selectedSection].quizQuestions;
      startmin = controller.quizQuesAnsData[selectedSection].time - 1;
      startsec = 60;
      currentQuestionIndex = 0;
    });

    quizResult.clear();
    markforReview.clear();
    for (var i = 0; i < questionList!.length; i++) {
      quizResult.add(
        {
          "question": questionList![i].id,
          "correctAnswer": questionList![i].quizzesQuestionsAnswers.indexOf(
                questionList![i]
                    .quizzesQuestionsAnswers
                    .firstWhere((element) => element.correct == 1),
              ),
          "selectedAnswer": null,
        },
      );
      markforReview.add(false);
    }
    startTimer();
    Get.back();
  }

  final _pageController = PageController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the Quiz?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConst.primaryColor,
        endDrawer: buildQuestionPallete(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 35,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: startmin == 0 && startsec < 10
                              ? Colors.red
                              : HexColor.fromHex('#135097'),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${startmin.toString().length <= 1 ? ("0$startmin") : ("$startmin")}:${startsec.toString().length <= 1 ? ("0$startsec") : "$startsec"}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.title + widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState!.openEndDrawer();
                        },
                        icon: const Icon(
                          Icons.apps,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    color: ColorConst.primaryColor,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.quizQuesAnsData.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (selectedSection != index) {
                              SnackBarService.showSnackBar(
                                context,
                                'You can not change section now',
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: selectedSection == index
                                  ? Colors.white
                                  : ColorConst.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                controller.quizQuesAnsData[index].title,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: index == selectedSection
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                child: Text(
                                  "${currentQuestionIndex + 1}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "+${questionList![currentQuestionIndex].grade} Marks  -${widget.negativemark} Marks",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              CupertinoButton(
                                onPressed: () {
                                  setState(() {
                                    markforReview[currentQuestionIndex] =
                                        !markforReview[currentQuestionIndex];
                                  });
                                },
                                padding: const EdgeInsets.all(0),
                                child: Row(
                                  children: [
                                    Text(
                                      markforReview[currentQuestionIndex]
                                          ? "Marked for review"
                                          : "Mark for review",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      markforReview[currentQuestionIndex]
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: markforReview[currentQuestionIndex]
                                          ? Colors.blue
                                          : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20,
                                bottom: 10,
                              ),
                              child: PageView.builder(
                                itemCount: questionList!.length,
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    currentQuestionIndex = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        _questionWidget(index),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        myAswButton(index),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: currentQuestionIndex == 0
                                ? Colors.grey.withOpacity(0.5)
                                : ColorConst.buttonColor,
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              splashRadius: 30,
                              onPressed: currentQuestionIndex != 0
                                  ? () {
                                      if (currentQuestionIndex != 0) {
                                        setState(() {
                                          currentQuestionIndex--;
                                        });
                                        _pageController.previousPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn,
                                        );
                                      }
                                    }
                                  : null,
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              showSubmitDialog();
                            },
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                  const StadiumBorder()),
                            ),
                            child: const SizedBox(
                              height: 48,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        _nextButton(),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget buildQuestionPallete() {
    return Container(
      height: Get.height,
      width: Get.width * 0.7,
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Questions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 60,
                  childAspectRatio: 1.2,
                ),
                shrinkWrap: true,
                itemCount: questionList!.length,
                itemBuilder: (context, index) {
                  final answer = quizResult[index];
                  bool isReview = markforReview[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: index == currentQuestionIndex
                          ? Colors.red
                          : isReview
                              ? const Color.fromRGBO(169, 189, 223, 1)
                              : answer['selectedAnswer'] != null
                                  ? Colors.green
                                  : Colors.black,
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentQuestionIndex = index;
                          });
                          _pageController.jumpToPage(
                            index,
                          );
                          scrollController.animateTo(
                            40.0 * (currentQuestionIndex),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Center(
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    "Marked for Review",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: const Color.fromRGBO(169, 189, 223, 1),
                    child: Text(
                      markforReview
                          .where((element) => element == true)
                          .length
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    "Total Attempted",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.green,
                    child: Text(
                      quizResult
                          .where((element) => element['selectedAnswer'] != null)
                          .length
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text(
                    "Unattempted",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[400],
                    child: Text(
                      quizResult
                          .where((element) => element['selectedAnswer'] == null)
                          .length
                          .toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
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

  bool isExpanded = false;
  Widget _questionWidget(index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: isExpanded ? null : 100,
          margin: const EdgeInsets.symmetric(vertical: 0),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  questionList![index].title,
                  maxLines: isExpanded ? null : 3,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  bool scored = false;
  Widget myAswButton(int myIndex) {
    final answers = controller.quizQuesAnsData[selectedSection]
        .quizQuestions[myIndex].quizzesQuestionsAnswers;
    final abcd = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K'];
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: answers.length,
      itemBuilder: (context, index) {
        var quizdata = quizResult[myIndex];
        return CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            if (quizResult[myIndex]['selectedAnswer'] == answers[index].id) {
              setState(() {
                quizResult[myIndex]['selectedAnswer'] = null;
              });
            } else {
              setState(() {
                quizResult[myIndex]['selectedAnswer'] = answers[index].id;
              });
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor:
                      quizdata['selectedAnswer'] == answers[index].id
                          ? ColorConst.buttonColor
                          : Colors.black,
                  child: Text(
                    abcd[index],
                    style: TextStyle(
                      color: quizdata['selectedAnswer'] == answers[index].id
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        answers[index].title,
                        style: const TextStyle(
                          color: Colors.black,
                          height: 1.5,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (index != answers.length - 1)
                        const Divider(
                          height: 5,
                          color: Colors.grey,
                        ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                // img
                if (answers[index].image != null)
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(answers[index].image!),
                        fit: BoxFit.cover,
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

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList!.length - 1) {
      isLastQuestion = true;
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: isLastQuestion
            ? Colors.grey.withOpacity(0.5)
            : ColorConst.buttonColor,
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Material(
        color: Colors.transparent,
        child: IconButton(
          splashRadius: 30,
          onPressed: () {
            if (!isLastQuestion) {
              setState(() {
                currentQuestionIndex = currentQuestionIndex + 1;
              });
            }
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            );
          },
          icon: const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  showSubmitDialog() {
    log(quizResult.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Are you sure you want to submit?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                submitquiz();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Widget _header() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 35,
              width: double.infinity,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: questionList!.length,
                itemBuilder: (context, index) {
                  bool isAnswered = quizResult[index]['selectedAnswer'] != null;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentQuestionIndex = index;
                        });
                        scrollController.animateTo(
                          30.0 * index,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: currentQuestionIndex == index
                                  ? Colors.red
                                  : isAnswered
                                      ? Colors.green
                                      : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 40,
                            height: 2,
                            color: currentQuestionIndex == index
                                ? Colors.red
                                : isAnswered
                                    ? Colors.green
                                    : Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
    );
  }

  Timer? timer;
  void startTimer() {
    const onsec = Duration(seconds: 1);
    timer = Timer.periodic(onsec, (timer) {
      if (startsec == 0 && startmin == 0) {
        submitquiz();
        setState(() {
          timer.cancel();
        });
      } else if (startsec == 0) {
        setState(() {
          startmin = startmin - 1;
          startsec = 60;
          startsec--;
        });
      } else {
        if (mounted) {
          setState(() {
            startsec--;
          });
        }
      }
    });
  }

  showtimeOutDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Lottie.asset('assets/timeup.json'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Time is up',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Do you want to restart the quiz or submit it?',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                  submitquiz();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
