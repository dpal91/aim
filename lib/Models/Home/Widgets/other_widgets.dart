import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/global_data.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/dialog_login.dart';
import '../Class/const_classes.dart';
import '../Pages/see_all.dart';

Widget reusableTitle(
  String? title,
  BuildContext context,
  List list, {
  bool isStudy = false,
  bool isTest = false,
  bool isDemo = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title!.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            // fontFamily: "Nunito",
            fontSize: 16,
            letterSpacing: 0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorConst.primaryColor,
          ),
          child: InkWell(
            onTap: () {
              if (isSkippedButtonPressed && !isDemo) {
                DialogLogin().dialog(context);
              } else {
                Get.to(
                  () => SeeAllPage(
                    isDemo: isDemo,
                    webinars: list,
                  ),
                  arguments: [title, list, isStudy, isTest],
                );
              }
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 12,
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildImage(String imgUrl, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
    decoration: BoxDecoration(
        // color: ColorConst.primaryColor,
        borderRadius: BorderRadius.circular(29)),
    child: CachedNetworkImage(imageUrl: "https://livedivine.in$imgUrl"),
  );
}

// Widget buildIndicator() {
//   return AnimatedSmoothIndicator(
//     activeIndex: activeIndex,
//     count: images.length,
//     effect: const ExpandingDotsEffect(
//         spacing: 6.0,
//         radius: 2,
//         dotWidth: 4.0,
//         dotHeight: 3.0,
//         paintStyle: PaintingStyle.fill,
//         dotColor: Colors.grey,
//         activeDotColor: Colors.white),
//   );
// }

// Widget upcomingCategory(Category category) {
//   return Container(
//     height: 40,
//     padding: const EdgeInsets.all(8),
//     decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(17),
//         border: Border.all(color: ColorConst.buttonColor)),
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 4.0),
//           child: SvgPicture.asset(
//             category.imgUrl,
//             height: 20,
//             width: 10,
//           ),
//         ),
//         Text(
//           category.categoryName,
//           style: TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.bold,
//               color: ColorConst.buttonColor),
//         )
//       ],
//     ),
//   );
// }

Widget reusableRowSub(String text) {
  return Padding(
    padding: const EdgeInsets.only(right: 20.0),
    child: Row(
      children: [
        const Icon(
          Icons.check,
          color: Colors.deepPurple,
        ),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.clip,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        )
      ],
    ),
  );
}

// Widget buildComboPack(int index, Subscribes subscriptionList) {
//   return Row(
//     children: [
//       if (index == 0) const SizedBox(width: 0),
//       Container(
//         width: 250,
//         margin: const EdgeInsets.symmetric(vertical: 2),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: Colors.grey[100],
//             boxShadow: const [
//               BoxShadow(
//                   color: Colors.black54,
//                   blurRadius: 1.0,
//                   offset: Offset(0.0, 0.75))
//             ]),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                   height: 80,
//                   width: 80,
//                   child: Center(
//                     child: CachedNetworkImage(
//                         imageUrl:
//                             RoutesName.baseImageUrl + subscriptionList.icon!),
//                   )),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(
//                   subscriptionList.title!,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Text(
//                   subscriptionList.description.toString(),
//                   style: const TextStyle(
//                     color: Colors.black54,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text('₹',
//                         style: TextStyle(fontSize: 17, color: Colors.green)),
//                     Text(subscriptionList.price!.toString(),
//                         style:
//                             const TextStyle(fontSize: 17, color: Colors.green)),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.circle,
//                       color: ColorConst.buttonColor,
//                       size: 12,
//                     ),
//                     const SizedBox(width: 10),
//                     const Text("subscriptionList.sub1",
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 9,
//                         )),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.circle,
//                     color: ColorConst.buttonColor,
//                     size: 12,
//                   ),
//                   const SizedBox(width: 10),
//                   const Text("subscriptionList.sub2",
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 9,
//                       )),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   height: 47,
//                   child: MyElevatedButton(
//                     label: 'Purchase',
//                     onPressed: () {},
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       const SizedBox(
//         width: 25,
//       )
//     ],
//   );
// }

Widget reusableCourseCard() {
  return Padding(
    padding: const EdgeInsets.only(right: 20),
    child: SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 120,
                width: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      "https://img.freepik.com/free-photo/successful-businesswoman-working-laptop-computer-her-office-dressed-up-white-clothes_231208-4809.jpg",
                      fit: BoxFit.fill,
                    )),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  // height: 30,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: const Center(
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        Text("5.0 ")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Learn Phython\nProgramming",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              SizedBox(
                width: 90,
                child: Row(children: [
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 19,
                  ),
                  Expanded(
                    child: Text(
                      "Linda Address",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  )
                ]),
              ),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 90,
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.grey,
                      size: 19,
                    ),
                    Expanded(
                      child: Text(
                        "35 Minutes",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "",
                style: TextStyle(color: Colors.green, fontSize: 17),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Text(
                    "Text course",
                    style: TextStyle(fontSize: 11, color: Colors.green),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}

Widget reusableMaterial() {
  return Container(
    width: 200,
    decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const [
          BoxShadow(
              color: Colors.black54, blurRadius: 1.0, offset: Offset(0.0, 0.75))
        ]),
    margin: const EdgeInsets.only(bottom: 2, top: 2),
    // padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    child: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 0.1),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(6)),
          child: const Column(
            children: [
              Text(
                "China blocks UNSC listing of Lashkar Commander",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                    size: 15,
                  ),
                  Text(
                    " 20 Sep 2022",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ],
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Read more",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              Icon(
                Icons.navigate_next_outlined,
                color: Colors.white,
                size: 17,
              )
            ],
          ),
        )
      ],
    ),
  );
}

