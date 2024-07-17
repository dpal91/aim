import '../../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Utils/Constants/constants_colors.dart';
import '../../Model/quiz_result_model.dart';

class ReviewAnswers extends StatefulWidget {
  final Map<String, dynamic> userAnswers;
  final String title;
  final List<QuizQuestion> questionList;
  const ReviewAnswers({
    Key? key,
    required this.questionList,
    required this.userAnswers,
    required this.title,
  }) : super(key: key);

  @override
  State<ReviewAnswers> createState() => _ReviewAnswersState();
}

class _ReviewAnswersState extends State<ReviewAnswers> {
  List<QuizQuestion>? questionList;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    questionList = widget.questionList;
    super.initState();
  }

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        centerTitle: true,
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
      ),
      endDrawer: buildQuestionPallete(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  _header(),
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: questionList!.length,
                      onPageChanged: (value) {
                        setState(() {
                          currentQuestionIndex = value;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 10,
                          ),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _questionWidget(index),
                                myAswButton(index),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (questionList![currentQuestionIndex]
                                        .explanation !=
                                    null)
                                  const Text(
                                    "Explanation:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (questionList![currentQuestionIndex]
                                        .explanation !=
                                    null)
                                  Text(
                                    questionList![currentQuestionIndex]
                                            .explanation ??
                                        "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  onPressed: currentQuestionIndex != 0
                      ? () {
                          if (currentQuestionIndex != 0) {
                            setState(() {
                              currentQuestionIndex--;
                            });
                            pageController.animateToPage(
                              currentQuestionIndex,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          }
                        }
                      : null,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: currentQuestionIndex != 0
                        ? ColorConst.primaryColor
                        : Colors.grey.withOpacity(0.4),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                _nextButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionWidget(int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 30),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey.withOpacity(0.5),
            child: Text(
              '${currentQuestionIndex + 1}',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              questionList![index].title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool scored = false;
  Widget myAswButton(int nindex) {
    final abcd = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
    final answers = questionList![nindex].quizzesQuestionsAnswers;
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: answers.length,
      itemBuilder: (context, index) {
        final currentIndex = index;
        final correctIndex =
            answers.indexWhere((element) => element.correct == 1);
        final questionId = questionList![nindex].id;

        final userAnswerIndex = widget.userAnswers.map((key, value) {
          if (key == questionId.toString()) {
            return MapEntry(key, value['answer']);
          }
          return MapEntry(key, false);
        });
        final answerslist = questionList![nindex].quizzesQuestionsAnswers;
        final myindex = answerslist.indexWhere(
            (element) => element.id == userAnswerIndex[questionId.toString()]);
        return Column(
          children: [
            Container(
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: getColor(myindex, questionId, currentIndex, correctIndex),
                // border: Border.all(
                //   color: userAnswerIndex[questionId.toString()] == true &&
                //           currentIndex == correctIndex
                //       ? Colors.green
                //       : Colors.grey,
                // ),
              ),
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: correctIndex == currentIndex
                          ? Colors.green
                          : myindex == currentIndex
                              ? Colors.red
                              : Colors.grey.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      abcd[index],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      answers[index].title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: correctIndex == currentIndex
                            ? Colors.green
                            : myindex == currentIndex
                                ? Colors.red
                                : Colors.black,
                      ),
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
            if (index != answers.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Divider(
                  height: 5,
                  color: Colors.grey,
                ),
              ),
          ],
        );
      },
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
                  // final answer = quizResult[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: index == currentQuestionIndex
                          ? Colors.blue
                          : isCorrect(questionList![index].id)
                              ? Colors.green
                              : Colors.red,
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
                          pageController.jumpToPage(
                            index,
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
                      (widget.userAnswers.length - 1).toString(),
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
                    "Total Correct",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.green,
                    child: Text(
                      getCorrect().toString(),
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
                    "Incorrect",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.grey[400],
                    child: Text(
                      ((widget.userAnswers.length - 1) - getCorrect())
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

  getCorrect() {
    int correct = 0;
    for (var i = 0; i < questionList!.length; i++) {
      if (isCorrect(questionList![i].id)) {
        correct++;
      }
    }
    return correct;
  }

  isCorrect(int id) {
    final answer = widget.userAnswers[id.toString()];
    if (answer == null) {
      return false;
    }
    return answer['status'];
  }

  getColor(int myindex, int questionId, int currentIndex, int correctIndex) {
    if (correctIndex == currentIndex) {
      return Colors.green;
    }
    if (myindex == currentIndex) {
      return Colors.red;
    }
    return Colors.white;
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList!.length - 1) {
      isLastQuestion = true;
    }
    return CupertinoButton(
      onPressed: () {
        if (isLastQuestion) {
          Navigator.pop(context);
        } else {
          //next question
          setState(() {
            currentQuestionIndex++;
            scored = false;
          });

          pageController.animateToPage(
            currentQuestionIndex,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        }
      },
      child: CircleAvatar(
        radius: 25,
        child: Icon(
          isLastQuestion ? Icons.check : Icons.arrow_forward_ios,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 0.5),
          height: 38,
          width: double.infinity,
          child: Row(
            children: [
              Text(
                ' +${widget.questionList[currentQuestionIndex].grade} Marks',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
