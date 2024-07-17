import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Utils/Constants/routes.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../AllCources/Pages/all_courses_pages_details.dart';
import '../../Home/Controller/home_controller.dart';
import '../../Home/Pages/study_material_page.dart';
import '../../QuizQuesandAns/Controller/controller.dart';

class DemoSectionPage extends StatefulWidget {
  const DemoSectionPage({Key? key}) : super(key: key);

  @override
  State<DemoSectionPage> createState() => _DemoSectionPageState();
}

class _DemoSectionPageState extends State<DemoSectionPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> quizlist = [];
  bool isLoading = false;

  // getAllQuiz() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final response = await ApiService.get(
  //     key: 'quiz_list',
  //   );
  //   if (response != null) {
  //     final data = jsonDecode(response)['data']['allQuizzesLists'];
  //     quizlist.clear();
  //     for (var element in data) {
  //       if (element['q_type'] == 'p_y_q') {
  //         quizlist.add(element);
  //       }
  //     }
  //   }
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  final controller = Get.find<HomeController>();

  // HomeController controller = Get.find();
  // CategoryController coursecontroller = Get.put(CategoryController());
  final allCoursesController = Get.find<AllCoursesController>();
  QuizPageController quizcontroller = Get.put(QuizPageController());

  final box = GetStorage();

  TabController? _tabController;
  List<String> titles = [
    'Videos',
    'Notes',
    'Quizzes',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // quizcontroller.getQuesAns(Get.arguments);
    // getAllQuiz();
  }

  @override
  void dispose() {
    quizcontroller.isLoading(false);
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   controller.getQuesAns(Get.arguments);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: "Demo section",
          backgroundColor: ColorConst.primaryColor,
          titleColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: Column(
          children: [
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
                    'Videos',
                    style: TextStyle(fontSize: 13),
                  )),
                  Tab(
                    child: Text(
                      'Notes',
                      style: TextStyle(fontSize: 13),
                      overflow: TextOverflow.fade,
                    ),
                  ),
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
        ));
  }

  TabBarView _body() {
    return TabBarView(
      controller: _tabController,
      children: [
        reusableTabVideosDemoSection(),
        reusableTabNotesDemoSection(),
        reusableTabQuizsDemoSection(),
      ],
    );
  }

  Widget reusableTabVideosDemoSection() {
    return Container(
      height: 190,
      margin: const EdgeInsets.only(bottom: 30),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.homeData!.data!.freeWebinars
            .where((element) => element.type == "course")
            .length,
        itemBuilder: (context, index) {
          return coursesBuilder(
            controller.homeData!.data!.freeWebinars
                .where((element) => element.type == "course")
                .toList(),
            index,
            isDemo: true,
          );
        },
        separatorBuilder: (context, _) => const SizedBox(
          width: 0,
        ),
      ),
    );
  }

  Widget reusableTabNotesDemoSection() {
    return Container(
      height: 205,
      margin: const EdgeInsets.only(bottom: 30),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.studymaterial
            .where((element) => element.price == 0 || element.price == null)
            .length,
        itemBuilder: (context, index) {
          return coursesBuilder(
            controller.studymaterial
                .where((element) => element.price == 0 || element.price == null)
                .toList(),
            index,
            isDemo: false,
            isStudy: true,
          );
        },
        separatorBuilder: (context, _) => const SizedBox(
          width: 0,
        ),
      ),
    );
  }

  Widget reusableTabQuizsDemoSection() {
    return Container(
      height: 205,
      margin: const EdgeInsets.only(bottom: 30),
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.testSeries
            .where((element) => element.price == 0 || element.price == null)
            .length,
        itemBuilder: (context, index) => coursesBuilder(
          controller.testSeries
              .where((element) => element.price == 0 || element.price == null)
              .toList(),
          index,
          istest: true,
          isDemo: false,
          isStudy: false,
        ),
        separatorBuilder: (context, _) => const SizedBox(
          width: 0,
        ),
      ),
    );
  }

  Widget coursesBuilder(var data, int index,
      {bool isDemo = false, bool isStudy = false, bool istest = false}) {
    return InkWell(
      onTap: () async {
        if (isStudy) {
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );
          await allCoursesController.getAllCourseDetails(
            data[index].slug!,
          );
          Get.back();

          Get.to(
            () => DemoStudyMaterial(
              title: data[index].title!,
            ),
          );
        } else if (istest) {
          // log(index.toString());
          // Get.dialog(
          //   const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          //   barrierDismissible: false,
          // );

          await allCoursesController.getAllCourseDetails(
            data[index].slug!,
          );
          log(allCoursesController.allCoursesDetailsData!
              .chapters![0]['chapter_items'][0]['quiz']['title']
              .toString());
          /*Get.back();*/
          Get.toNamed(
            RoutesName.quizDetailsPageTwo,
            arguments: allCoursesController.allCoursesDetailsData!.chapters![0]
                ['chapter_items'][0]['quiz']['id'],
          );
        } else {
          allCoursesController.getAllCourseDetails(
            data[index].slug!,
          );
          Get.to(
            () => AllCoursesPageDetails(
              isDemo: isDemo,
              latestWebinars: data,
              notIncludedLatestWebinars: data[index],
            ),
          );
        }
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
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
          child: Row(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
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
                  imageUrl: RoutesName.baseImageUrl + data[index].thumbnail!,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                istest ? 'Attempt' : 'View',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
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
  }

  // void quizcall()async{
  //   var quizdata = await allCoursesController.getAllCourseDetails(
  //           data[index].slug!),

  // }

  Widget quizBuilder(var data, int index,
      {bool isDemo = false, bool isStudy = false, bool istest = false}) {
    void quizcall() async {
      await allCoursesController.getAllCourseDetails(data[index].slug!);
      await quizcontroller.getQuesAns(allCoursesController
          .allCoursesDetailsData!
          .chapters![0]['chapter_items'][0]['quiz']['id']);
    }

    return InkWell(
      onTap: () async {
        if (istest) {
          print(allCoursesController.allCoursesDetailsData!.chapters![0]
              ['chapter_items'][0]['quiz']['id']);
          Get.dialog(
            const Center(
              child: CircularProgressIndicator(),
            ),
            barrierDismissible: false,
          );
          await allCoursesController.getAllCourseDetails(
            data[index].slug!,
          );
          Get.back();

          Get.toNamed(
            RoutesName.quizDetailsPageTwo,
            arguments: allCoursesController.allCoursesDetailsData!.chapters![0]
                ['chapter_items'][0]['quiz']['id'],
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          width: 160,
          // height: isDemo ? null : 205,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 198, 198, 198),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 84.375,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.hide_image_rounded),
                        useOldImageOnUrlChange: true,
                        imageUrl:
                            RoutesName.baseImageUrl + data[index].thumbnail!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (isDemo == false)
                    SizedBox(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                data[index].title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                child: Obx(() {
                                  if (controller.isLoading.value) {
                                    return const Scaffold(
                                      body: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  quizcall();

                                  final quiz =
                                      quizcontroller.quizQuesAnsData!.data;
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(quiz.quizQuestions.toString())
                                        ],
                                      )
                                    ],
                                  );
                                }),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 210,
                                height: 35,
                                decoration: BoxDecoration(
                                  color: ColorConst.primaryColor,
                                  borderRadius: const BorderRadius.only(
                                    // bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        istest ? 'Attempt' : 'View',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                          const SizedBox(
                            height: 5,
                          ),
                          data[index].price != null
                              ? Row(
                                  children: [
                                    const Text(
                                      '₹',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                    Text(
                                      data[index].price!.toString(),
                                      style: const TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  "",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                )
                        ],
                      ),
                    )
                  else
                    SizedBox(
                      height: 35,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(),
                            Text(
                              data[index].title!,
                              maxLines: 2,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String image, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        // color: Colors.grey,
      ),
      child: CachedNetworkImage(
        imageUrl: RoutesName.baseImageUrl + image,
        fit: BoxFit.contain,
      ),
    );
  }
}
