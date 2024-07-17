// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:elera/Models/AllCources/Controller/all_courses_controller.dart';

// import 'package:elera/Models/Home/Class/categories_lists.dart';
// import 'package:elera/Models/Home/Controller/home_controller.dart';
// import 'package:elera/Models/Home/Model/home_model.dart';
// import 'package:elera/Models/Home/Widgets/other_widgets.dart';
// import 'package:elera/Utils/Constants/constans_assets.dart';
// import 'package:elera/Utils/Constants/constants_colors.dart';
// import 'package:elera/Utils/Constants/routes.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:get/get.dart';

// class NewHomePage extends StatefulWidget {
//   const NewHomePage({Key? key}) : super(key: key);

//   @override
//   State<NewHomePage> createState() => _NewHomePageState();
// }

// class _NewHomePageState extends State<NewHomePage> {
//   // newHomePageState() {
//   //   // _selectedVal = courseList[1];
//   // }

//   // String? _selectedVal = "JEE";
//   // final courseList = [
//   //   "JEE",
//   //   "NEET",
//   //   "CUET",
//   //   "Design Aptitude",
//   //   "Hotel Management",
//   //   "Defence",
//   // ];
//   final List images = [];
//   int activeIndex = 0;
//   final carouselController = CarouselController();
//   HomeController controller = Get.put(HomeController());
//   AllCoursesController allCoursesController = Get.put(AllCoursesController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Obx(() {
//       return controller.isLoading.value
//           ? const Center(child: CircularProgressIndicator())
//           : CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   expandedHeight: 130,
//                   backgroundColor: ColorConst.primaryColor,
//                   pinned: true,
//                   collapsedHeight: 70,
//                   shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25),
//                   )),
//                   leading: GestureDetector(
//                     onTap: () {
//                       ZoomDrawer.of(context)!.toggle();
//                     },
//                     child: Padding(
//                         padding: const EdgeInsets.only(top: 25.0, bottom: 4),
//                         child: SvgPicture.asset(
//                           Images.svgMenu,
//                           color: Colors.white,
//                         )),
//                   ),
//                   title: Padding(
//                     padding: const EdgeInsets.only(top: 25.0, bottom: 6),
//                     child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             children: const [
//                               Text(
//                                 'Hey',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w900),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 8.0),
//                                 child: Icon(
//                                   Icons.waving_hand,
//                                   size: 14,
//                                 ),
//                               )
//                             ],
//                           ),
//                           const Text(
//                             "Andrew Ansley",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 17,
//                                 letterSpacing: 1,
//                                 fontWeight: FontWeight.w900),
//                           ),
//                         ]),
//                   ),
//                   // title: ,
//                   actions: [
//                     Padding(
//                       padding: const EdgeInsets.only(right: 8, top: 20),
//                       child: GestureDetector(
//                           onTap: () {
//                             Get.toNamed(RoutesName.searchPage);
//                           },
//                           child: const Icon(Icons.search)),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10, top: 20),
//                       child: InkWell(
//                         onTap: () {
//                           Get.toNamed(RoutesName.coursesCheckOutPage);
//                         },
//                         child: const Icon(
//                           Icons.shopping_cart,
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(left: 15, right: 10.0, top: 20),
//                       child: GestureDetector(
//                           onTap: () {
//                             Get.toNamed(RoutesName.notificationPage);
//                           },
//                           child: const Icon(Icons.notifications)),
//                     )
//                   ],
//                 ),
//                 SliverToBoxAdapter(
//                   child: controller.isLoading.value
//                       ? const Center(child: CircularProgressIndicator())
//                       : Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(height: 10),
// SizedBox(
//     height: 110,
//     child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemBuilder: (context, index) =>
//             reusableCategoryOne(controller
//                 .homeData!.courseList![index]),
//         separatorBuilder: (context, _) =>
//             const SizedBox(
//               width: 5,
//             ),
//         itemCount:
//             controller.homeData!.courseList!.length)),
//                               SizedBox(
//                                   height: 110,
//                                   child: ListView.separated(
//                                       scrollDirection: Axis.horizontal,
//                                       physics: const BouncingScrollPhysics(),
//                                       itemBuilder: (context, index) => InkWell(
//                                             onTap: () {
//                                               if (index == 0) {
//                                                 Get.toNamed(
//                                                     RoutesName.previousPapers);
//                                               } else if (index == 1) {
//                                                 Get.toNamed(RoutesName
//                                                     .videoSectionPage);
//                                               } else if (index == 2) {
//                                                 Get.toNamed(RoutesName
//                                                     .practiceQuestions);
//                                               } else if (index == 3) {
//                                                 Get.toNamed(
//                                                     RoutesName.yourLibrary);
//                                               } else if (index == 5) {
//                                                 Get.toNamed(
//                                                     RoutesName.blogPage);
//                                               }
//                                             },
//                                             child: reusableCategoryOne(
//                                                 roundCategoryList[index]),
//                                           ),
//                                       separatorBuilder: (context, _) =>
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                       itemCount: 6)),
//                               // const SizedBox(height: 10),
//                               Stack(
//                                 alignment: Alignment.bottomCenter,
//                                 children: [
//                                   // Text("Slider to be implemented"),
//                                   CarouselSlider(
//                                     options: CarouselOptions(
//                                         height: 150, viewportFraction: 1),
//                                     items: [1, 2, 3, 4, 5].map((i) {
//                                       return Builder(
//                                         builder: (BuildContext context) {
//                                           return Container(
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               margin:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 5.0),
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(16),
//                                                 color: Colors.amber,
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   'text $i',
//                                                   style: const TextStyle(
//                                                       fontSize: 16.0),
//                                                 ),
//                                               ));
//                                         },
//                                       );
//                                     }).toList(),
//                                   ),
//                                   // CarouselSlider.builder(
//                                   //     carouselController: carouselController,
//                                   //     // itemCount: controller.images.length,
//                                   //     itemCount: 5,
//                                   //     itemBuilder: (context, index, realIndex) {
//                                   //       final image = controller.image;
//                                   //       return buildImage(image, index);
//                                   //     },
//                                   //     options: CarouselOptions(
//                                   //         viewportFraction: 1,
//                                   //         height: 200,
//                                   //         initialPage: 0,
//                                   //         reverse: false,
//                                   //         autoPlay: true,
//                                   //         onPageChanged: (index, o) {
//                                   //           controller.currentIndex(index);
//                                   //         })),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: controller.images.map(
//                                   (image) {
//                                     int index =
//                                         controller.images.indexOf(image);
//                                     return AnimatedContainer(
//                                       duration:
//                                           const Duration(milliseconds: 250),
//                                       curve: Curves.easeInBack,
//                                       width: 8.0,
//                                       height: 5.0,
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 5.0, horizontal: 2.0),
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: controller.current.value == index
//                                             ? ColorConst.buttonColor
//                                             : Colors.grey,
//                                       ),
//                                     );
//                                   },
//                                 ).toList(),
//                               ),
//                               const SizedBox(height: 20),
//                               reusableTitle("DEMO VIDEOS"),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               InkWell(child: demoVideos()),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               // SizedBox(
//                               //     height: 120,
//                               //     child: ListView.separated(
//                               //       scrollDirection: Axis.horizontal,
//                               //       physics: const BouncingScrollPhysics(),
//                               //       itemBuilder: (context, index) =>
//                               //           InkWell(
//                               //             onTap: (){
//                               //               Navigator.push(context, MaterialPageRoute(builder: (_)=>ChapterDetails()));
//                               //             },
//                               //             child: reusableCategoryOne(
//                               //                 controller.homeData!.demoVideo![index]),
//                               //           ),
//                               //       separatorBuilder: (context, _) => const SizedBox(
//                               //         width: 5,
//                               //       ),
//                               //       itemCount: controller.homeData!.demoVideo!.length,
//                               //     )),

