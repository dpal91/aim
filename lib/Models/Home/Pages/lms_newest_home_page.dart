import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../AllCources/Onliner/demo_onliner_page.dart';
import '../../AllCources/Pages/all_courses_pages_details.dart';
import '../../AllCources/Pages/all_study_material.dart';
import '../../Current%20Affair/Pages/current_affair_page.dart';
import '../../DemoSection/Pages/demo_section.dart';
import '../../Forum/Pages/fourm_page.dart';
import '../../Forum/forum_details.dart';
import '../Controller/home_controller.dart';
import '../Widgets/course_builder.dart';
import '../../Profile/Pages/profile_page.dart';
import '../../Quizes/Pages/quizes_page.dart';
import '../../SectionalPage/all_sectional_course.dart';
import '../../../Utils/Constants/global_data.dart';
import '../../../Utils/Wdgets/dialog_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../Utils/BottomNavigation/controller.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../Category/Controller/category_controller.dart';
import '../Widgets/other_widgets.dart';
import 'homepage_shimmer_loading.dart';

class HomePageNewest extends StatefulWidget {
  const HomePageNewest({Key? key}) : super(key: key);

  @override
  State<HomePageNewest> createState() => _HomePageNewestState();
}

class _HomePageNewestState extends State<HomePageNewest> {
  late CarouselController carouselController;
  late HomeController controller;
  late CategoryController coursecontroller;
  late AllCoursesController allCoursesController;
  late BottomNavigationController bottomcontroller;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    debugPrint('LOG : Update');
    carouselController = CarouselController();
    try {
      controller = Get.put(HomeController());
      coursecontroller = Get.put(CategoryController());
      allCoursesController = Get.put(AllCoursesController());
      bottomcontroller = Get.put(BottomNavigationController());
    } catch (e) {
      debugPrint('LOG : Error');
    }
    controller.isLoading(true);

    Future.delayed(const Duration(seconds: 2), () {
      controller.isLoading(false);
      update();
      setState(() {});
    });

