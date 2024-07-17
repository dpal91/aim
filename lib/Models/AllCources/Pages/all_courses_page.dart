import 'package:cached_network_image/cached_network_image.dart';
import '../Controller/all_courses_controller.dart';
import '../../../Utils/BottomNavigation/controller.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/constans_assets.dart';
import '../../Favouties/Controller/favourite_controller.dart';
import '../../Profile/Pages/view_conversations.dart';
import '../../Profile/model/raise_support_data.dart';
import 'all_courses_pages_details.dart';

class AllCoursesPage extends StatefulWidget {
  final bool showbar;
  const AllCoursesPage({Key? key, this.showbar = true}) : super(key: key);

  @override
  State<AllCoursesPage> createState() => _AllCoursesPageState();
}

class _AllCoursesPageState extends State<AllCoursesPage> {
  AllCoursesController acontroller = Get.put(AllCoursesController());
  List<String> tags = [
    "Purchased",
    "Doubts",
    "Bookmarks",
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      acontroller.getAllCourse();
      getSupportData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tags.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: const Text(
            "My Content",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: ColorConst.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              if (widget.showbar) {
                Get.back();
              } else {
                final controller = Get.find<BottomNavigationController>();
                controller.changeTabIndex(0);
              }
            },
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: tags.map((e) {
                return Tab(
                  child: Text(
                    e,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() {
                    return controller.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : acontroller.purchasedCourseData.isEmpty
                            ? const Center(
                                child: Text(
                                  "No Courses Found",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    acontroller.purchasedCourseData.length,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, index) {
                                  final item = acontroller
                                      .purchasedCourseData[index].webinar!;
                                  return InkWell(
                                    onTap: () {
                                      acontroller
                                          .getAllCourseDetails(item.slug!);
                                      Get.toNamed(
                                          RoutesName.allCoursesPageDetails);
                                    },
                                    child: Container(
                                      width: 160,
                                      height: 100,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                            offset: const Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 80,
                                            width: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${RoutesName.baseImageUrl}${acontroller.purchasedCourseData[index].webinar!.thumbnail}",
                                                fit: BoxFit.cover,
                                                height: 80,
                                                width: 120,
                                                placeholder: (context, url) =>
                                                    Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                          Images.logo,
                                                        ),
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                        Images.logo,
                                                      ),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  acontroller
                                                      .purchasedCourseData[
                                                          index]
                                                      .webinar!
                                                      .title!,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        // color: ColorConst.primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: const Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
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
                                                            Icons
                                                                .arrow_forward_ios,
                                                            color: Colors.red,
                                                            size: 12,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                  }),
                  doubtsSection(),
                  bookmarkCourses(),
                ],
              ),
            ),
          ],
        ),
      ),
      // body: Column(
      //   children: [
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     // SizedBox(
      //     //   height: 40,
      //     //   width: Get.width,
      //     //   child: ListView.separated(
      //     //     padding: const EdgeInsets.symmetric(
      //     //       horizontal: 10,
      //     //     ),
      //     //     separatorBuilder: (BuildContext context, int index) {
      //     //       return const SizedBox(
      //     //         width: 5,
      //     //       );
      //     //     },
      //     //     itemCount: tags.length,
      //     //     scrollDirection: Axis.horizontal,
      //     //     itemBuilder: (BuildContext context, index) {
      //     //       return GestureDetector(
      //     //         onTap: () {
      //     //           setState(() {
      //     //             selectedIndex = index;
      //     //           });
      //     //         },
      //     //         child: Container(
      //     //           padding: const EdgeInsets.symmetric(horizontal: 10),
      //     //           decoration: BoxDecoration(
      //     //             color: selectedIndex == index
      //     //                 ? ColorConst.primaryColor.withOpacity(0.15)
      //     //                 : Colors.white,
      //     //             borderRadius: BorderRadius.circular(30),
      //     //             border: Border.all(
      //     //               color: selectedIndex == index
      //     //                   ? ColorConst.primaryColor
      //     //                   : Colors.grey,
      //     //             ),
      //     //           ),
      //     //           child: Center(
      //     //             child: Text(
      //     //               tags[index],
      //     //               style: TextStyle(
      //     //                 color: selectedIndex == index
      //     //                     ? Colors.black
      //     //                     : Colors.black,
      //     //                 fontSize: 13,
      //     //               ),
      //     //             ),
      //     //           ),
      //     //         ),
      //     //       );
      //     //     },
      //     //   ),
      //     // ),
      //     // const SizedBox(
      //     //   height: 10,
      //     // ),

