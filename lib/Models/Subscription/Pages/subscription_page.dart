import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Controller/subscription_page_controller.dart';
import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevated_button.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class Item {
  Item(
      {required this.title,
      required this.subtitle,
      required this.price,
      required this.subOne,
      required this.subTwo});
  String title;
  String subtitle;
  String price;
  String subOne;
  String subTwo;
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  CarouselController buttonCarouselController = CarouselController();
  SubscriptionPageController controller = Get.put(SubscriptionPageController());
  List<Item> items = [
    Item(
        title: 'Bronze',
        subtitle: 'Suggested for personal use',
        price: '\$20.00',
        subOne: '15 Days of subscription',
        subTwo: '100 Courses subscription'),
    Item(
        title: 'Gold',
        subtitle: 'Suggested for big bussinesses',
        price: '\$100.00',
        subOne: '30 Days of subscription',
        subTwo: '1000 Courses subscription'),
    Item(
        title: 'Silver',
        subtitle: 'Suggested for big bussinesses',
        price: '\$50.00',
        subOne: '30 Days of subscription',
        subTwo: '400 Courses subscription'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Subscription',
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: const Offset(0, .1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            Images.pngSubscription,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'No Subscription',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 22),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('You have no active subscription plan!',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Select a Plan',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : CarouselSlider.builder(
                      itemCount: controller.subscribes!.subscribes!.length,
                      options: CarouselOptions(
                        aspectRatio: 4 / 4,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        int index = itemIndex;
                        return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: const Offset(0, .1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  RoutesName.baseImageUrl +
                                                      controller
                                                          .subscribes!
                                                          .subscribes![index]
                                                          .icon!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      controller.subscribes!.subscribes![index]
                                          .title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: controller
                                                .subscribes!
                                                .subscribes![index]
                                                .description !=
                                            null
                                        ? Text(
                                            controller
                                                .subscribes!
                                                .subscribes![index]
                                                .description!,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            ),
                                          )
                                        : const Text(''),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('₹',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.green)),
                                      Text(
                                          controller.subscribes!
                                              .subscribes![index].price!
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.green)),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: ColorConst.buttonColor,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                            controller.subscribes!
                                                .subscribes![index].days!
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            )),
                                        const Text(' Days of subscription',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: ColorConst.buttonColor,
                                          size: 12,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                            controller.subscribes!
                                                .subscribes![index].usableCount!
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            )),
                                        const Text(' Subscribes',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: MyElevatedButton(
                                      label: 'Purchase',
                                      onPressed: () {},
                                    ),
                                  )
                                ],
                              ),
                            ));
                      },
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
