// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:get/get.dart';

// import '../../../Utils/Constants/constans_assets.dart';
// import '../../../Utils/Constants/constants_colors.dart';
// import '../../../Utils/Constants/routes.dart';
// import '../../../Utils/Wdgets/textfield.dart';
// import '../../All Cources/Controller/all_courses_controller.dart';
// import '../Controller/home_controller.dart';
// import '../Class/categories_lists.dart';
// import '../Class/const_classes.dart';
// import '../Widgets/other_widgets.dart';

// final List images = [];
// int activeIndex = 0;

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

//   final carouselController = CarouselController();
//   HomeController controller = Get.put(HomeController());
//   AllCoursesController allCoursesController = Get.put(AllCoursesController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       // HomeData? data = controller.homeData;
//       // if (data != null) {
//       //   images.add(controller.homeData!.advertisingBanners1[0].image);
//       //   images.add(controller.homeData!.advertisingBanners2["1"]!.image);
//       //   images.add(controller.homeData!.advertisingBanners2["2"]!.image);
//       // }
//       return Scaffold(
//           body: controller.isLoading.value
//               ? const Center(child: CircularProgressIndicator())
//               // : CustomScrollView(
//               //     slivers: [
//               //       SliverAppBar(
//               //         expandedHeight: 170,
//               //         backgroundColor: ColorConst.primaryColor,
//               //         pinned: true,
//               //         collapsedHeight: 70,
//               //         leading: Padding(
//               //           padding: const EdgeInsets.only(left: 18.0, top: 10),
//               //           child: GestureDetector(
//               //             onTap: () {
//               //               ZoomDrawer.of(context)!.toggle();
//               //             },
//               //             child: const Icon(
//               //               Icons.category_rounded,
//               //               size: 40,
//               //             ),
//               //           ),
//               //         ),
//               //         title: Padding(
//               //           padding: const EdgeInsets.only(top: 10.0, bottom: 4),
//               //           child: Column(
//               //               crossAxisAlignment: CrossAxisAlignment.start,
//               //               children: <Widget>[
//               //                 Row(
//               //                   children: const [
//               //                     Text(
//               //                       'Hey',
//               //                       style: TextStyle(
//               //                           color: Colors.white,
//               //                           fontSize: 18,
//               //                           fontFamily: "Nunito",
//               //                           fontWeight: FontWeight.w900),
//               //                     ),
//               //                     Padding(
//               //                       padding: EdgeInsets.only(left: 8.0),
//               //                       child: Icon(
//               //                         Icons.waving_hand,
//               //                         size: 15,
//               //                       ),
//               //                     )
//               //                   ],
//               //                 ),
//               //                 const Text(
//               //                   "Andrew Ansley",
//               //                   style: TextStyle(
//               //                       color: Colors.white,
//               //                       fontFamily: "Nunito",
//               //                       fontSize: 19,
//               //                       letterSpacing: 1,
//               //                       fontWeight: FontWeight.w900),
//               //                 ),
//               //               ]),
//               //         ),
//               //         actions: [
//               //           Padding(
//               //             padding: const EdgeInsets.only(right: 8.0, top: 10),
//               //             child: SvgPicture.asset(
//               //               Images.svgNotification,
//               //               height: 22,
//               //               width: 22,
//               //               color: Colors.white,
//               //             ),
//               //           ),
//               //           Padding(
//               //             padding: const EdgeInsets.only(right: 8.0, top: 10),
//               //             child: SvgPicture.asset(
//               //               Images.svgBookmark,
//               //               height: 22,
//               //               color: Colors.white,
//               //               width: 15,
//               //             ),
//               //           ),
//               //         ],
//               //         bottom: PreferredSize(
//               //             preferredSize: const Size.fromHeight(56),
//               //             child: Padding(
//               //               padding: const EdgeInsets.only(
//               //                   left: 10.0, right: 10.0, bottom: 8),
//               //               child: SizedBox(
//               //                 height: 47,
//               //                 child: MyTextFormField(
//               //                   hintText: "Search",
//               //                   prefixIcon: const Padding(
//               //                     padding: EdgeInsets.only(left: 10, bottom: 4),
//               //                     child: Icon(Icons.search),
//               //                   ),
//               //                   suffixIcon: Padding(
//               //                     padding:
//               //                         const EdgeInsets.symmetric(horizontal: 15),
//               //                     child: InkWell(
//               //                       onTap: () {},
//               //                       child: SvgPicture.asset(Images.svgFilter),
//               //                     ),
//               //                   ),
//               //                 ),
//               //               ),
//               //             )),
//               //       ),
//               //       SliverToBoxAdapter(
//               //         child: Padding(
//               //           padding: const EdgeInsets.symmetric(horizontal: 10),
//               //           child: Column(
//               //             children: [
//               //               _body(context),
//               //               const SizedBox(
//               //                 height: 30,
//               //               ),
//               //               _footer(context)
//               //             ],
//               //           ),
//               //         ),
//               //       )
//               //     ],
//               //   ),
//               : Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Container(
//                           height: Get.height / 6,
//                           width: double.infinity,
//                           decoration: const BoxDecoration(
//                               gradient: LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Color(0XFF99ff99),
//                                     Color(0XFF00cc66),
//                                   ]),
//                               borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(25),
//                                 bottomRight: Radius.circular(25),
//                               )),
//                           child: Column(
//                             children: [
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).viewPadding.top + 30,
//                               ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 20, right: 0),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.only(top: 5),
//                                       child: Icon(
//                                         Icons.menu,
//                                         color: Colors.white,
//                                         size: 30,
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 15,
//                                     ),
//                                     Column(
//                                       children: const [
//                                         Text(
//                                           "UPSC",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 21,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.white,
//                                       size: 30,
//                                     ),
//                                     SizedBox(
//                                       width: Get.width / 5.5,
//                                     ),
//                                     Container(
//                                       height: 42,
//                                       width: 42,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(13),
//                                           color: Colors.black.withOpacity(0.2)),
//                                       child: const Center(
//                                         child: Icon(
//                                           Icons.search,
//                                           color: Colors.white,
//                                           size: 20,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     Container(
//                                       height: 42,
//                                       width: 42,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(13),
//                                           color: Colors.black.withOpacity(0.2)),
//                                       child: const Center(
//                                         child: Icon(
//                                           Icons.shopping_cart,
//                                           color: Colors.white,
//                                           size: 20,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     Container(
//                                       height: 42,
//                                       width: 42,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(13),
//                                           color: Colors.black.withOpacity(0.2)),
//                                       child: const Center(
//                                         child: Icon(
//                                           Icons.notification_add,
//                                           color: Colors.white,
//                                           size: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         _body(context),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         _footer(context)
//                       ],
//                     ),
//                   ),
//                 ));
//     });
//   }