      //     Expanded(
      //       child: IndexedStack(
      //         index: selectedIndex,
      //         children: [
      //           Obx(() {
      //             return controller.isLoading.value
      //                 ? const Center(child: CircularProgressIndicator())
      //                 : acontroller.purchasedCourseData.isEmpty
      //                     ? const Center(
      //                         child: Text(
      //                           "No Courses Found",
      //                           style: TextStyle(
      //                             color: Colors.black,
      //                             fontSize: 20,
      //                           ),
      //                         ),
      //                       )
      //                     : ListView.builder(
      //                         shrinkWrap: true,
      //                         itemCount:
      //                             acontroller.purchasedCourseData.length,
      //                         // physics: const NeverScrollableScrollPhysics(),
      //                         itemBuilder: (BuildContext context, index) {
      //                           final item = acontroller
      //                               .purchasedCourseData[index].webinar!;
      //                           return InkWell(
      //                             onTap: () {
      //                               acontroller
      //                                   .getAllCourseDetails(item.slug!);
      //                               Get.toNamed(
      //                                   RoutesName.allCoursesPageDetails);
      //                             },
      //                             child: Container(
      //                               width: 160,
      //                               height: 100,
      //                               padding: const EdgeInsets.symmetric(
      //                                   vertical: 10, horizontal: 10),
      //                               margin: const EdgeInsets.symmetric(
      //                                   vertical: 10, horizontal: 20),
      //                               decoration: BoxDecoration(
      //                                 color: Colors.white,
      //                                 borderRadius: BorderRadius.circular(10),
      //                                 boxShadow: [
      //                                   BoxShadow(
      //                                     color: Colors.grey.withOpacity(0.2),
      //                                     spreadRadius: 1,
      //                                     blurRadius: 1,
      //                                     offset: const Offset(0,
      //                                         1), // changes position of shadow
      //                                   ),
      //                                 ],
      //                               ),
      //                               child: Row(
      //                                 crossAxisAlignment:
      //                                     CrossAxisAlignment.start,
      //                                 children: [
      //                                   SizedBox(
      //                                     height: 80,
      //                                     width: 120,
      //                                     child: ClipRRect(
      //                                       borderRadius:
      //                                           BorderRadius.circular(10),
      //                                       child: CachedNetworkImage(
      //                                         imageUrl:
      //                                             "${RoutesName.baseImageUrl}${acontroller.purchasedCourseData[index].webinar!.thumbnail}",
      //                                         fit: BoxFit.cover,
      //                                         height: 80,
      //                                         width: 120,
      //                                         placeholder: (context, url) =>
      //                                             Container(
      //                                           decoration: BoxDecoration(
      //                                             image: DecorationImage(
      //                                                 image: AssetImage(
      //                                                   Images.logo,
      //                                                 ),
      //                                                 fit: BoxFit.fill),
      //                                           ),
      //                                         ),
      //                                         errorWidget:
      //                                             (context, url, error) =>
      //                                                 Container(
      //                                           decoration: BoxDecoration(
      //                                             image: DecorationImage(
      //                                               image: AssetImage(
      //                                                 Images.logo,
      //                                               ),
      //                                               fit: BoxFit.fill,
      //                                             ),
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     ),
      //                                   ),
      //                                   const SizedBox(width: 10),
      //                                   Expanded(
      //                                     child: Column(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment
      //                                               .spaceBetween,
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.start,
      //                                       children: [
      //                                         Text(
      //                                           acontroller
      //                                               .purchasedCourseData[
      //                                                   index]
      //                                               .webinar!
      //                                               .title!,
      //                                           style: const TextStyle(
      //                                             color: Colors.black,
      //                                             fontSize: 13,
      //                                             fontWeight: FontWeight.bold,
      //                                           ),
      //                                         ),
      //                                         Row(
      //                                           mainAxisAlignment:
      //                                               MainAxisAlignment.end,
      //                                           children: [
      //                                             Container(
      //                                               height: 35,
      //                                               decoration: BoxDecoration(
      //                                                 // color: ColorConst.primaryColor,
      //                                                 borderRadius:
      //                                                     BorderRadius
      //                                                         .circular(10),
      //                                               ),
      //                                               padding: const EdgeInsets
      //                                                       .symmetric(
      //                                                   horizontal: 8.0),
      //                                               child: const Row(
      //                                                 mainAxisSize:
      //                                                     MainAxisSize.min,
      //                                                 children: [
      //                                                   Text(
      //                                                     'View',
      //                                                     style: TextStyle(
      //                                                       color: Colors.red,
      //                                                       fontSize: 12,
      //                                                       // fontWeight: FontWeight.bold,
      //                                                     ),
      //                                                   ),
      //                                                   Icon(
      //                                                     Icons
      //                                                         .arrow_forward_ios,
      //                                                     color: Colors.red,
      //                                                     size: 12,
      //                                                   ),
      //                                                 ],
      //                                               ),
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                           );
      //                         },
      //                       );
      //           }),
      //           doubtsSection(),
      //           bookmarkCourses(),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  AllSupportModel? supportData;

  bool isLoading = false;

  getSupportData() async {
    try {
      setState(() {
        isLoading = true;
      });
      final data = await ApiService.get(key: 'support/tickets');
      setState(() {
        supportData = allSupportModelFromJson(data);
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Err : getSupportData $e");
    }
  }

  Widget doubtsSection() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (supportData!.data!.supports!.isEmpty) {
      return const Center(
        child: Text("No Data Found"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      itemCount: supportData!.data!.supports!.length,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final data = supportData!.data!.supports![index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
            onTap: () {
              Get.to(
                () => ViewConverSations(
                  support: data,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey[200]!,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Ionicons.chatbox_ellipses_outline,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              data.status!.toUpperCase(),
                              style: TextStyle(
                                color: data.status == 'close'
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.conversations!.isNotEmpty
                                    ? data.conversations![0].message!
                                    : "No message",
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
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
        );
      },
    );
  }

  FavouriteController controller = Get.put(FavouriteController());
  Widget bookmarkCourses() {
    if (controller.favouriteList.isEmpty) {
      return const Center(
        child: Text('No Courses Bookmarked'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.favouriteList.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            acontroller.getAllCourseDetails(
              controller.favouriteList[index].webinar.slug,
            );
            Get.to(
              () => AllCoursesPageDetails(
                isDemo: controller.favouriteList[index].webinar.price == 0
                    ? true
                    : false,
              ),
            );
          },
          child: Container(
            width: 160,
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 120,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        RoutesName.baseImageUrl +
                            controller.favouriteList[index].webinar.thumbnail,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(
                          controller.favouriteList[index].webinar.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              // color: ColorConst.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
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
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ListView myCoursesBuilder() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: acontroller.purchasedCourseData.length,
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, .1),
            ),
          ], borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                "${RoutesName.baseImageUrl}${acontroller.purchasedCourseData[index].webinar!.thumbnail}",
                            fit: BoxFit.cover,
                            height: 100,
                            width: 150,
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      Images.logo,
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      Images.logo,
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          // height: 30,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: const Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Text(
                                  "5.0 ",
                                  style: TextStyle(fontSize: 9),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment:
                        //       MainAxisAlignment
                        //           .spaceBetween,
                        //   children: [
                        //     Container(
                        //       height: 20,
                        //       padding:
                        //           const EdgeInsets.all(5),
                        //       decoration: BoxDecoration(
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Colors.green
                        //                   .withOpacity(0.1),
                        //               spreadRadius: 2,
                        //               blurRadius: 1,
                        //               offset: const Offset(
                        //                   0, .1),
                        //             ),
                        //           ],
                        //           borderRadius:
                        //               BorderRadius.circular(
                        //                   7)),
                        //       child: Center(
                        //         child: Text(
                        //           'Design',
                        //           style: TextStyle(
                        //               color: Colors.green,
                        //               fontSize: 8,
                        //               fontWeight:
                        //                   FontWeight.w500),
                        //         ),
                        //       ),
                        //     ),
                        //     Icon(
                        //       Icons.bookmark_border_rounded,
                        //       color:Colors.black,
                        //       size: 18,
                        //     )
                        //   ],
                        // ),

                        Text(
                          acontroller
                              .purchasedCourseData[index].webinar!.title!,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.access_time_filled_rounded,
                                  size: 13,
                                  color: Colors.grey,
                                ),
                                Text(
                                  ' 1 hour',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "\$${acontroller.purchasedCourseData[index].webinar!.price} ",
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 12),
                                ),
                                Text(
                                  acontroller
                                      .purchasedCourseData[index].discount
                                      .toString(),
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        // FittedBox(
                        //   child: Row(
                        //     children: [
                        //       Icon(
                        //         Icons.star,
                        //         color: Colors.yellow[800],
                        //         size: 15,
                        //       ),
                        //       Row(
                        //         children: const [
                        //           Padding(
                        //             padding:
                        //                 EdgeInsets.only(
                        //                     top: 2.0),
                        //             child: Text(
                        //               " 4.8 | ",
                        //               style: TextStyle(
                        //                   color: Colors
                        //                       .black87,fontSize: 12),
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding:
                        //                 EdgeInsets.only(
                        //                     top: 2.0),
                        //             child: Text(
                        //                 "8,289 students",
                        //                 style: TextStyle(
                        //                     color: Colors
                        //                         .black87,fontSize: 12)),
                        //           )
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 2.0, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Text(
                          'Health & Fitness',
                          style: TextStyle(fontSize: 11, color: Colors.black),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Text(
                          '01 Jul 2022',
                          style: TextStyle(fontSize: 11, color: Colors.black),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