    // update();
    setState(() {});
  }

  int activeIndex = 0;

  final box = GetStorage();

  List<String> images = [
    'assets/icons_new/demo.png',
    'assets/currentAffairs.png',
    'assets/quiz2.png',
    /*'assets/previous.png',*/
    'assets/icons_new/clipboard.png',
    'assets/icons_new/document.png',
  ];

  List<String> titles = [
    'Demo Section',
    "Current Affairs",
    "Quizzes",
    /*'Previous Year Papers',*/
    'One Liners / Short Notes',
    'Job Alerts',
  ];

  update() {
    Future.delayed(const Duration(seconds: 5), () => setState(() {}));
  }

  @override
  build(BuildContext context) {
    // controller.getCart();
    return Scaffold(
      backgroundColor: ColorConst.scafoldColor,
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getAllHome();
            },
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: ColorConst.primaryColor,
                  pinned: true,
                  bottom: PreferredSize(
                      preferredSize: Size(Get.width, 10),
                      child: const SizedBox(
                          height:
                              10) /*controller.isLoading.value
                    ? const SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.only(top: 10),
                        height: 110,
                        width: Get.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 5),
                          itemCount: images.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: () {
                                if (index == 0) {
                                  Get.to(() => const DemoSectionPage());
                                }
                                if (index == 1) {
                                  if (isSkippedButtonPressed) {
                                    DialogLogin().dialog(context);
                                  } else {
                                    Get.to(() => const CurrentAffairPage());
                                  }
                                }
                                if (index == 2) {
                                  if (isSkippedButtonPressed) {
                                    DialogLogin().dialog(context);
                                  } else {
                                    Get.to(
                                      () => QuizesPage(
                                        testSeries: controller.testSeries,
                                      ),
                                    );
                                  }
                                }
                                if (index == 3) {
                                  if (isSkippedButtonPressed) {
                                    DialogLogin().dialog(context);
                                  } else {
                                    Get.to(
                                        () => const PreviousPapersPage());
                                  }
                                }
                                if (index == 4) {
                                  if (isSkippedButtonPressed) {
                                    DialogLogin().dialog(context);
                                  } else {
                                    Get.to(() => const OneLinerPage());
                                  }
                                }
                                if (index == 5) {
                                  if (isSkippedButtonPressed) {
                                    DialogLogin().dialog(context);
                                  } else {
                                    Get.to(() => const JobAlertsPage());
                                  }
                                }
                              },
                              child: SizedBox(
                                width: Get.width > 800 ? 140 : 80,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: ColorConst.primaryColor,
                                          width: 0.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor: ColorConst
                                            .primaryColor
                                            .withOpacity(0.05),
                                        radius: 25,
                                        child: ImageIcon(
                                          AssetImage(images[index]),
                                          size: 30,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      titles[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        // fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),*/
                      ),
                  collapsedHeight: 60,
                  title: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (isSkippedButtonPressed) {
                            DialogLogin().dialog(context);
                          } else {
                            ZoomDrawer.of(context)!.toggle();
                          }
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isSkippedButtonPressed) {
                            DialogLogin().dialog(context);
                          } else {
                            final tabController =
                                Get.find<BottomNavigationController>();
                            tabController.changeTabIndex(1);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'AIM PARIKSHA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              GetBuilder<CategoryController>(
                                init: CategoryController(),
                                builder: (categoryController) {
                                  return Row(
                                    children: [
                                      Text(
                                        categoryController.isLoading.value
                                            ? "Loading.."
                                            : categoryController.browseCategory
                                                .where(
                                                  (element) =>
                                                      element.id ==
                                                      box.read(
                                                        RoutesName.categoryId,
                                                      ),
                                                )
                                                .first
                                                .title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.expand_more_rounded,
                                        color: Colors.white,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    controller.isLoading.value
                        ? const SizedBox.shrink()
                        : InkWell(
                            onTap: () {
                              if (isSkippedButtonPressed) {
                                DialogLogin().dialog(context);
                              } else {
                                Get.toNamed(RoutesName.searchPage);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(top: 20, right: 5),
                              child: Icon(Icons.search),
                            )),
                    Visibility(
                      visible: false,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 20, right: 5),
                        child: GestureDetector(
                          onTap: () {
                            if (isSkippedButtonPressed) {
                              DialogLogin().dialog(context);
                            } else {
                              Get.toNamed(RoutesName.notificationPage);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.notifications, size: 20),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (isSkippedButtonPressed) {
                          DialogLogin().dialog(context);
                        } else {
                          Get.to(() => const ProfilePage());
                        }
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 20, right: 10),
                        child: Obx(
                          () => CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: CachedNetworkImageProvider(
                                controller.profileDetails['profile_image'] ==
                                            "" ||
                                        controller.profileDetails[
                                                'profile_image'] ==
                                            null
                                    ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                                    : controller
                                        .profileDetails['profile_image'],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: controller.isLoading.value
                      ? const HomePageShimmerLoading()
                      : Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  height: 110,
                                  width: Get.width,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: ListView.builder(
                                    padding: const EdgeInsets.only(left: 5),
                                    itemCount: images.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CupertinoButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          if (index == 0) {
                                            Get.to(
                                                () => const DemoSectionPage());
                                          }
                                          if (index == 1) {
                                            if (isSkippedButtonPressed) {
                                              DialogLogin().dialog(context);
                                            } else {
                                              Get.to(() =>
                                                  const CurrentAffairPage());
                                            }
                                          }
                                          if (index == 2) {
                                            if (isSkippedButtonPressed) {
                                              DialogLogin().dialog(context);
                                            } else {
                                              Get.to(
                                                () => QuizesPage(
                                                  testSeries:
                                                      controller.testSeries,
                                                ),
                                              );
                                            }
                                          }
                                          if (index == 3) {
                                            if (isSkippedButtonPressed) {
                                              DialogLogin().dialog(context);
                                            } else {
                                              Get.to(
                                                  () => const OneLinerPage());
                                            }

                                            /* if (isSkippedButtonPressed) {
                                          DialogLogin().dialog(context);
                                        } else {
                                          Get.to(
                                                  () => const PreviousPapersPage());
                                        }*/
                                          }
                                          /*if (index == 4) {
                                        if (isSkippedButtonPressed) {
                                          DialogLogin().dialog(context);
                                        } else {
                                          Get.to(
                                              () => const OneLinerPage());
                                        }
                                      }*/
                                          if (index == 4) {
                                            if (isSkippedButtonPressed) {
                                              DialogLogin().dialog(context);
                                            } else {
                                              Get.to(
                                                  () => const JobAlertsPage());
                                            }
                                          }
                                        },
                                        child: SizedBox(
                                          width: Get.width > 800 ? 140 : 80,
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        ColorConst.primaryColor,
                                                    width: 0.5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: CircleAvatar(
                                                  backgroundColor: ColorConst
                                                      .primaryColor
                                                      .withOpacity(0.05),
                                                  radius: 25,
                                                  child: ImageIcon(
                                                    AssetImage(images[index]),
                                                    size: 30,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                titles[index],
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  // fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                if (controller.images.isNotEmpty)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (controller.images.isNotEmpty)
                                  Center(
                                    child: CarouselSlider.builder(
                                      itemCount: controller.images.length,
                                      itemBuilder: (context, index, realIndex) {
                                        final image = controller.images[index];
                                        return buildImage(image);
                                      },
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        viewportFraction: 1,
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                (controller.homeData?.data?.freeWebinars
                                            .isEmpty ??
                                        true)
                                    ? const SizedBox.shrink()
                                    : reusableTitle(
                                        'Demo Lectures',
                                        context,
                                        controller.homeData!.data!.freeWebinars
                                            .where((element) =>
                                                element.type == "course")
                                            .toList(),
                                        isDemo: true,
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                (controller.homeData?.data?.freeWebinars
                                            .isEmpty ??
                                        true)
                                    ? const SizedBox.shrink()
                                    : Container(
                                        height: controller
                                                .homeData!.data!.freeWebinars
                                                .any((element) =>
                                                    element.title.length < 25)
                                            ? 220
                                            : 200,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ListView.separated(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: controller.homeData!.data!
                                                      .freeWebinars
                                                      .where((element) =>
                                                          element.type ==
                                                          "course")
                                                      .toList()
                                                      .length >
                                                  6
                                              ? 6
                                              : controller
                                                  .homeData!.data!.freeWebinars
                                                  .where((element) =>
                                                      element.type == "course")
                                                  .toList()
                                                  .length,
                                          itemBuilder: (context, index) {
                                            // return Container();
                                            return coursesBuilder(
                                              controller
                                                  .homeData!.data!.freeWebinars
                                                  .where((element) =>
                                                      element.type == "course")
                                                  .toList(),
                                              context,
                                              index,
                                              isDemo: true,
                                            );
                                          },
                                          separatorBuilder: (context, _) =>
                                              const SizedBox(
                                            width: 0,
                                          ),
                                        ),
                                      ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 8,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                (controller.homeData?.data?.latestWebinars
                                            .isEmpty ??
                                        true)
                                    ? const SizedBox.shrink()
                                    : reusableTitle(
                                        'Live Courses',
                                        context,
                                        controller
                                            .homeData!.data!.latestWebinars
                                            .where((element) =>
                                                element.type == "webinar")
                                            .toList(),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                (controller.homeData?.data?.latestWebinars
                                            .isEmpty ??
                                        true)
                                    ? const SizedBox.shrink()
                                    : Container(
                                        height: 230,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: controller.homeData!.data!
                                                .latestWebinars.isEmpty
                                            ? const Center(
                                                child: Text(
                                                    "No live classes latest webinar available!"),
                                              )
                                            : ListView.separated(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                itemCount: controller
                                                            .homeData!
                                                            .data!
                                                            .latestWebinars
                                                            .where((element) =>
                                                                element.type ==
                                                                "webinar")
                                                            .length >
                                                        6
                                                    ? 6
                                                    : controller.homeData!.data!
                                                        .latestWebinars
                                                        .where((element) =>
                                                            element.type ==
                                                            "webinar")
                                                        .length,
                                                itemBuilder: (context, index) =>
                                                    coursesBuilder(
                                                        controller
                                                            .homeData!
                                                            .data!
                                                            .latestWebinars
                                                            .where((element) =>
                                                                element.type ==
                                                                "webinar")
                                                            .toList(),
                                                        context,
                                                        index),
                                                separatorBuilder:
                                                    (context, _) =>
                                                        const SizedBox(
                                                  width: 0,
                                                ),
                                              ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 8,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                reusableTitle(
                                    'Demo Study Material',
                                    context,
                                    controller.studymaterial
                                        .where((element) =>
                                            element.price == null ||
                                            element.price == 0)
                                        .toList(),
                                    isStudy: true,
                                    isDemo: true),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: controller.studymaterial
                                          .where((element) =>
                                              element.price == null ||
                                              element.price == 0)
                                          .any((element) =>
                                              element.title.length > 25)
                                      ? 230
                                      : 210,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ListView.separated(
                                    padding: const EdgeInsets.only(left: 10),
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.studymaterial
                                                .where((element) =>
                                                    element.price == null ||
                                                    element.price == 0)
                                                .length >
                                            6
                                        ? 6
                                        : controller.studymaterial
                                            .where((element) =>
                                                element.price == null ||
                                                element.price == 0)
                                            .length,
                                    itemBuilder: (context, index) {
                                      return coursesBuilder(
                                        controller.studymaterial
                                            .where((element) =>
                                                element.price == null ||
                                                element.price == 0)
                                            .toList(),
                                        context,
                                        index,
                                        isDemo: true,
                                        isStudy: true,
                                      );
                                    },
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(
                                      width: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 8,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                reusableTitle(
                                  'Online Study Material',
                                  context,
                                  controller.studymaterial
                                      .where((element) =>
                                          element.price != 0 &&
                                          element.price != null)
                                      .toList(),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: controller.studymaterial
                                          .where((element) =>
                                              element.price != null ||
                                              element.price != 0)
                                          .any((element) =>
                                              element.title.length > 25)
                                      ? 230
                                      : 210,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ListView.separated(
                                    padding: const EdgeInsets.only(left: 10),
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.studymaterial
                                                .where((element) =>
                                                    element.price != 0 &&
                                                    element.price != null)
                                                .length >
                                            6
                                        ? 6
                                        : controller.studymaterial
                                            .where((element) =>
                                                element.price != 0 &&
                                                element.price != null)
                                            .length,
                                    itemBuilder: (context, index) =>
                                        coursesBuilder(
                                      controller.studymaterial
                                          .where((element) =>
                                              element.price != 0 &&
                                              element.price != null)
                                          .toList(),
                                      context,
                                      index,
                                    ),
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(
                                      width: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 8,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (isSkippedButtonPressed) {
                                          DialogLogin().dialog(context);
                                        } else {
                                          Get.to(
                                            () => AllStudyMaterialPage(
                                              studymaterials: controller
                                                  .studymaterial
                                                  .where((element) =>
                                                      element.price != 0 &&
                                                      element.price != null)
                                                  .toList(),
                                            ),
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Click here to get Subject wise ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Study Material",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 15,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/blog.png',
                                              height: double.infinity,
                                              width: 110,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 8,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                reusableTitle(
                                    'Demo Test Series',
                                    context,
                                    controller.testSeries
                                        .where((element) =>
                                            element.price == null ||
                                            element.price == 0)
                                        .toList(),
                                    isTest: true,
                                    isDemo: true),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: controller.testSeries
                                          .where((element) =>
                                              element.price == null ||
                                              element.price == 0)
                                          .any((element) =>
                                              element.title.length > 25)
                                      ? 230
                                      : 210,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(left: 10),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.testSeries
                                                .where((element) =>
                                                    element.price == null ||
                                                    element.price == 0)
                                                .length >
                                            6
                                        ? 6
                                        : controller.testSeries
                                            .where((element) =>
                                                element.price == null ||
                                                element.price == 0)
                                            .length,
                                    itemBuilder: (context, index) =>
                                        coursesBuilder(
                                            controller
                                                .testSeries
                                                .where((element) =>
                                                    element.price == null ||
                                                    element.price == 0)
                                                .toList(),
                                            context,
                                            index,
                                            istest: true,
                                            isDemo: true),
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(
                                      width: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 8,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Visibility(
                                  visible: false,
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          if (isSkippedButtonPressed) {
                                            DialogLogin().dialog(context);
                                          } else {
                                            Get.to(
                                              () => const AllSectionalPage(),
                                            );
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Click here to get ",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Full Length Mock Test",
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Image.asset(
                                                'assets/blog.png',
                                                height: double.infinity,
                                                width: 110,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                /*const SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.2),
                              thickness: 8,
                            ),*/
                                const SizedBox(
                                  height: 20,
                                ),
                                reusableTitle(
                                    'Online Test Series',
                                    context,
                                    controller.testSeries
                                        .where((element) =>
                                            element.price != 0 &&
                                            element.price != null)
                                        .toList()),
                                Container(
                                  height: controller.testSeries.any((element) =>
                                          element.title.length > 25)
                                      ? 230
                                      : 210,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: ListView.separated(
                                    padding: const EdgeInsets.only(left: 10),
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: controller.testSeries
                                                .where((element) =>
                                                    element.price != 0 &&
                                                    element.price != null)
                                                .length >
                                            6
                                        ? 6
                                        : controller.testSeries
                                            .where((element) =>
                                                element.price != 0 &&
                                                element.price != null)
                                            .length,
                                    itemBuilder: (context, index) =>
                                        coursesBuilder(
                                      controller.testSeries
                                          .where((element) =>
                                              element.price != 0 &&
                                              element.price != null)
                                          .toList(),
                                      context,
                                      index,
                                    ),
                                    separatorBuilder: (context, _) =>
                                        const SizedBox(
                                      width: 0,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 8,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 100,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        if (isSkippedButtonPressed) {
                                          DialogLogin().dialog(context);
                                        } else {
                                          Get.to(
                                            () => AllStudyMaterialPage(
                                              studymaterials: controller
                                                  .testSeries
                                                  .where((element) =>
                                                      element.price != 0 &&
                                                      element.price != null)
                                                  .toList(),
                                              title: "Online Test Series",
                                            ),
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Click here to get Subject wise ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Test Series",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        size: 15,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/blog.png',
                                              height: double.infinity,
                                              width: 110,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 8,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                (controller.homeData?.data?.latestWebinars
                                            .isEmpty ??
                                        true)
                                    ? const SizedBox.shrink()
                                    : reusableTitle(
                                        'Recorded Lectures',
                                        context,
                                        controller
                                            .homeData!.data!.latestWebinars
                                            .where((element) =>
                                                element.type == "recorded")
                                            .toList()),
                                const SizedBox(
                                  height: 10,
                                ),
                                (controller.homeData?.data?.latestWebinars
                                            .isEmpty ??
                                        true)
                                    ? const SizedBox.shrink()
                                    : Container(
                                        height: controller
                                                .homeData!.data!.latestWebinars
                                                .where((element) =>
                                                    element.type == "recorded")
                                                .toList()
                                                .any((element) =>
                                                    element.title.length > 20)
                                            ? 230
                                            : 200,
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ListView.separated(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: controller.homeData!.data!
                                                      .latestWebinars
                                                      .where((element) =>
                                                          element.type ==
                                                          "recorded")
                                                      .toList()
                                                      .length >
                                                  6
                                              ? 6
                                              : controller.homeData!.data!
                                                  .latestWebinars
                                                  .where((element) =>
                                                      element.type ==
                                                      "recorded")
                                                  .toList()
                                                  .length,
                                          itemBuilder: (context, index) =>
                                              coursesBuilder(
                                                  controller.homeData!.data!
                                                      .latestWebinars
                                                      .where((element) =>
                                                          element.type ==
                                                          "recorded")
                                                      .toList(),
                                                  context,
                                                  index),
                                          separatorBuilder: (context, _) =>
                                              const SizedBox(width: 0),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Divider(
                                //   color: Colors.grey.withOpacity(0.2),
                                //   thickness: 8,
                                // ),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                // reusableTitle(
                                //     'Crash Course', controller.crashCourse),
                                // const SizedBox(
                                //   height: 10,
                                // ),
                                // Container(
                                //   height: controller.crashCourse.any(
                                //           (element) =>
                                //               element.title.length > 20)
                                //       ? 230
                                //       : 200,
                                //   margin: const EdgeInsets.only(bottom: 30),
                                //   child: ListView.separated(
                                //     scrollDirection: Axis.horizontal,
                                //     padding: const EdgeInsets.only(left: 10),
                                //     physics: const BouncingScrollPhysics(),
                                //     itemCount: controller.crashCourse.length > 6
                                //         ? 6
                                //         : controller.crashCourse.length,
                                //     itemBuilder: (context, index) =>
                                //         coursesBuilder(
                                //             controller.crashCourse, index),
                                //     separatorBuilder: (context, _) =>
                                //         const SizedBox(
                                //       width: 0,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  buildImage(var image) {
    return InkWell(
      onTap: () {
        if (isSkippedButtonPressed) {
          DialogLogin().dialog(context);
        } else {
          final controller = Get.put(AllCoursesController());
          controller.getAllCourseDetails(image['link']);
          Get.to(() => AllCoursesPageDetails());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: CachedNetworkImage(
          imageUrl: RoutesName.baseImageUrl + image['image'],
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  notificationBuilder(currentAffair) {
    return Container(
      width: Get.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentAffair['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Image.asset(
                        'assets/calendar.png',
                        width: 15,
                        height: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat('dd MMM yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            currentAffair['created_at'] * 1000,
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (isSkippedButtonPressed) {
                DialogLogin().dialog(context);
              } else {
                Get.to(
                  () => JobDetails(job: currentAffair),
                );
              }
            },
            child: Container(
              width: Get.width * 0.4,
              height: 35,
              decoration: BoxDecoration(
                color: ColorConst.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Row(
                children: [
                  Text(
                    'Read More',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