//                               reusableTitle("OUR COURSES"),
//                               const SizedBox(height: 10),
//                               ourCourses(controller.homeData!.courseList!),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               reusableTitle('STUDY MATERIAL'),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               SizedBox(
//                                   height: 200,
//                                   child: ListView.separated(
//                                       scrollDirection: Axis.horizontal,
//                                       physics: const BouncingScrollPhysics(),
//                                       itemBuilder: (context, index) =>
//                                           reusableCategoryTwo(controller
//                                               .homeData!
//                                               .allQuizzesLists![index]),
//                                       separatorBuilder: (context, _) =>
//                                           const SizedBox(
//                                             width: 15,
//                                           ),
//                                       itemCount: controller
//                                           .homeData!.allQuizzesLists!.length)),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         controller.homeData!
//                                             .rewardProgramSection!.title!,
//                                         style: const TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 24),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       SingleChildScrollView(
//                                         physics:
//                                             const AlwaysScrollableScrollPhysics(),
//                                         child: Column(
//                                           children: [
//                                             SizedBox(
//                                               width: 200,
//                                               height: 60,
//                                               child: Text(
//                                                 controller
//                                                     .homeData!
//                                                     .rewardProgramSection!
//                                                     .description!,
//                                                 style: const TextStyle(
//                                                     fontSize: 15,
//                                                     color: Colors.grey),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(height: 20),
//                                       // const MyElevatedButton(label: "label")
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           InkWell(
//                                             onTap: () {
//                                               Get.toNamed(
//                                                   RoutesName.rewardsPage);
//                                             },
//                                             child: Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 15,
//                                                       vertical: 5),
//                                               decoration: BoxDecoration(
//                                                 color: ColorConst.buttonColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(20),
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   controller
//                                                       .homeData!
//                                                       .rewardProgramSection!
//                                                       .button1!
//                                                       .title!,
//                                                   style: const TextStyle(
//                                                       color: Colors.white),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 15, vertical: 5),
//                                             decoration: BoxDecoration(
//                                               color: ColorConst.buttonColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 controller
//                                                     .homeData!
//                                                     .rewardProgramSection!
//                                                     .button2!
//                                                     .title!,
//                                                 style: const TextStyle(
//                                                     color: Colors.white),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   CachedNetworkImage(
//                                       height: 150,
//                                       width: 100,
//                                       imageUrl: RoutesName.baseImageUrl +
//                                           controller.homeData!
//                                               .rewardProgramSection!.image!)
//                                 ],
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               reusableTitle('CRASH COURSE'),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               Container(
//                                 height: 200,
//                                 margin: const EdgeInsets.only(bottom: 30),
//                                 child: ListView.separated(
//                                   scrollDirection: Axis.horizontal,
//                                   physics: const BouncingScrollPhysics(),
//                                   itemCount: 5,
//                                   itemBuilder: (context, index) =>
//                                       crashCourses(),
//                                   separatorBuilder: (context, _) =>
//                                       const SizedBox(
//                                     width: 0,
//                                   ),
//                                 ),
//                               ),
//                               reusableTitle('TEST/QUIZZES'),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               SizedBox(
//                                   height: 200,
//                                   // color: Colors.blue.shade400.withOpacity(0.2),
//                                   child: ListView.separated(
//                                       scrollDirection: Axis.horizontal,
//                                       physics: const BouncingScrollPhysics(),
//                                       itemBuilder: (context, index) =>
//                                           reusableCategoryTwo(controller
//                                               .homeData!
//                                               .allQuizzesLists![index]),
//                                       separatorBuilder: (context, _) =>
//                                           const SizedBox(
//                                             width: 15,
//                                           ),
//                                       itemCount: controller
//                                           .homeData!.allQuizzesLists!.length)),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               const Text(
//                                 'SUBSCRIBE NOW!',
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     // fontFamily: "Nunito",
//                                     fontSize: 18,
//                                     letterSpacing: 0.5,
//                                     fontWeight:FontWeight.bold),
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                               ),
//                               SizedBox(
//                                   height: 280,
//                                   child: ListView.separated(
//                                     scrollDirection: Axis.horizontal,
//                                     physics: const BouncingScrollPhysics(),
//                                     itemCount:
//                                         controller.homeData!.subscribes!.length,
//                                     separatorBuilder: (context, _) =>
//                                         const SizedBox(width: 5),
//                                     itemBuilder: (context, index) =>
//                                         buildComboPack(
//                                             index,
//                                             controller
//                                                 .homeData!.subscribes![index]),
//                                   )),
//                             ],
//                           ),
//                         ),
//                 )
//               ],
//             );
//     }));
//   }

//   // SizedBox buildComboPack(int index) {
//   //   return SizedBox(
//   //     width: 280,
//   //     child: Card(
//   //       child: Padding(
//   //         padding: const EdgeInsets.all(20.0),
//   //         child: Column(
//   //           crossAxisAlignment: CrossAxisAlignment.center,
//   //           children: [
//   //             const Padding(
//   //               padding: EdgeInsets.all(8.0),
//   //               child: Center(
//   //                   child: Text(
//   //                 'TRAYAMBAKAM-Quants',
//   //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//   //               )),
//   //             ),
//   //             const Center(
//   //                 child: Text(
//   //               ' Package',
//   //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
//   //             )),
//   //             const SizedBox(
//   //               child: Divider(
//   //                 color: Colors.deepPurple,
//   //                 thickness: 2,
//   //                 indent: 10,
//   //                 endIndent: 10,
//   //               ),
//   //             ),
//   //             reusableRowSub('Complete DI Rudra 1.0 PRO Batch'),
//   //             reusableRowSub(
//   //                 'Zero to Zenith PRO Rudra 2.0 (Arithmetic & Misc Questions)'),
//   //             reusableRowSub('Rudra 3.0 Quants Batch'),
//   //             const SizedBox(
//   //               height: 30,
//   //             ),
//   //             Padding(
//   //               padding: const EdgeInsets.all(8.0),
//   //               child: Container(
//   //                 padding: const EdgeInsets.all(10),
//   //                 decoration: BoxDecoration(
//   //                     borderRadius: BorderRadius.circular(5),
//   //                     border: Border.all(color: Colors.deepPurple)),
//   //                 child: const Text(
//   //                   'View Package',
//   //                   style: TextStyle(
//   //                       color: Colors.deepPurple, fontWeight: FontWeight.w700),
//   //                 ),
//   //               ),
//   //             )
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget crashCourses() {
//     // return Column(
//     //   crossAxisAlignment: CrossAxisAlignment.start,
//     //   children: [
//     //     Padding(
//     //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//     //       child: Container(
//     //         height: 100,
//     //         width: 190,
//     //         decoration: BoxDecoration(
//     //             border: Border.all(color: Colors.grey),
//     //             borderRadius: BorderRadius.circular(20)),
//     //         child: ClipRRect(
//     //           borderRadius: BorderRadius.circular(20.0),
//     //           child: Container(
//     //             decoration: BoxDecoration(
//     //               borderRadius: BorderRadius.circular(20),
//     //               image: DecorationImage(
//     //                   image: AssetImage(
//     //                     Images.logo,
//     //                   ),
//     //                   fit: BoxFit.fill),
//     //             ),
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //     const Padding(
//     //       padding: EdgeInsets.only(left: 15, right: 23.0),
//     //       child: Text(
//     //         'Quantitative Aptitute',
//     //         style: TextStyle(
//     //             color: Colors.black, fontSize: 14, fontWeight: FontWeight.w900),
//     //       ),
//     //     ),
//     //     Padding(
//     //       padding: const EdgeInsets.only(left: 12, right: 23, top: 5),
//     //       child: Row(
//     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //         children: [
//     //           Row(
//     //             children: const [
//     //               Icon(
//     //                 Icons.person_outline_sharp,
//     //                 size: 15,
//     //                 color: Colors.black54,
//     //               ),
//     //               Text(
//     //                 'Mr. Ajay Kumar',
//     //                 style: TextStyle(
//     //                     color: Colors.black54,
//     //                     fontSize: 10,
//     //                     fontWeight: FontWeight.w600),
//     //               )
//     //             ],
//     //           ),
//     //           Row(
//     //             children: const [
//     //               Icon(
//     //                 Icons.calendar_month,
//     //                 size: 14,
//     //                 color: Colors.black54,
//     //               ),
//     //               Text(
//     //                 "200",
//     //                 style: TextStyle(
//     //                     color: Colors.black54,
//     //                     fontSize: 10,
//     //                     fontWeight: FontWeight.w600),
//     //               ),
//     //               Text(' Hours',
//     //                   style: TextStyle(
//     //                       color: Colors.black54,
//     //                       fontSize: 10,
//     //                       fontWeight: FontWeight.w600))
//     //             ],
//     //           )
//     //         ],
//     //       ),
//     //     ),
//     //     Padding(
//     //       padding: const EdgeInsets.only(left: 15, top: 5),
//     //       child: Row(
//     //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //         children: [
//     //           Row(
//     //             children: [
//     //               Text(
//     //                 '₹',
//     //                 style: TextStyle(
//     //                     color: ColorConst.greenColor,
//     //                     fontSize: 15,
//     //                     fontWeight: FontWeight.w800),
//     //               ),
//     //               Text(
//     //                 '100',
//     //                 style: TextStyle(
//     //                     color: ColorConst.greenColor,
//     //                     fontSize: 16,
//     //                     fontWeight: FontWeight.w800),
//     //               ),
//     //             ],
//     //           ),
//     //           Padding(
//     //             padding: const EdgeInsets.only(
//     //                 left: 70.0, right: 8.0, top: 8.0, bottom: 8.0),
//     //             child: Text(
//     //               "active".replaceFirst("Status.", "").toLowerCase(),
//     //               style: TextStyle(
//     //                   color: ColorConst.greenColor,
//     //                   fontSize: 12,
//     //                   fontWeight: FontWeight.w400),
//     //             ),
//     //           )
//     //         ],
//     //       ),
//     //     ),
//     //   ],
//     // );
//     return SizedBox(
//       width: 180,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 SizedBox(
//                   height: 95,
//                   width: 170,
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.network(
//                         "https://img.freepik.com/free-photo/successful-businesswoman-working-laptop-computer-her-office-dressed-up-white-clothes_231208-4809.jpg",
//                         fit: BoxFit.fill,
//                       )),
//                 ),
//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   child: Container(
//                     // height: 30,
//                     padding: const EdgeInsets.all(2),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         color: Colors.white),
//                     child: Center(
//                       child: Row(
//                         children: const [
//                           Icon(
//                             Icons.star,
//                             color: Colors.yellow,
//                             size: 13,
//                           ),
//                           Text(
//                             "5.0 ",
//                             style: TextStyle(fontSize: 10),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),

//             const Padding(
//               padding: EdgeInsets.only(left: 8.0),
//               child: Text(
//                 "Learn Phython\nProgramming",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
//               ),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: 70,
//                   child: Row(children: const [
//                     Icon(
//                       Icons.person,
//                       color: Colors.grey,
//                       size: 15,
//                     ),
//                     Expanded(
//                       child: Text(
//                         "Linda Address",
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(color: Colors.grey, fontSize: 9),
//                       ),
//                     )
//                   ]),
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 SizedBox(
//                   width: 70,
//                   child: Row(
//                     children: const [
//                       Icon(
//                         Icons.calendar_month,
//                         color: Colors.grey,
//                         size: 13,
//                       ),
//                       Expanded(
//                         child: Text(
//                           " 35 Minutes",
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(color: Colors.grey, fontSize: 9,)
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             // const SizedBox(
//             //   height: 10,
//             // ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Free",
//                   style: TextStyle(color: Colors.green, fontSize: 15),
//                 ),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
//                   decoration: BoxDecoration(
//                       color: Colors.green.withOpacity(0.4),
//                       borderRadius: BorderRadius.circular(20)),
//                   child: const Center(
//                     child: Text(
//                       "Text course",
//                       style: TextStyle(fontSize:9, color: Colors.green),
//                     ),
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget reusableRowSub(String text) {
//     return Flexible(
//       child: Padding(
//           padding: const EdgeInsets.only(right: 80.0),
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.check,
//                 color: Colors.deepPurple,
//               ),
//               Text(
//                 text,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style:
//                     const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
//               )
//             ],
//           )),
//     );
//   }

//   Widget crashCoursers() {
//     return Container(
//       constraints:
//           BoxConstraints(maxWidth: Get.width, maxHeight: Get.height / 4),
//       padding: const EdgeInsets.symmetric(
//         horizontal: 15,
//       ),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         shrinkWrap: true,
//         physics: const BouncingScrollPhysics(),
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return reusableCourseCard();
//         },
//       ),
//     );
//   }

//   // Widget comboPackage() {
//   //   return SizedBox(
//   //     height: 300,
//   //     // width: 200,
//   //     child: ListView.builder(
//   //       scrollDirection: Axis.horizontal,
//   //       shrinkWrap: true,
//   //       itemCount: 10,
//   //       physics: const BouncingScrollPhysics(),
//   //       itemBuilder: (context, index) {
//   //         return Text("data");
//   //       },
//   //     ),
//   //   );
//   // }

//   Widget demoVideos() {
//     return SizedBox(
//         height: 190,
//         // color: Colors.yellowAccent.shade200.withOpacity(0.2),
//         child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             itemBuilder: (context, index) => InkWell(
//                   onTap: () {
//                     Get.toNamed(RoutesName.chapterDetails,
//                         arguments: controller.homeData!.demoVideo![index].id!);
//                   },
//                   child: reusableDemoVideosCard(
//                     image: RoutesName.baseImageUrl +
//                         controller.homeData!.demoVideo![index].thumbnail!,
//                     title: controller.homeData!.demoVideo![index].title!,
//                   ),
//                 ),
//             separatorBuilder: (context, _) => const SizedBox(width: 15),
//             itemCount: controller.homeData!.demoVideo!.length));
//   }
// }

// Widget ourCourses(List<CourseList> courseList) {
//   return Container(
//       height: 85,
//       // color: Colors.blue.shade400.withOpacity(0.2),
//       padding: const EdgeInsets.symmetric(vertical: 3),
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: courseList.length,
//         physics: const BouncingScrollPhysics(),
//         itemBuilder: (context, index) => reusableOurCourse(courseList[index]),
//         separatorBuilder: (context, _) => const SizedBox(
//           width: 15,
//         ),
//       ));
// }