//   Widget _footer(BuildContext context) {
//     var data = controller.homeData!;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         children: [
//           _courseCategories(
//               title: 'UpComing Courses',
//               itemBuilder: (context, index) => InkWell(
//                   onTap: () {
//                     Get.toNamed(RoutesName.allCoursesPageDetails);
//                     allCoursesController.getAllCourseDetails(
//                         controller.homeData!.latestWebinars[index].slug);
//                   },
//                   child: newCoursesBuilder(
//                       controller.homeData!.latestWebinars[index])),
//               itemCount: data.latestWebinars.length),
//           _courseCategories(
//               title: 'Newest Courses',
//               itemBuilder: (context, index) => InkWell(
//                   onTap: () {
//                     Get.toNamed(RoutesName.allCoursesPageDetails);
//                     allCoursesController.getAllCourseDetails(
//                         controller.homeData!.bestSaleWebinars[index].slug);
//                   },
//                   child: newCoursesBuilder(
//                       controller.homeData!.latestWebinars[index])),
//               itemCount: controller.homeData!.latestWebinars.length),
//           _courseCategories(
//               title: 'Best Rated ★',
//               itemBuilder: (context, index) => InkWell(
//                   onTap: () {
//                     Get.toNamed(RoutesName.allCoursesPageDetails);
//                     allCoursesController.getAllCourseDetails(
//                         controller.homeData!.bestSaleWebinars[index].slug);
//                   },
//                   child: newCoursesBuilder(
//                       controller.homeData!.bestSaleWebinars[index])),
//               itemCount: data.bestSaleWebinars.length),
//           _courseCategories(
//               title: 'Best Selling',
//               itemBuilder: (context, index) => InkWell(
//                   onTap: () {
//                     Get.toNamed(RoutesName.allCoursesPageDetails);
//                     allCoursesController.getAllCourseDetails(
//                         controller.homeData!.bestSaleWebinars[index].slug);
//                   },
//                   child: newCoursesBuilder(
//                       controller.homeData!.bestSaleWebinars[index])),
//               itemCount: data.bestSaleWebinars.length),
//           _courseCategories(
//               title: 'Discounted Courses',
//               itemBuilder: (context, index) => InkWell(
//                     onTap: () {
//                       Get.toNamed(RoutesName.allCoursesPageDetails);
//                       allCoursesController.getAllCourseDetails(
//                           controller.homeData!.hasDiscountWebinars[index].slug);
//                     },
//                     child: newCoursesBuilder(
//                         controller.homeData!.hasDiscountWebinars[index]),
//                   ),
//               itemCount: data.hasDiscountWebinars.length),
//           _courseCategories(
//               title: 'Free Courses',
//               itemBuilder: (context, index) => InkWell(
//                     onTap: () {
//                       Get.toNamed(RoutesName.allCoursesPageDetails);
//                       allCoursesController.getAllCourseDetails(
//                           controller.homeData!.hasDiscountWebinars[index].slug);
//                     },
//                     child: newCoursesBuilder(
//                         controller.homeData!.hasDiscountWebinars[index]),
//                   ),
//               itemCount: data.hasDiscountWebinars.length)
//         ],
//       ),
//     );
//   }