// Widget reusableOurCourse(CourseList courseList) {
//   return Card(
//     elevation: 2.0,
//     child: SizedBox(
//       width: 80,
//       child: Column(
//         children: [
//           CachedNetworkImage(
//               // height: 30,
//               // width: 30,
//               imageUrl: RoutesName.baseImageUrl + courseList.imageCover!),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Text(
//               courseList.title!,
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               style: const TextStyle(
//                   color: Colors.black87,
//                   overflow: TextOverflow.ellipsis,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600),
//             ),
//           ),
//           // Center(
//           //   child: Container(
//           //
//           //     color: Colors.blue[50],
//           //     child: const Align(
//           //       alignment: Alignment(0.2, 0.6),
//           //       child: Icon(Icons.account_balance)
//           //     ),
//           //   ),
//           // )
//         ],
//       ),
//     ),
//   );
//   // return Container(
//   //   width: 70,
//   //   decoration: BoxDecoration(
//   //       color: Colors.white,
//   //       borderRadius: BorderRadius.circular(2),
//   //       boxShadow: const [
//   //         BoxShadow(
//   //             color: Colors.black54, blurRadius: 1.0, offset: Offset(0.0, 0.75))
//   //       ]),
//   //   margin: const EdgeInsets.only(bottom: 2, top: 2),
//   //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//   //   child: Column(
//   //     children: [
//   //       CachedNetworkImage(
//   //           height: 30,
//   //           width: 30,
//   //           imageUrl:
//   //               "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQwxiiGmSI39Z5aoY-mSH-FgeRMyQRdNz3zQ&usqp=CAU"),
//   //       const SizedBox(
//   //         height: 0,
//   //       ),
//   //       const Text(
//   //         "IAS",
//   //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//   //       )
//   //     ],
//   //   ),
//   // );
// }

Widget reusableDemoVideosCard({required String image, required String title}) {
  return Container(
    width: 130,
    margin: const EdgeInsets.only(bottom: 2),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              color: Colors.black54, blurRadius: 1.0, offset: Offset(0.0, 0.75))
        ]),
    child: Column(
      children: [
        Expanded(
          flex: 45,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(imageUrl: image),
              ),
              Positioned.fill(
                child: CachedNetworkImage(
                  width: 30,
                  height: 30,
                  imageUrl:
                      "https://icons.veryicon.com/png/o/miscellaneous/play-pc-play-page/video-web-play.png",
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 55,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "5.0",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SvgPicture.asset(
                      Images.svgStar,
                      color: Colors.yellowAccent.shade700,
                      height: 15,
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "(8.8K Views)",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget reusableCategoryOne(
    int index, RoundCategory roundCategoryList, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
      child: Column(
        children: [
          // if(index==4)SizedBox(width: 10,),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.shade100,
            child: CachedNetworkImage(
              imageUrl: RoutesName.baseImageUrl + roundCategoryList.icondata,
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              roundCategoryList.name,
              // textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Widget reusableCategoryTwo(AllQuizzesLists categorySecond) {
//   return Container(
//     width: 220,
//     decoration: BoxDecoration(
//         color: ColorConst.buttonColor,
//         borderRadius: BorderRadius.circular(6),
//         boxShadow: const [
//           BoxShadow(
//               color: Colors.black54, blurRadius: 1.0, offset: Offset(0.0, 0.75))
//         ]),
//     margin: const EdgeInsets.only(bottom: 2, top: 2),
//     child: Column(
//       children: [
//         Container(
//           height: 130,
//           margin: const EdgeInsets.only(left: 0.1),
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(6)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 categorySecond.webinarTitle!,
//                 style:
//                     const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
//               ),
//               // const SizedBox(
//               //   height: 20,
//               // ),
//               Row(
//                 children: const [
//                   Icon(
//                     Icons.calendar_month,
//                     color: Colors.grey,
//                     size: 13,
//                   ),
//                   Text(
//                     " 20 Sep 2022",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 11),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//           child: SizedBox(
//             height: 30,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   "Read more",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 13),
//                 ),
//                 Icon(
//                   Icons.navigate_next_outlined,
//                   color: Colors.white,
//                   size: 20,
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }
