import 'dart:convert';
import 'dart:developer';

import '../AllCources/Controller/all_courses_controller.dart';
import '../Current%20Affair/current_affair_model.dart';
import '../Home/Controller/home_controller.dart';
import '../../Service/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../Utils/Constants/routes.dart';
import '../AllCources/Controller/cart_controller.dart';
import '../Quizes/Pages/sectional_quiz.dart';

class AllSectionalPage extends StatefulWidget {
  const AllSectionalPage({Key? key}) : super(key: key);

  @override
  State<AllSectionalPage> createState() => _AllSectionalPageState();
}

class _AllSectionalPageState extends State<AllSectionalPage>
    with SingleTickerProviderStateMixin {
  CurrentAffairsModel? currentAffairsModel;
  List<Datum> freetest = [];
  List<Datum> paidtest = [];
  final detailscontroller = Get.put(AllCoursesController());

  int currentPage = 1;
  int totalItems = 0;
  List<Map<String, dynamic>> paidbought = [];

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
    final response = await ApiService.post(
      key: 'previousyearpaper?page=$currentPage',
      body: {
        "type": "section_time_test",
      },
    );
    if (response != null) {
      if (isUpdate) {
        log("Add");
        currentAffairsModel!.webinars.data!.addAll(
          currentAffairsModelFromJson(response).webinars.data!,
        );
      } else {
        paidbought.clear();
        freetest.clear();
        paidtest.clear();
        currentAffairsModel = currentAffairsModelFromJson(response);
      }
      totalItems = jsonDecode(response)['totalWebinars'];
      currentPage = jsonDecode(response)['webinars']['current_page'];
      for (var element in currentAffairsModel!.webinars.data!) {
        paidbought.add({
          "slug": element.slug,
          "hasBought": false,
          "added": false,
        });
        if (element.price == null || element.price == 0) {
          freetest.add(element);
        } else {
          paidtest.add(element);
        }
      }
      for (var element in currentAffairsModel!.webinars.data!) {
        final data = await checkBuy(slug: element.slug!);
        paidbought[currentAffairsModel!.webinars.data!.indexOf(element)] = {
          "slug": element.slug,
          "hasBought": data,
          "added": false,
        };
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<bool> checkBuy({
    required String slug,
  }) async {
    final response = await ApiService.get(key: "check_buy?slug=$slug");

    if (response != null) {
      if (jsonDecode(response)['statusCode'] == 200) {
        return jsonDecode(response)['data']['hasBought'];
      }
    }
    return false;
  }

  addToCart({
    required int id,
    required int index,
  }) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    final controller = Get.find<AllCoursesController>();
    await controller.addToCart(
      id,
      showNotification: false,
    );
    setState(() {
      paidbought[index]['added'] = true;
    });
    Get.back();
  }

  removeFromCart({
    required int id,
    required int index,
  }) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    final controller = Get.put(CartController());
    await controller.deleteFromCart(id, showNotification: false);
    setState(() {
      paidbought[index]['added'] = false;
    });
    Get.back();
    await controller.getCart();
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
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Full length Mock Test',
          backgroundColor: ColorConst.primaryColor,
          titleColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          child: Column(
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
                      'Free',
                      style: TextStyle(fontSize: 13),
                    )),
                    Tab(
                      child: Text(
                        'Paid',
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
        // floatingActionButton: _footer(context),
      ),
    );
  }

  TabBarView _body() {
    return TabBarView(
      controller: _tabController,
      children: [
        freeTab(),
        paidTab(),
        // reusableTabVideos(),
      ],
    );
  }

  final quizrefreshcontroller = RefreshController(initialRefresh: false);

  final refreshcontroller = RefreshController(initialRefresh: false);

  Widget freeTab() {
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
                ? const Center(
                    child: Text('No Data Found'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: freetest.length,
                    itemBuilder: (BuildContext context, index) {
                      final quiz = freetest[index];
                      return InkWell(
                        onTap: () => Get.to(
                          () => SectionalQuiz(
                            slug: quiz.slug,
                          ),
                        ),
                        child: Container(
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
                                              Text(quiz.title!,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(
                                                height: 2,
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
                                        Get.to(
                                          () => SectionalQuiz(
                                            slug: quiz.slug,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            ColorConst.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Start Quiz',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
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
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget paidTab() {
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
            controller: quizrefreshcontroller,
            onRefresh: () async {
              await getAllQuiz();
              quizrefreshcontroller.refreshCompleted();
            },
            child: currentAffairsModel == null
                ? const Center(
                    child: Text('No Data Found'),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: paidtest.length,
                    itemBuilder: (BuildContext context, index) {
                      final quiz = paidtest[index];
                      return InkWell(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
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
                                              Text(quiz.title!,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(
                                                height: 2,
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
                                        if (paidbought[paidbought.indexWhere(
                                            (element) =>
                                                element['slug'] ==
                                                quiz.slug)]['hasBought']) {
                                          Get.to(
                                            () => SectionalQuiz(
                                              slug: quiz.slug,
                                            ),
                                          );
                                        } else {
                                          if (paidbought[paidbought.indexWhere(
                                                (element) =>
                                                    element['slug'] ==
                                                    quiz.slug,
                                              )]['added'] ==
                                              false) {
                                            addToCart(
                                              id: quiz.id!,
                                              index: paidbought.indexWhere(
                                                (element) =>
                                                    element['slug'] ==
                                                    quiz.slug,
                                              ),
                                            );
                                          } else {
                                            removeFromCart(
                                                id: quiz.id!,
                                                index: paidbought.indexWhere(
                                                  (element) =>
                                                      element['slug'] ==
                                                      quiz.slug,
                                                ));
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor:
                                            ColorConst.primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Icon(
                                          //   !paidbought[paidbought.indexWhere(
                                          //           (element) =>
                                          //               element['slug'] ==
                                          //               quiz.slug)]['hasBought']
                                          //       ? Ionicons.cart_outline
                                          //       : Icons.play_arrow,
                                          // ),
                                          const SizedBox(width: 5),
                                          Text(
                                            paidbought[paidbought.indexWhere(
                                                    (element) =>
                                                        element['slug'] ==
                                                        quiz.slug)]['hasBought']
                                                ? 'Start Quiz'
                                                : paidbought[paidbought
                                                        .indexWhere((element) =>
                                                            element['slug'] ==
                                                            quiz.slug)]['added']
                                                    ? 'Remove from Cart'
                                                    : 'Buy Now',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (paidbought.any((element) => element['added'] == true))
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConst.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Item Added to Cart\n${paidbought.where((element) => element['added'] == true).length} Items",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ColorConst.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(
                        RoutesName.coursesCheckOutPage,
                      );
                    },
                    child: const Text(
                      "Go to Cart",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
