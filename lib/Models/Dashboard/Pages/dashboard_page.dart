// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:elera/Utils/Constants/constans_assets.dart';
// import 'package:elera/Utils/Constants/constants_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// // import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import '../Class/dashboard_classes.dart';
// import '../Class/dashboard_lists.dart';

// class DashboardPage extends StatelessWidget {
//   const DashboardPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorConst.primaryColor,
//         elevation: 0.0,
//         actions: [
//           SvgPicture.asset(Images.svgNotification, color: Colors.white),
//           const SizedBox(width: 10),
//           SvgPicture.asset(
//             Images.svgBookmark,
//             color: Colors.white,
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Stack(
//           children: [
//             Column(children: [_header()]),
//             _positioned(context),
//             Column(
//               children: [
//                 SizedBox(height: Get.pixelRatio * 105),
//                 _carousel(carouselBalance[1]),
//                 const SizedBox(height: 10),
//                 SmoothIndicator(
//                     offset: 2,
//                     count: 2,
//                     effect: WormEffect(
//                         dotColor: Colors.grey,
//                         dotHeight: 5,
//                         dotWidth: 16,
//                         spacing: 4,
//                         activeDotColor: ColorConst.primaryColor)),
//                 const SizedBox(height: 40),
//                 _notices(),
//                 const SizedBox(height: 10),
//                 SmoothIndicator(
//                     offset: 2,
//                     count: 4,
//                     effect: WormEffect(
//                         dotColor: Colors.grey,
//                         dotHeight: 5,
//                         dotWidth: 16,
//                         spacing: 4,
//                         activeDotColor: ColorConst.primaryColor)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _notices() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: CarouselSlider(
//         options: CarouselOptions(
//           viewportFraction: 1,
//         ),
//         items: [1, 2, 3, 4, 5].map((i) {
//           return Builder(
//             builder: (BuildContext context) {
//               return Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.grey.shade100),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'New Private Course published',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w900,
//                               fontFamily: 'Nunito'),
//                         ),
//                         const SizedBox(height: 5),
//                         Row(
//                           children: const [
//                             Icon(
//                               Icons.person,
//                               size: 15,
//                               color: Colors.black54,
//                             ),
//                             Text(' Light Moon',
//                                 style: TextStyle(
//                                     fontSize: 10,

//                                     color: Colors.black54)),
//                             SizedBox(width: 10),
//                             Icon(
//                               Icons.calendar_month,
//                               size: 15,
//                               color: Colors.black54,
//                             ),
//                             Text(' 14 Jul 2021',
//                                 style: TextStyle(
//                                     fontSize: 10,

//                                     color: Colors.black54)),
//                           ],
//                         ),
//                         const Divider(),
//                         const Text(
//                           "---",
//                           style: TextStyle(
//                               fontSize: 9,

//                               color: Colors.black54),
//                         ),
//                       ],
//                     ),
//                   ));
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _carousel(CarouselBalance carouselBalance) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         children: [
//           CarouselSlider(
//             options: CarouselOptions(height: 100.0, viewportFraction: 1),
//             items: [carouselBalance].map((i) {
//               return Builder(
//                 builder: (BuildContext context) {
//                   return Container(
//                       width: MediaQuery.of(context).size.width,
//                       margin: const EdgeInsets.symmetric(horizontal: 5.0),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Colors.grey.shade100),
//                       child: Center(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     carouselBalance.title,
//                                     style: const TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 20,
//                                         fontFamily: "Nunito",
//                                         fontWeight: FontWeight.w900),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   Text(
//                                     carouselBalance.subtitle,
//                                     style: const TextStyle(
//                                         color: Colors.black54,
//                                         fontSize: 10,
//                                       ),
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                       color: carouselBalance.colors,
//                                       borderRadius: BorderRadius.circular(20)),
//                                   child: Icon(
//                                     carouselBalance.iconData,
//                                     size: 35,
//                                     color: Colors.white,
//                                   ))
//                             ],
//                           ),
//                         ),
//                       ));
//                 },
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _positioned(BuildContext context) {
//     return Positioned(
//       top: Get.pixelRatio * 45,
//       child: SizedBox(
//         height: Get.pixelRatio * 50,
//         width: MediaQuery.of(context).size.width,
//         child: ListView.builder(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           physics: const ClampingScrollPhysics(),
//           itemCount: 4,
//           // separatorBuilder: (context, _) => const SizedBox(width: 10),
//           itemBuilder: (BuildContext context, int index) {
//             return Row(
//               children: [
//                 const SizedBox(width: 10),
//                 _card(commonCard[index]),
//                 const SizedBox(width: 10),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _header() {
//     return Container(
//       decoration: BoxDecoration(
//           color: ColorConst.primaryColor,
//           borderRadius: const BorderRadius.only(
//               bottomLeft: Radius.circular(25),
//               bottomRight: Radius.circular(25))),
//       child: Column(
//         children: [
//           Row(
//             children: const [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: Text(
//                   "Hi Andrew Ainsley",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 19,
//                       fontFamily: "Nunito",
//                       fontWeight: FontWeight.w900),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 5),
//           Row(
//             children: const [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15),
//                 child: Text(
//                   "You have 13 events...",
//                   style: TextStyle(fontSize: 15, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: Get.pixelRatio * 55),
//         ],
//       ),
//     );
//   }

//   Widget _card(CommonCard commonCard) {
//     return SizedBox(
//       width: 140,
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 5.0),
//                 child: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: commonCard.color.withOpacity(0.5),
//                   child: Icon(
//                     commonCard.iconData,
//                     size: 30,
//                     color: commonCard.color,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 50),
//               Text(
//                 commonCard.number,
//                 style:
//                     const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               Text(commonCard.courses,
//                   style: const TextStyle(
//                       fontSize: 10,
//                       color: Colors.black54)),
//               // SizedBox(width: 50),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