//   Widget _courseCategories(
//       {String? title,
//       required Widget Function(BuildContext, int) itemBuilder,
//       required int itemCount}) {
//     return Column(
//       children: [
//         reusableTitle(title!),
//         const SizedBox(
//           height: 15,
//         ),
//         Container(
//           height: 190,
//           margin: const EdgeInsets.only(bottom: 30),
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemCount: itemCount,
//             itemBuilder: itemBuilder,
//             separatorBuilder: (context, _) => const SizedBox(
//               width: 1,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _body(context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//               height: 110,
//               color: Colors.yellowAccent.shade200.withOpacity(0.2),
//               child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (context, index) =>
//                       reusableCategoryOne(roundCategoryList[index]),
//                   separatorBuilder: (context, _) => const SizedBox(
//                         width: 5,
//                       ),
//                   itemCount: 8)),
//           const SizedBox(
//             height: 15,
//           ),
//           Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               CarouselSlider.builder(
//                   carouselController: carouselController,
//                   itemCount: controller.images.length,
//                   itemBuilder: (context, index, realIndex) {
//                     final image = controller.images[index].image;
//                     return buildImage(image, index);
//                   },
//                   options: CarouselOptions(
//                       viewportFraction: 1,
//                       height: 150,
//                       initialPage: 0,
//                       reverse: false,
//                       autoPlay: true,
//                       onPageChanged: (index, o) {
//                         controller.currentIndex(index);
//                       })),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: controller.images.map(
//               (image) {
//                 int index = controller.images.indexOf(image);
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 250),
//                   curve: Curves.easeInBack,
//                   width: controller.current.value == index
//                       ? controller.heigth
//                       : 10,
//                   height: 9.0,
//                   margin: const EdgeInsets.symmetric(
//                       vertical: 5.0, horizontal: 2.0),
//                   decoration: BoxDecoration(
//                     // shape: BoxShape.circle,
//                     borderRadius: BorderRadius.circular(10),
//                     color: controller.current.value == index
//                         ? Colors.green
//                         : Colors.grey,
//                   ),
//                 );
//               },
//             ).toList(),
//           ),
//           const SizedBox(
//             height: 18,
//           ),
//           reusableTitle("DEMO VIDEOS"),
//           const SizedBox(
//             height: 10,
//           ),
//           demoVideos(),
//           const SizedBox(
//             height: 20,
//           ),
//           reusableTitle("OUR COURSES"),
//           const SizedBox(
//             height: 10,
//           ),
//           ourCourses(),
//           const SizedBox(
//             height: 20,
//           ),
//           reusableTitle("STUDY MATERIAL"),
//           const SizedBox(
//             height: 10,
//           ),
//           studyMaterial(),
//           const SizedBox(
//             height: 15,
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(12)),
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//             child: Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Reward Courses!",
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       "By spending points",
//                       style: TextStyle(fontSize: 15, color: Colors.grey),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 25, vertical: 15),
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           "View",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                     height: 130,
//                     width: 130,
//                     child: Image.network(
//                       "https://i.pinimg.com/originals/4a/08/30/4a083000a80262e2ccd897a6f7bfbd36.jpg",
//                       fit: BoxFit.fill,
//                     ))
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           reusableTitle("CRASH COURSE"),
//           const SizedBox(
//             height: 10,
//           ),
//           crashCoursers(),
//           const SizedBox(
//             height: 10,
//           ),
//           reusableTitle("COMBO PACKAGE"),
//           const SizedBox(
//             height: 10,
//           ),
//           comboPackage()
//         ],
//       ),
//     );
//   }

