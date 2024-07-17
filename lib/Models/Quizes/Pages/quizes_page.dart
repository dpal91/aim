import 'package:cached_network_image/cached_network_image.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../Home/Model/home_model.dart';
import '../Controller/my_results_controller.dart';
import '../Controller/quiz_controller.dart';
import '../Quiz%20Details/Pages/quiz_details_page_two.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QuizesPage extends StatefulWidget {
  final bool showBar;
  final List<Webinar> testSeries;
  const QuizesPage({
    Key? key,
    this.showBar = true,
    required this.testSeries,
  }) : super(key: key);

  @override
  State<QuizesPage> createState() => _QuizesPageState();
}

class _QuizesPageState extends State<QuizesPage> with TickerProviderStateMixin {
  QuizController controller = Get.put(QuizController());
  MyResultsController resultController = Get.put(MyResultsController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
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
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              onTap: (value) {
                if (value == 1) {
                  resultController.getQuiz(isReloading: true);
                } else if (value == 0) {
                  controller.getQuiz(isReloading: true);
                }
              },
              controller: tabController,
              indicatorColor: Colors.blue,
              labelColor: ColorConst.buttonColor,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(
                  child: Text(
                    'Free',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Tab(
                  child: Text(
                    'Paid',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Tab(
                  child: Text(
                    'My Results',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () {
                return TabBarView(
                  controller: tabController,
                  children: [
                    freeTestSeries(),
                    controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : reusableTabTwo(),
                    resultController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : reusableTabOne(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget freeTestSeries() {
    final data = widget.testSeries
        .where((element) => element.price == 0 || element.price == null)
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: widget.testSeries.isEmpty
          ? const Center(
              child: Text(
                "No free quiz available!",
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: widget.testSeries
                  .where(
                      (element) => element.price == 0 || element.price == null)
                  .length,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  onTap: () async {
                    Get.dialog(
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                      barrierDismissible: false,
                    );
                    final controller = Get.put(AllCoursesController());
                    await controller.getAllCourseDetails(
                      data[index].slug!,
                    );
                    Get.back();
                    Get.toNamed(
                      RoutesName.quizDetailsPageTwo,
                      arguments: controller.allCoursesDetailsData!.chapters![0]
                          ['chapter_items'][0]['quiz']['id'],
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: 160,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      margin:
                          const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 80,
                            width: 120,
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.hide_image_rounded),
                              useOldImageOnUrlChange: true,
                              imageUrl: RoutesName.baseImageUrl +
                                  data[index].thumbnail!,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].title!,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                // const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 35,
                                      decoration: BoxDecoration(
                                        // color: ColorConst.primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Attempt',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.red,
                                            size: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
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

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  Widget reusableTabOne() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: refreshController,
        onRefresh: () {
          resultController.isLoading(true);
          resultController.resultsModel = null;
          resultController.getQuiz().then((value) {
            refreshController.refreshCompleted();
            setState(() {});
          });
        },
        onLoading: () {
          if (resultController.total >
              resultController.resultsModel!.data.quizzesResults.data.length) {
            resultController
                .getQuiz(
              page: resultController
                      .resultsModel!.data.quizzesResults.currentPage +
                  1,
            )
                .then((value) {
              refreshController.loadComplete();
              setState(() {});
            });
          } else {
            refreshController.loadNoData();
          }
        },
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("Pull up load");
            } else if (mode == LoadStatus.loading) {
              body = const CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        child: resultController.resultsModel == null ||
                resultController.resultsModel!.data.quizzesResults.data.isEmpty
            ? const Center(
                child: Text(
                  'No Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: resultController
                    .resultsModel!.data.quizzesResults.data.length,
                itemBuilder: (BuildContext context, index) {
                  final data = resultController
                      .resultsModel!.data.quizzesResults.data[index];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: const Offset(0, .1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            // border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Image(
                            image: AssetImage('assets/hhhhh.png'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.quiz.title,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        /*  Text(
                                          data.quiz.webinarTitle,
                                          style: const TextStyle(
                                              fontSize: 9, color: Colors.black),
                                        ),*/
                                        const SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: data.status == 'failed'
                                          ? Colors.red
                                          : data.status == 'passed'
                                              ? Colors.green
                                              : Colors.orange,
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      data.status.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              /*const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 2.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/calendar.png',
                                          height: 14,
                                          width: 14,
                                        ),
                                        Text(
                                          DateFormat(" dd MMM yyyy").format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              data.quiz.createdAt * 1000,
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontSize: 9,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/clock.png',
                                          height: 14,
                                          width: 14,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: Text(
                                            ' ${data.quiz.time} min',
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/question-mark.png',
                                          height: 14,
                                          width: 14,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: Text(
                                            ' ${data.quiz.quizQuestions.length} Questions',
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),*/
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: CupertinoButton(
                                        onPressed: () {
                                          Get.to(
                                            () => const QuizDetailsPageTwo(),
                                            arguments: data.quiz.id,
                                          );
                                        },
                                        padding: const EdgeInsets.all(0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorConst.primaryColor,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: const Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.restart_alt,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Reattempt',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: CupertinoButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            RoutesName.quizDetailsPageOne,
                                            arguments: data.id,
                                          );
                                        },
                                        padding: const EdgeInsets.all(0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: ColorConst.primaryColor,
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: const Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.white,
                                                  size: 15,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Review',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  RefreshController nrefreshController =
      RefreshController(initialRefresh: false);

  TabController? tabController;
  int tabIndex = 0;

  Widget reusableTabTwo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: nrefreshController,
        onRefresh: () {
          controller.isLoading(true);
          controller.quizModel = null;
          controller.getQuiz().then((value) {
            nrefreshController.refreshCompleted();
            setState(() {});
          });
        },
        onLoading: () {
          if (controller.total >
              controller.quizModel!.data.quizzes.data.length) {
            controller
                .getQuiz(
              page: controller.quizModel!.data.quizzes.currentPage + 1,
            )
                .then((value) {
              nrefreshController.loadComplete();
              setState(() {});
            });
          } else {
            nrefreshController.loadNoData();
          }
        },
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = const Text("Pull up load");
            } else if (mode == LoadStatus.loading) {
              body = const CircularProgressIndicator();
            } else if (mode == LoadStatus.failed) {
              body = const Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = const Text("release to load more");
            } else {
              body = const Text("No more Data");
            }
            return SizedBox(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        child: controller.quizModel!.data.quizzes.data.isEmpty
            ? const Center(
                child: Text(
                  'Please Enroll in a Course to View Quizzes',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.quizModel!.data.quizzes.data.length,
                itemBuilder: (BuildContext context, index) {
                  final quiz = controller.quizModel!.data.quizzes.data[index];
                  return InkWell(
                    onTap: () => Get.toNamed(
                      RoutesName.quizDetailsPageTwo,
                      arguments: quiz.id,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: 160,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.only(
                            right: 10, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 80,
                              width: 120,
                              child: const Image(
                                image: AssetImage('assets/hhhhh.png'),
                                fit: BoxFit.fill,
                              ), /*CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.hide_image_rounded),
                                useOldImageOnUrlChange: true,
                                imageUrl: RoutesName.baseImageUrl + quiz.,
                                fit: BoxFit.fill,
                              ),*/
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          quiz.title,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          // color: ColorConst.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Attempt',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.red,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), /*Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: const Offset(0, .1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Image(
                              image: AssetImage('assets/hhhhh.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(quiz.title,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 2.0,
                                            ),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/calendar.png',
                                                  height: 14,
                                                  width: 14,
                                                ),
                                                Text(
                                                  DateFormat(" dd MMM yyyy")
                                                      .format(
                                                    DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                      quiz.createdAt * 1000,
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/question-mark.png',
                                                  height: 14,
                                                  width: 14,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0),
                                                  child: Text(
                                                    ' ${quiz.totalMark} Marks',
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/clock.png',
                                                  height: 14,
                                                  width: 14,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0),
                                                  child: Text(
                                                    ' ${quiz.time} min',
                                                    style: const TextStyle(
                                                      fontSize: 10,
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
                                const SizedBox(
                                  height: 5,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed(
                                      RoutesName.quizDetailsPageTwo,
                                      arguments: quiz.id,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: ColorConst.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Start Quiz'),
                                      SizedBox(width: 5),
                                      Icon(Icons.play_arrow),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  );
                },
              ),
      ),
    );
  }
}
