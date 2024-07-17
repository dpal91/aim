import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../AllCources/Model/all_courses_details_model.dart';
import '../../Current%20Affair/current_affair_model.dart';
import '../../Home/Controller/home_controller.dart';
import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevate_icon_button.dart';
import '../../AllCources/Pages/all_courses_pages_details.dart';
import 'current_affair_details_screen.dart';
import 'video_player_screen.dart';

class CurrentAffairPage extends StatefulWidget {
  const CurrentAffairPage({Key? key}) : super(key: key);

  @override
  State<CurrentAffairPage> createState() => _CurrentAffairPageState();
}

class _CurrentAffairPageState extends State<CurrentAffairPage>
    with SingleTickerProviderStateMixin {
  CurrentAffairsModel? currentAffairsModel;
  List<AllCoursesDetailsModel> allCoursesDetailsModel = [];
  final detailscontroller = Get.put(AllCoursesController());
  String paidSlug = '';

  int currentPage = 1;
  int totalItems = 0;
  bool isLoading = false;

  getAllQuiz({
    bool isUpdate = false,
  }) async {
    setState(() {
      isLoading = true;
    });
    if (isUpdate) {
      currentPage++;
    }
    try {
      final response = await ApiService.post(
        key: 'previousyearpaper?page=$currentPage',
        body: {"type": "currentaffairs"},
      );
      if (response != null) {
        if (isUpdate) {
          currentAffairsModel!.webinars.data!
              .addAll(currentAffairsModelFromJson(response).webinars.data!);
        } else {
          currentAffairsModel = currentAffairsModelFromJson(response);
        }
        totalItems = jsonDecode(response)['totalWebinars'];
        currentPage = jsonDecode(response)['webinars']['current_page'];
      }
      /*paidSlug = currentAffairsModel!.webinars.data!
          .firstWhere((element) => element.price != null && element.price != 0)
          .slug!;*/
      currentAffairsModel!.webinars.data!.removeWhere(
          (element) => element.price != null && element.price != 0);
      allCoursesDetailsModel.clear();
      for (var element in currentAffairsModel!.webinars.data!) {
        final data =
            await detailscontroller.getCurrentAffairsData(element.slug!);
        if (data != null) {
          allCoursesDetailsModel.add(data);
        }
      }
    } catch (e) {
      debugPrint("Err : getAllQuiz $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getAllQuiz();
  }

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Current Affairs',
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
      body: SafeArea(
        child: Column(
          children: [
            if (false)
              InkWell(
                onTap: () {
                  final controller = Get.put(AllCoursesController());
                  controller.getAllCourseDetails(paidSlug);
                  Get.to(() => AllCoursesPageDetails());
                },
                child: Image.asset(
                  'assets/currentaffairs_banner.jpg',
                  width: Get.width,
                ),
              ),
            Container(
              color: Colors.white,
              child: TabBar(
                indicatorColor: Colors.blue,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black,
                controller: _tabController,
                tabs: const [
                  Tab(
                      child: Text(
                    'Events / Issues',
                    style: TextStyle(fontSize: 13),
                  )),
                  // Tab(
                  //   child: Text(
                  //     'Videos',
                  //     style: TextStyle(fontSize: 13),
                  //     overflow: TextOverflow.fade,
                  //   ),
                  // ),
                  Tab(
                    child: Text(
                      'Quizzes',
                      style: TextStyle(fontSize: 13),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }

  TabBarView _body() {
    return TabBarView(
      controller: _tabController,
      children: [
        reusableTabNotes(),
        // reusableTabVideos(),
        reusableTabQuizzes(),
      ],
    );
  }

  //reusable tab videos
  Widget reusableTabVideos() {
    return allCoursesDetailsModel.isEmpty
        ? const Center(child: Text('No Data Found'))
        : ListView.builder(
            itemCount: allCoursesDetailsModel.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => VideoPlayerScreen(
                        videoUrl: allCoursesDetailsModel[index]
                            .data!
                            .course!
                            .videoDemo!,
                      ),
                    );
                  },
                  child: Container(
                    height: 120,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 85,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: RoutesName.baseImageUrl +
                                  allCoursesDetailsModel[index]
                                      .data!
                                      .course!
                                      .thumbnail!,
                              fit: BoxFit.contain,
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
                                allCoursesDetailsModel[index]
                                    .data!
                                    .course!
                                    .title!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'View',
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
                              /* CupertinoButton(
                                onPressed: () {
                                  Get.to(
                                    () => VideoPlayerScreen(
                                      videoUrl: allCoursesDetailsModel[index]
                                          .data!
                                          .course!
                                          .videoDemo!,
                                    ),
                                  );
                                },
                                padding: const EdgeInsets.all(0),
                                child: Container(
                                  height: 35,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: ColorConst.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _footer(context) {
    return Container(
      height: 45.0,
      width: 45.0,
      margin: const EdgeInsets.only(bottom: 30, right: 20),
      child: FloatingActionButton(
        elevation: 0.0,
        onPressed: () {
          _bottomFilterSheet(context);
        },
        backgroundColor: ColorConst.buttonColor,
        child: const Icon(
          Icons.filter_list,
          color: Colors.white,
        ),
      ),
    );
  }

  final quizrefreshcontroller = RefreshController(initialRefresh: false);

  List<dynamic> getQuizzesList() {
    List<dynamic> chapterData = [];
    for (var element in allCoursesDetailsModel) {
      if (element.data!.course!.chapters!.isNotEmpty) {
        for (var chapter in element.data!.course!.chapters!) {
          for (var quiz in chapter['chapter_items']) {
            if (quiz['type'] == 'quiz') {
              chapterData.add(quiz);
            }
          }
        }
      }
    }
    return chapterData;
  }

  Widget reusableTabQuizzes() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: SmartRefresher(
            controller: quizrefreshcontroller,
            onRefresh: () async {
              getAllQuiz();
              quizrefreshcontroller.refreshCompleted();
            },
            child: allCoursesDetailsModel.isEmpty
                ? const Center(
                    child: Text('No Data Found'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: getQuizzesList().length,
                    itemBuilder: (BuildContext context, index) {
                      final data = getQuizzesList()[index]['quiz'];
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 2.5,
                          right: 2.5,
                          bottom: 14,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              RoutesName.quizDetailsPageTwo,
                              arguments: data['id'],
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 10,
                              left: 10,
                            ),
                            child: PhysicalModel(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              elevation: 3,
                              shadowColor: Colors.grey.withOpacity(0.6),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 160,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    // boxShadow: [
                                    //   BoxShadow(
                                    //     color: Colors.grey.withOpacity(0.2),
                                    //     spreadRadius: 1,
                                    //     blurRadius: 1,
                                    //     offset: const Offset(
                                    //         0, 1), // changes position of shadow
                                    //   ),
                                    // ],
                                  ),
                                  margin: const EdgeInsets.only(
                                      right: 10, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        height: 100,
                                        width: Get.width * 0.3,
                                        child: Image.asset(
                                          'assets/hhhhh.png',
                                          fit: BoxFit.fill,
                                        ), /*CachedNetworkImage(
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.hide_image_rounded),
                                          useOldImageOnUrlChange: true,
                                          imageUrl: RoutesName.baseImageUrl + data[index].thumbnail!,
                                          fit: BoxFit.fill,
                                        ),*/
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                    data!['title'],
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    // color: ColorConst.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: const Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
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
                            ),
                          ),
                        ),
                      );
                      /*Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Image.asset(
                                  'assets/hhhhh.png',
                                  height: 50,
                                  width: 50,
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
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      data!['title'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/calendar.png',
                                                height: 15,
                                                width: 15,
                                              ),
                                              Text(
                                                DateFormat(' dd MMM yyyy')
                                                    .format(
                                                  DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          data['created_at']! *
                                                              1000),
                                                ),
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/clock.png',
                                              height: 15,
                                              width: 15,
                                            ),
                                            Text(
                                              " ${data['time']} min",
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 10,
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 2.0),
                                          child: Row(
                                            children: const [
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Text(
                                                "             ",
                                                // overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Get.toNamed(
                                              RoutesName.quizDetailsPageTwo,
                                              arguments: data['id'],
                                            );
                                          },
                                          child: SizedBox(
                                            height: 38,
                                            child: MyRoundedButton('Start ▶️'),
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
                      )*/
                      // ;
                    },
                  ),
          ),
        ),
      ],
    );
  }

  final refreshcontroller = RefreshController(initialRefresh: false);

  Widget reusableTabNotes() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: SmartRefresher(
            controller: refreshcontroller,
            onRefresh: () async {
              await getAllQuiz();
              refreshcontroller.refreshCompleted();
            },
            child: currentAffairsModel == null
                ? const Center(child: Text('No Data Found'))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: currentAffairsModel!.webinars.data!.length,
                    itemBuilder: (BuildContext context, index) {
                      final currentAffairs =
                          currentAffairsModel!.webinars.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 2.5,
                          right: 2.5,
                          bottom: 14,
                        ),
                        child: InkWell(
                          onTap: () async {
                            final data = await Get.to(
                              () => CurrentAffairsDetailScreen(
                                currentAffairl: currentAffairs,
                              ),
                            );
                            if (data != null) {
                              _tabController!.animateTo(0);
                            }
                          },
                          child: Container(
                            width: Get.width,
                            height: Get.height * 0.14,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: PhysicalModel(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              elevation: 3,
                              shadowColor: Colors.grey.withOpacity(0.6),
                              child: Container(
                                width: Get.width,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 7),
                                decoration: BoxDecoration(
                                    // boxShadow: const [
                                    // BoxShadow(
                                    //   color: Colors.grey.withOpacity(0.1),
                                    //   spreadRadius: 2,
                                    //   blurRadius: 1,
                                    //   offset: const Offset(0, .1),
                                    // ),
                                    // ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: SizedBox(
                                        height: 90,
                                        width: Get.width * 0.38,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: RoutesName.baseImageUrl +
                                                currentAffairs.thumbnail!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                currentAffairs.title!,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                'View',
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
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _bottomFilterSheet(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        )),
        builder: (builder) {
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.symmetric(vertical: 30),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.black,
                                size: 16,
                              )),
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child:
                                  const Icon(Icons.close, color: Colors.black)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Filter',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        filterButton('2016'),
                        const SizedBox(
                          width: 20,
                        ),
                        filterButton('2017'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        filterButton('2018'),
                        const SizedBox(
                          width: 20,
                        ),
                        filterButton('2019'),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        filterButton('2020'),
                        const SizedBox(
                          width: 20,
                        ),
                        filterButton('2021'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  SizedBox filterButton(String text) {
    return SizedBox(
      height: 50,
      width: 70,
      child: InkWell(
        onTap: () {
          Get.back();
        },
        child: MyRoundedButton(text),
      ),
    );
  }
}