//   Widget comboPackage() {
//     return Container(
//       height: 280,
//       // width: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return buildComboPack(index);
//         },
//       ),
//     );
//   }

//   Widget crashCoursers() {
//     return Container(
//       constraints:
//           BoxConstraints(maxWidth: Get.width, maxHeight: Get.height / 3),
//       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return reusableCourseCard();
//         },
//       ),
//     );
//   }

//   Widget studyMaterial() {
//     return Container(
//         height: 190,
//         color: Colors.blue.shade400.withOpacity(0.2),
//         padding: const EdgeInsets.symmetric(vertical: 3),
//         child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) => reusableMaterial(),
//             separatorBuilder: (context, _) => const SizedBox(
//                   width: 15,
//                 ),
//             itemCount: 8));
//   }

//   Widget ourCourses() {
//     return Container(
//         height: 85,
//         color: Colors.yellowAccent.shade200.withOpacity(0.2),
//         padding: const EdgeInsets.symmetric(vertical: 3),
//         child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) => reusableOurCourse(),
//             separatorBuilder: (context, _) => const SizedBox(
//                   width: 15,
//                 ),
//             itemCount: 8));
//   }

//   Widget demoVideos() {
//     return Container(
//         height: 190,
//         // color: Colors.yellowAccent.shade200.withOpacity(0.2),
//         child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) => reusableDemoVideosCard(),
//             separatorBuilder: (context, _) => const SizedBox(
//                   width: 15,
//                 ),
//             itemCount: 8));
//   }

//   Widget newCoursesBuilder(var coursesCategories) {
//     return SizedBox(
//       height: 150,
//       width: 200,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 100,
//             width: 180,
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(20)),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: CachedNetworkImage(
//                 fit: BoxFit.fill,
//                 imageUrl: "https://livedivine.in${coursesCategories.thumbnail}",
//                 placeholder: (context, url) => Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                         image: AssetImage(
//                           Images.logo,
//                         ),
//                         fit: BoxFit.fill),
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                         image: AssetImage(
//                           Images.logo,
//                         ),
//                         fit: BoxFit.fill),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 23.0),
//             child: Text(
//               coursesCategories.title,
//               style: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w900),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 6, right: 23, top: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.person_outline_sharp,
//                       size: 15,
//                       color: Colors.black54,
//                     ),
//                     Text(
//                       coursesCategories.teacher.fullName,
//                       style: const TextStyle(
//                           color: Colors.black54,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600),
//                     )
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Icon(
//                       Icons.calendar_month,
//                       size: 14,
//                       color: Colors.black54,
//                     ),
//                     Text(
//                       "${coursesCategories.duration}",
//                       style: const TextStyle(
//                           color: Colors.black54,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600),
//                     ),
//                     const Text(' Hours',
//                         style: TextStyle(
//                             color: Colors.black54,
//                             fontSize: 10,
//                             fontWeight: FontWeight.w600))
//                   ],
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 8, right: 40, top: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       '₹',
//                       style: TextStyle(
//                           color: ColorConst.greenColor,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w800),
//                     ),
//                     Text(
//                       coursesCategories.price.toString(),
//                       style: TextStyle(
//                           color: ColorConst.greenColor,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w800),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   "${coursesCategories.status}"
//                       .replaceFirst("Status.", "")
//                       .toLowerCase(),
//                   style: TextStyle(
//                       color: ColorConst.greenColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
