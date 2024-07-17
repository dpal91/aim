import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import '../Model/cart_model.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../Current Affair/current_affair_model.dart';
import '../Controller/all_courses_controller.dart';
import '../Controller/cart_controller.dart';
import '../Pages/all_courses_checkout_page.dart';
import 'paid_view_page.dart';

class OneLinerPage extends StatefulWidget {
  const OneLinerPage({Key? key}) : super(key: key);

  @override
  State<OneLinerPage> createState() => _OneLinerPageState();
}

class _OneLinerPageState extends State<OneLinerPage> {
  bool isLoading = false;
  int currentPage = 1;
  int totalItems = 0;
  CurrentAffairsModel? onelinearData;
  CurrentAffairsModel? paidData;
  final detailscontroller = Get.put(AllCoursesController());
  List<bool> isAddedList = [];
  List<bool> hasBought = [];
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
    getAllQuiz();
  }

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
        "type": "one_liner",
      },
    );
    if (response != null) {
      if (isUpdate) {
        paidData!.webinars.data!.addAll(
          currentAffairsModelFromJson(response).webinars.data!,
        );
        setState(() {});
      } else {
        paidData = currentAffairsModelFromJson(response);
      }
      onelinearData = currentAffairsModelFromJson(response);
      paidData!.webinars.data!.removeWhere(
          (element) => element.price == 0 || element.price == null);
      totalItems = jsonDecode(response)['totalWebinars'];
      currentPage = jsonDecode(response)['webinars']['current_page'];
      isAddedList = List.generate(
        paidData!.webinars.data!.length,
        (index) => false,
      );
      for (var element in paidData!.webinars.data!) {
        hasBought.add(await checkBuy(slug: element.slug!));
      }
    }
    if (isFirstTime) {
      getQuizPage2();
      isFirstTime = false;
    }
    // setState(() {
    //   isLoading = false;
    // });
  }

  getQuizPage2() async {
    final response = await ApiService.post(
      key: 'previousyearpaper?page=2',
      body: {
        "type": "one_liner",
      },
    );
    if (response != null) {
      paidData!.webinars.data!.addAll(
        currentAffairsModelFromJson(response).webinars.data!,
      );
      setState(() {});

      onelinearData = currentAffairsModelFromJson(response);
      paidData!.webinars.data!.removeWhere(
          (element) => element.price == 0 || element.price == null);
      totalItems = jsonDecode(response)['totalWebinars'];
      currentPage = jsonDecode(response)['webinars']['current_page'];
      isAddedList = List.generate(
        paidData!.webinars.data!.length,
        (index) => false,
      );
      for (var element in paidData!.webinars.data!) {
        hasBought.add(await checkBuy(slug: element.slug!));
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
    required String title,
    required int index,
  }) async {
    debugPrint('LOG : add item id == $id');
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
      isAddedList[index] = true;
    });
    Get.back();
  }

  removeFromCart({
    required int id,
    required String title,
    required int index,
  }) async {
    debugPrint('LOG : remove item id == $id');
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    final controller = Get.put(CartController());
    await controller.deleteFromCartUsingProductId(id);
    setState(() {
      isAddedList[index] = false;
    });
    Get.back();
    await controller.getCart();
  }

  void searchFromCart(String id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: ColorConst.primaryColor,
        title: 'One Liner / Short Notes',
        titleColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => PaidOneLinerPage(
                                title: onelinearData!.webinars.data!
                                    .where((element) =>
                                        element.price == 0 ||
                                        element.price == null)
                                    .toList()[0]
                                    .title,
                                slugl: onelinearData!.webinars.data!
                                    .where((element) =>
                                        element.price == 0 ||
                                        element.price == null)
                                    .toList()[0]
                                    .slug!,
                              ),
                            );
                            // Get.to(
                            //   () => ViewOneLinearPage(
                            //     title: onelinearData!.webinars.data!
                            //         .where((element) =>
                            //             element.price == 0 ||
                            //             element.price == null)
                            //         .toList()[0]
                            //         .title,
                            //     content: onelinearData!.webinars.data!
                            //         .where((element) =>
                            //             element.price == 0 ||
                            //             element.price == null)
                            //         .toList()[0]
                            //         .description,
                            //   ),
                            // );
                          },
                          child: Container(
                            height: 100,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Click here view",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Free Items",
                                            style: TextStyle(
                                              fontSize: 16,
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
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/blog.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Paid Items",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: paidData!.webinars.data!.length,
                          itemBuilder: (context, index) {
                            final item = paidData!.webinars.data![index];
                            return Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: RoutesName.baseImageUrl +
                                        item.thumbnail!,
                                    height: 50,
                                    width: 80,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    item.title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  "₹${item.price}",
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffdf633b),
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: hasBought[index]
                                    ? InkWell(
                                        onTap: () {
                                          Get.to(
                                            () => PaidOneLinerPage(
                                              title: item.title!,
                                              slugl: item.slug!,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: ColorConst.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "View",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : CupertinoButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          if (isAddedList[index]) {
                                            removeFromCart(
                                              id: item.id!,
                                              title: item.title!,
                                              index: index,
                                            );
                                          } else {
                                            addToCart(
                                              id: item.id!,
                                              title: item.title!,
                                              index: index,
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 30,
                                          width: isAddedList[index] ? 80 : 60,
                                          decoration: BoxDecoration(
                                            color: isAddedList[index]
                                                ? Colors.transparent
                                                : ColorConst.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: isAddedList[index]
                                                ? Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                        color: Colors.red,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: const Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Remove",
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                          size: 15,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const Text(
                                                    "Add +",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        currentPage < 2
                            ? Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    getAllQuiz(isUpdate: true);
                                  },
                                  child: const Text("Load More"),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                if (isAddedList.contains(true))
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
                            "Item Added to Cart\n${isAddedList.where((element) => element == true).length} Items",
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
                            onPressed: () async {
                              // Get.toNamed(
                              //   RoutesName.coursesCheckOutPage,
                              // );
                              final List<Carts>? removed =
                                  await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CoursesCheckOutPage(),
                                ),
                              );
                              removed?.forEach((e) {
                                removeFromCart(
                                  id: e.id!,
                                  title: e.webinar!.title!,
                                  index: paidData!.webinars.data!.indexOf(
                                    paidData!.webinars.data!.firstWhere(
                                      (element) {
                                        return element.id == e.webinar!.id;
                                      },
                                    ),
                                  ),
                                );
                              });
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
            ),
      // paidData!.webinars.data!.isEmpty
      //         ? Center(
      //             child: Image.asset(
      //               'assets/comingsoon.png',
      //               height: 150,
      //             ),
      //           )
      //         : Column(
      //             children: [
      //               Expanded(
      //                 child: SingleChildScrollView(
      //                   padding: const EdgeInsets.symmetric(
      //                     horizontal: 10,
      //                     vertical: 10,
      //                   ),
      //                   child: Column(
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       InkWell(
      //                         onTap: () {
      //                           Get.to(
      //                             () => PaidOneLinerPage(
      //                               title: onelinearData!.webinars.data!
      //                                   .where((element) =>
      //                                       element.price == 0 ||
      //                                       element.price == null)
      //                                   .toList()[0]
      //                                   .title,
      //                               slugl: onelinearData!.webinars.data!
      //                                   .where((element) =>
      //                                       element.price == 0 ||
      //                                       element.price == null)
      //                                   .toList()[0]
      //                                   .slug!,
      //                             ),
      //                           );
      //                           // Get.to(
      //                           //   () => ViewOneLinearPage(
      //                           //     title: onelinearData!.webinars.data!
      //                           //         .where((element) =>
      //                           //             element.price == 0 ||
      //                           //             element.price == null)
      //                           //         .toList()[0]
      //                           //         .title,
      //                           //     content: onelinearData!.webinars.data!
      //                           //         .where((element) =>
      //                           //             element.price == 0 ||
      //                           //             element.price == null)
      //                           //         .toList()[0]
      //                           //         .description,
      //                           //   ),
      //                           // );
      //                         },
      //                         child: Container(
      //                           height: 100,
      //                           width: Get.width,
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(10),
      //                             border: Border.all(
      //                               color: Colors.grey.withOpacity(0.3),
      //                             ),
      //                           ),
      //                           padding: const EdgeInsets.all(10),
      //                           child: Row(
      //                             children: [
      //                                Expanded(
      //                                 child: Column(
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.start,
      //                                   mainAxisAlignment:
      //                                       MainAxisAlignment.center,
      //                                   children: [
      //                                     const Text(
      //                                       "Click here view",
      //                                       style: TextStyle(
      //                                         fontSize: 16,
      //                                       ),
      //                                     ),
      //                                     const SizedBox(
      //                                       height: 2,
      //                                     ),
      //                                     Row(
      //                                       children: const [
      //                                         Text(
      //                                           "Free Items",
      //                                           style: TextStyle(
      //                                             fontSize: 16,
      //                                           ),
      //                                         ),
      //                                         SizedBox(
      //                                           width: 5,
      //                                         ),
      //                                         Icon(
      //                                           Icons.arrow_forward_ios,
      //                                           size: 15,
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                               Container(
      //                                 height: 100,
      //                                 width: 100,
      //                                 decoration: BoxDecoration(
      //                                   borderRadius: BorderRadius.circular(10),
      //                                   image: const DecorationImage(
      //                                     image: AssetImage(
      //                                       'assets/blog.png',
      //                                     ),
      //                                     fit: BoxFit.cover,
      //                                   ),
      //                                 ),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                       const SizedBox(
      //                         height: 10,
      //                       ),
      //                       const Text(
      //                         "Paid Items",
      //                         style: TextStyle(
      //                           fontSize: 18,
      //                           fontWeight: FontWeight.bold,
      //                         ),
      //                       ),
      //                       ListView.builder(
      //                         shrinkWrap: true,
      //                         physics: const NeverScrollableScrollPhysics(),
      //                         itemCount: paidData!.webinars.data!.length,
      //                         itemBuilder: (context, index) {
      //                           final item = paidData!.webinars.data![index];
      //                           return Container(
      //                             margin: const EdgeInsets.all(10),
      //                             decoration: BoxDecoration(
      //                               color: Colors.white,
      //                               borderRadius: BorderRadius.circular(10),
      //                               boxShadow: [
      //                                 BoxShadow(
      //                                   color: Colors.grey.withOpacity(0.5),
      //                                   spreadRadius: 2,
      //                                   blurRadius: 7,
      //                                   offset: const Offset(
      //                                       0, 3), // changes position of shadow
      //                                 ),
      //                               ],
      //                             ),
      //                             child: ListTile(
      //                               leading: ClipRRect(
      //                                 borderRadius: BorderRadius.circular(10),
      //                                 child: CachedNetworkImage(
      //                                   imageUrl: RoutesName.baseImageUrl +
      //                                       item.thumbnail!,
      //                                   height: 50,
      //                                   width: 80,
      //                                   fit: BoxFit.cover,
      //                                   placeholder: (context, url) =>
      //                                       const Center(
      //                                           child:
      //                                               CircularProgressIndicator()),
      //                                   errorWidget: (context, url, error) =>
      //                                       const Icon(Icons.error),
      //                                 ),
      //                               ),
      //                               title: Padding(
      //                                 padding: const EdgeInsets.only(bottom: 5),
      //                                 child: Text(
      //                                   item.title!,
      //                                   maxLines: 2,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   style: const TextStyle(
      //                                     fontSize: 13,
      //                                     fontWeight: FontWeight.bold,
      //                                   ),
      //                                 ),
      //                               ),
      //                               subtitle: Text(
      //                                 "₹${item.price}",
      //                                 maxLines: 1,
      //                                 style: const TextStyle(
      //                                     fontSize: 16,
      //                                     color: Color(0xffdf633b),
      //                                     fontWeight: FontWeight.bold),
      //                               ),
      //                               trailing: hasBought[index]
      //                                   ? InkWell(
      //                                       onTap: () {
      //                                         Get.to(
      //                                           () => PaidOneLinerPage(
      //                                             title: item.title!,
      //                                             slugl: item.slug!,
      //                                           ),
      //                                         );
      //                                       },
      //                                       child: Container(
      //                                         height: 30,
      //                                         width: 60,
      //                                         decoration: BoxDecoration(
      //                                           color: ColorConst.primaryColor,
      //                                           borderRadius:
      //                                               BorderRadius.circular(10),
      //                                         ),
      //                                         child: const Center(
      //                                           child: Text(
      //                                             "View",
      //                                             style: TextStyle(
      //                                               color: Colors.white,
      //                                             ),
      //                                           ),
      //                                         ),
      //                                       ),
      //                                     )
      //                                   : CupertinoButton(
      //                                       padding: const EdgeInsets.all(0),
      //                                       onPressed: () {
      //                                         if (isAddedList[index]) {
      //                                           removeFromCart(
      //                                             id: item.id!,
      //                                             title: item.title!,
      //                                             index: index,
      //                                           );
      //                                         } else {
      //                                           addToCart(
      //                                             id: item.id!,
      //                                             title: item.title!,
      //                                             index: index,
      //                                           );
      //                                         }
      //                                       },
      //                                       child: Container(
      //                                         height: 30,
      //                                         width:
      //                                             isAddedList[index] ? 80 : 60,
      //                                         decoration: BoxDecoration(
      //                                           color: isAddedList[index]
      //                                               ? Colors.transparent
      //                                               : ColorConst.primaryColor,
      //                                           borderRadius:
      //                                               BorderRadius.circular(10),
      //                                         ),
      //                                         child: Center(
      //                                           child: isAddedList[index]
      //                                               ? Container(
      //                                                   padding:
      //                                                       const EdgeInsets
      //                                                               .symmetric(
      //                                                           horizontal: 5,
      //                                                           vertical: 5),
      //                                                   decoration:
      //                                                       BoxDecoration(
      //                                                     borderRadius:
      //                                                         BorderRadius
      //                                                             .circular(5),
      //                                                     border: Border.all(
      //                                                       color: Colors.red,
      //                                                       width: 1,
      //                                                     ),
      //                                                   ),
      //                                                   child:  Row(
      //                                                     mainAxisSize:
      //                                                         MainAxisSize.min,
      //                                                     children: const [
      //                                                       Text(
      //                                                         "Remove",
      //                                                         style: TextStyle(
      //                                                           color:
      //                                                               Colors.red,
      //                                                           fontSize: 13,
      //                                                         ),
      //                                                       ),
      //                                                       SizedBox(
      //                                                         width: 5,
      //                                                       ),
      //                                                       Icon(
      //                                                         Icons.delete,
      //                                                         color: Colors.red,
      //                                                         size: 15,
      //                                                       ),
      //                                                     ],
      //                                                   ),
      //                                                 )
      //                                               : const Text(
      //                                                   "Add +",
      //                                                   style: TextStyle(
      //                                                     color: Colors.white,
      //                                                     fontSize: 13,
      //                                                   ),
      //                                                 ),
      //                                         ),
      //                                       ),
      //                                     ),
      //                             ),
      //                           );
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               if (isAddedList.contains(true))
      //                 Container(
      //                   height: 100,
      //                   width: double.infinity,
      //                   color: Colors.white,
      //                   padding: const EdgeInsets.all(15),
      //                   child: Container(
      //                     width: double.infinity,
      //                     decoration: BoxDecoration(
      //                       color: ColorConst.primaryColor,
      //                       borderRadius: BorderRadius.circular(20),
      //                     ),
      //                     padding: const EdgeInsets.symmetric(horizontal: 15),
      //                     child: Row(
      //                       children: [
      //                         Text(
      //                           "Item Added to Cart\n${isAddedList.where((element) => element == true).length} Items",
      //                           style: const TextStyle(
      //                             color: Colors.white,
      //                             fontSize: 13,
      //                           ),
      //                         ),
      //                         const Spacer(),
      //                         TextButton(
      //                           style: TextButton.styleFrom(
      //                             backgroundColor: ColorConst.primaryColor,
      //                             shape: RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(10),
      //                               side: const BorderSide(color: Colors.white),
      //                             ),
      //                           ),
      //                           onPressed: () async {
      //                             // Get.toNamed(
      //                             //   RoutesName.coursesCheckOutPage,
      //                             // );
      //                             final List<Carts>? removed =
      //                                 await Navigator.of(context).push(
      //                               MaterialPageRoute(
      //                                 builder: (_) =>
      //                                     const CoursesCheckOutPage(),
      //                               ),
      //                             );
      //                             removed?.forEach((e) {
      //                               removeFromCart(
      //                                 id: e.id!,
      //                                 title: e.webinar!.title!,
      //                                 index: paidData!.webinars.data!.indexOf(
      //                                   paidData!.webinars.data!.firstWhere(
      //                                     (element) {
      //                                       return element.id == e.webinar!.id;
      //                                     },
      //                                   ),
      //                                 ),
      //                               );
      //                             });
      //                           },
      //                           child: const Text(
      //                             "Go to Cart",
      //                             style: TextStyle(color: Colors.white),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //             ],
      //           ),
    );
  }
}
