// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:elera/Models/AllCources/Controller/add_favourite_controller.dart';
import 'package:elera/Models/AllCources/Controller/all_courses_controller.dart';
import 'package:elera/Models/AllCources/Controller/description_controller.dart';
import 'package:elera/Models/AllCources/Model/all_courses_details_model.dart';
import 'package:elera/Models/AllCources/Pages/all_courses_checkout_page.dart';
import 'package:elera/Models/AllCources/VideoPlayer/video_player_widget.dart';
import 'package:elera/Models/Favouties/Controller/favourite_controller.dart';
import 'package:elera/Utils/Constants/constants_colors.dart';
import 'package:elera/Utils/Constants/routes.dart';
import 'package:elera/Utils/Wdgets/appbar.dart';
import 'package:elera/Utils/Wdgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../Utils/Wdgets/snackbar.dart';
import '../../Home/Model/home_model.dart';
import '../../LearningPage/Controller/controller.dart';
import '../../LearningPage/Pages/learning_page.dart';
import '../Class/all_courses_class.dart';
import '../Controller/cart_controller.dart';
import 'text_lesson_page.dart';

class AllCoursesPageDetails extends StatefulWidget {
  final bool isDemo;
  final List<dynamic>? latestWebinars;
  final Webinar? notIncludedLatestWebinars;
  final FavouriteController? favouriteController =
      Get.find<FavouriteController>();
  AllCoursesPageDetails({
    Key? key,
    this.isDemo = false,
    this.latestWebinars,
    this.notIncludedLatestWebinars,
  }) : super(key: key);

  @override
  State<AllCoursesPageDetails> createState() => _AllCoursesPageDetailsState();
}

class _AllCoursesPageDetailsState extends State<AllCoursesPageDetails>
    with SingleTickerProviderStateMixin {
  AllCoursesController controller = Get.put(AllCoursesController());

  // YoutubePlayerController? ytController;
  late AnimationController animatedController;
  final asset = 'assets/video/samplevideo.mp4';
  bool visible = true;
  bool isPlaying = true;
  bool isDownloading = true;
  String imgUrl =
      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg';
  String? filePath;
  String progressString = '';
  List speeds = <double>[0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
  RxString remainTime = "".obs;

  final pdfUrl =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  var progress = "";
  var path = "No Data";
  var platformVersion = "Unknown";
  Directory externalDir = Directory("/storage/emulated/0/Download");
  YoutubePlayerController? ytController;
  List<Webinar> relatedvideos = [];
  List<Webinar> nrelatedvideos = [];
  final cartController = Get.put(CartController());

  LearningPageController learningPageController =
      Get.put(LearningPageController());

  StreamSubscription? _timerSubscription;
  late Razorpay razorpay;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    startTimer();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 400),
    );
    animatedController.forward();
    setState(() {
      ytController = controller.ytController;
    });
    if (widget.latestWebinars != null) {
      setState(() {
        for (var element in widget.latestWebinars!) {
          nrelatedvideos.add(element);
        }
      });
      setState(() {
        relatedvideos.addAll(nrelatedvideos);
        relatedvideos.remove(widget.notIncludedLatestWebinars!);
      });
      debugPrint('LOG : related videos: ${relatedvideos.length}');
    }
  }

  bool isListening = false;

  String convertCurrentDateTimeToString() {
    String formattedDateTime =
        DateFormat('yyyyMMdd_kkmmss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Future<void> downloadFile(String pdfUrl) async {
    Dio dio = Dio();
    SnackBarService.showSnackBar(
      context,
      'Downloading Started',
    );

    final status = await Permission.storage.request();
    if (status.isGranted) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/storage/emulated/0/Download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      // try {
      //   FileUtils.mkdir([dirloc]);
      //   await dio
      //       .download(pdfUrl, "$dirloc${convertCurrentDateTimeToString()}.pdf",
      //           onReceiveProgress: (receivedBytes, totalBytes) {
      //     setState(() {
      //       progress =
      //           "${((receivedBytes / totalBytes) * 100).toStringAsFixed(0)}%";
      //     });
      //   });
      // } catch (e) {
      //   print(e);
      // }

      setState(() {
        progress = "Download Completed.";
        path = "$dirloc${convertCurrentDateTimeToString()}.pdf";
      });
      SnackBarService.showSnackBar(
        context,
        'Downloading Completed',
      );
    } else {
      setState(() {
        progress = "Permission Denied!";
      });
    }
  }

  bool isFullScreen = false;
  int? orderId;

  @override
  void dispose() {
    super.dispose();
    _confettiController.dispose();
    startTimer();
    _timerSubscription?.cancel();
    controller.disposeVideoController();
    animatedController.dispose();
    controller.allCoursesDetailsData = null;
    razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // print(response.paymentId);
    await cartController.verifyPayment(orderId!, response.paymentId!,
        refresh: true);
    // Get.toNamed(RoutesName.paymentSuccessPage);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.back();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('_handleExternalWallet ${response.walletName}');
  }

  void _openCheckout(price) {
    final amount = double.parse(
        (price * 100).toStringAsFixed(2)); // convert rupee into paisa
    var options = {
      'key': 'rzp_test_12NU2uJHBrgQPX',
      'amount': amount,
      'name': 'Live Divine',
      // 'order_id': orderId.toString(),
      'description': 'Purchase your course',
      'timeout': 300,
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint('ERROR : $e');
    }
    Get.back();
  }

  bool isNew = true;

  purchaseFree(Course course) async {
    // debugPrint('LOG : purchaseFree');
    // Get.dialog(
    //   const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    // // log(course.id.toString());
    // final url = '${RoutesName.baseUrl}api/cart/checkOutFree';
    // final response = await ApiService.post(
    //   key: 'cart/checkOutFree',
    //   body: {
    //     'webinar_id': course.id.toString(),
    //   },
    // );

    // final data = json.decode(response);
    // if (data['statusCode'] == 400) {
    //   Get.back();
    //   controller.getAllCourseDetails(
    //     controller.allCoursesDetailsData!.slug!,
    //   );
    // } else {
    //   Get.back();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Something went Wrong'),
    //     ),
    //   );
    // }
  }

  double height = 1;
  late final WebViewPlusController webViewPlusController;
  final DescriptionController descriptionController =
      Get.put(DescriptionController());

  double descriptionHeight = 100;
  String? des;

  final couponController = TextEditingController();
  bool isCouponApplied = false;
  String disCount = '0';
  String totalAmount = '0';
  String taxAmount = '0';

  applyCoupon() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final data = (await controller.applyCoupon(code: couponController.text))!;
    Get.back();
    if (data['status'] == 200) {
      setState(() {
        isCouponApplied = true;
        disCount = data['total_discount'].toString();
        totalAmount = data['total_amount'].toString();
        taxAmount = data['total_tax'].toString();
      });
      Get.back();
      _confettiController.play();
      showOrderSummary(paymentResponse!);
    } else {
      setState(() {
        isCouponApplied = false;
        disCount = "0";
        totalAmount = "0";
        taxAmount = "0";
      });
      Get.back();
      showOrderSummary(paymentResponse!);
      Get.showSnackbar(GetSnackBar(
        message: data['msg'],
      ));
      setState(() {});
      Future.delayed(const Duration(seconds: 2), () {
        Get.closeAllSnackbars();
      });
    }
  }

  showOrderSummary(Map<String, dynamic> paymentData) {
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, setter) {
        return bottomWidget(paymentData);
      }),
    );
  }

  Map<String, dynamic>? paymentResponse = {};

  Widget bottomWidget(Map<String, dynamic> data) {
    if (isCouponApplied) {
      _confettiController.play();
    }

    return Container(
      color: Colors.white,
      height: 340,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ConfettiWidget(
        blastDirectionality: BlastDirectionality.explosive,
        confettiController: _confettiController,
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.grey[200],
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                      controller.closeFunction();
                      learningPageController.closeFunction();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.allCoursesDetailsData!.title!,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       '₹${controller.allCoursesDetailsData!.price}',
                    //       style: const TextStyle(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 10,
                    ),
                    // TODO :: hided for release
                    if (false ?? !isCouponApplied)
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey[300]!,
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: couponController,
                          decoration: InputDecoration(
                            hintText: 'Coupon Code',
                            hintStyle: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none,
                            suffixIcon: InkWell(
                              onTap: () {
                                if (couponController.text.isEmpty ||
                                    couponController.text.length < 5) {
                                  SnackBarService.showSnackBar(
                                    context,
                                    "Invalid Coupon",
                                  );
                                  return;
                                }
                                applyCoupon();
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Apply',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    // const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${controller.allCoursesDetailsData!.price}',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tax',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isCouponApplied && disCount != '0')
                          Text(
                            "+ $taxAmount",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else
                          Text(
                            '+ ₹${data['data']['taxPrice']}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (isCouponApplied && disCount != '0')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Coupon Applied',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "- $disCount",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.grey[500],
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Payable',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isCouponApplied && disCount != '0')
                          Text(
                            totalAmount,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else
                          Text(
                            '₹${data['data']['total']}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Payment using apple pay

                          if (Platform.isIOS) ...[
                            // Container(
                            //   height: 50,
                            //   width: Get.width,
                            //   padding: const EdgeInsets.only(bottom: 10),
                            //   child: RawApplePayButton(
                            //       type: ApplePayButtonType.buy,
                            //       onPressed: () async {
                            //         controller.executeApplePayment(
                            //           isCouponApplied: isCouponApplied,
                            //           totalAmount: totalAmount,
                            //         );
                            //       }),
                            // ),

                            // this is for apple iOS
                            MyElevatedButton(
                              onPressed: () {
                                controller.subscribe(
                                    product: controller.getProductList[0]);
                              },
                              label: 'Pay with In-App Purchases',
                            ),
                            const SizedBox(height: 5),
                          ],

                          ///we are uncommenting the code for android and will comment for iOS
                          const SizedBox(height: 5),
                          // Payment using razor pay
                          if (Platform.isAndroid)
                            MyElevatedButton(
                              onPressed: () {
                                Get.dialog(
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  barrierDismissible: false,
                                );
                                cartController
                                    .checkoutCart(body: "asdfasdf")
                                    .then(
                                  (orderData) {
                                    Get.back();
                                    if (orderData != null) {
                                      setState(() {
                                        orderId = orderData.id;
                                      });
                                      Get.dialog(
                                        const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        barrierDismissible: false,
                                      );
                                      _openCheckout(
                                        isCouponApplied
                                            ? double.parse(
                                                totalAmount.replaceAll("₹", ""),
                                              )
                                            : orderData.totalAmount,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Something went Wrong'),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                              label: 'Pay with razorpay',
                            ),
                          //till this bracket
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: widget.isDemo ||
                controller.allCoursesDetailsData == null ||
                controller.isLoading.value ||
                isFullScreen
            ? null
            : SizedBox(
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                    top: 5,
                  ),
                  child: controller.hasBought.value
                      ? MyElevatedButton(
                          onPressed: () {
                            controller.ytController != null
                                ? controller.ytController!.pause()
                                : null;
                            Get.to(
                              () => LearningPage(
                                course: controller.allCoursesDetailsData!,
                                hasBought: controller.hasBought.value,
                              ),
                            );
                          },
                          label: "Go to learning page",
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: MyElevatedButton(
                                onPressed: () {
                                  // There are two type of courses free and paid based on condition
                                  controller.allCoursesDetailsData!.price ==
                                              null ||
                                          controller.allCoursesDetailsData!
                                                  .price ==
                                              0
                                      ? purchaseFree(
                                          controller.allCoursesDetailsData!)
                                      : controller.checkoutDirectly().then(
                                          (tempPaymentResponse) {
                                            /*Get.back();*/
                                            if (tempPaymentResponse != null) {
                                              setState(() {
                                                orderId =
                                                    tempPaymentResponse['id'];
                                                paymentResponse =
                                                    tempPaymentResponse;
                                              });

                                              showOrderSummary(
                                                  tempPaymentResponse);
                                            }
                                            // RestartWidget.restartApp(context);
                                          },
                                        );
                                },
                                label:
                                    // controller.allCoursesDetailsData!.price ==
                                    //             null ||
                                    //         controller.allCoursesDetailsData!
                                    //                 .price ==
                                    //             0
                                    "Buy Now",
                                //     :
                                // "Add to Cart",
                              ),
                            ),
                            if (controller.allCoursesDetailsData!.price ==
                                    null ||
                                controller.allCoursesDetailsData!.price == 0)
                              const SizedBox.shrink()
                            else
                              const SizedBox(width: 10),
                            if (controller.allCoursesDetailsData!.price ==
                                    null ||
                                controller.allCoursesDetailsData!.price == 0)
                              const SizedBox()
                            // else
                            //   Expanded(
                            //     child: MyElevatedButton(
                            //       onPressed: () {
                            //         controller.ytController != null
                            //             ? controller.ytController!.pause()
                            //             : null;
                            //         controller.isInitialized.value
                            //             ? controller.videoplayercontroller
                            //                 .pause()
                            //             : null;
                            //         Get.to(
                            //           () => const DemoPage(),
                            //           arguments: controller
                            //               .allCoursesDetailsData!.chapters!,
                            //         );
                            //       },
                            //       label: "Demo",
                            //     ),
                            //   ),
                          ],
                        ),
                ),
              ),
        appBar: !isFullScreen
            ? MyAppBar(
                title: controller.allCoursesDetailsData?.title ?? '',
                backgroundColor: ColorConst.primaryColor,
                titleColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  // color: backgroundColor == Colors.transparent
                  //     ? Theme.of(context).iconTheme.color
                  //     : Colors.black,
                  onPressed: () {
                    Get.back();
                  },
                ),
              )
            : null,
        body: controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : widget.isDemo
                ? demoWidget()
                : SafeArea(
                    child: originalWidget(),
                  ),
      );
    });
  }

  originalWidget() {
    return Column(
      children: [
        if (controller.allCoursesDetailsData!.videoDemoSource == "youtube")
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: RoutesName.baseImageUrl +
                  controller.allCoursesDetailsData!.videoDemo!,
              width: Get.width,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.image,
                color: Colors.grey,
                size: 100,
              ),
            ),
          )
        else
          controller.isInitialized.value
              ? VideoPlayerWidget(
                  controller: controller.videoplayercontroller,
                  onFullScreen: (value) {
                    setState(() {
                      isFullScreen = value;
                    });
                  },
                )
              // MeeduVideoPlayer(
              //     controller: controller.videoplayercontroller,
              //   )
              : const SizedBox(
                  height: 200,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    toolbarHeight: controller.hasBought.value ? 70 : 90,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    leadingWidth: 0,
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.allCoursesDetailsData!.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // if (controller.hasBought.value)
                            //   Container()
                            // else
                            //   Obx(
                            //     () => IconButton(
                            //       onPressed: () {
                            //         controller.isInitialized.value
                            //             ? controller.videoplayercontroller
                            //                 .pause()
                            //             : null;
                            //         Get.toNamed(
                            //           RoutesName.coursesCheckOutPage,
                            //         );
                            //       },
                            //       icon: badge.Badge(
                            //         badgeColor: Colors.red,
                            //         badgeContent: Text(
                            //           '${cartCount.value}',
                            //           style: const TextStyle(
                            //             color: Colors.white,
                            //           ),
                            //         ),
                            //         child: const Icon(
                            //           Icons.shopping_cart_outlined,
                            //           color: Colors.black,
                            //           size: 29,
                            //         ),
                            //       ),
                            //     ),
                            //   )
                          ],
                        ),
                        controller.hasBought.value
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.allCoursesDetailsData!.price !=
                                            null
                                        ? "₹${controller.allCoursesDetailsData!.price}"
                                        : "Free",
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffee6c4d),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 40,
                            child: TabBar(
                              indicatorColor: ColorConst.primaryColor,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: ColorConst.primaryColor,
                              ),
                              unselectedLabelColor: Colors.black,
                              labelColor: Colors.white,
                              tabs: const [
                                Tab(
                                  text: 'Course Details',
                                ),
                                Tab(
                                  text: 'Course Material',
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            height: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  courseDetails(),
                  courseContent(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  courseDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5),
            // decoration: BoxDecoration(
            //   color: ColorConst.primaryColor,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            // color: ColorConst.primaryColor,
            child: Row(
              children: [
                const Text(
                  'What you will get? ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          second_row(controller.allCoursesDetailsData!),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5),
            // decoration: BoxDecoration(
            //   color: ColorConst.primaryColor,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Row(
              children: [
                const Text(
                  'About Course ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0;
                    i <
                        jsonDecode(controller
                                .allCoursesDetailsData!.description!)['data']
                            .length;
                    i++)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      jsonDecode(controller.allCoursesDetailsData!
                                  .description!)['data'][i]['title'] ==
                              ""
                          ? const SizedBox()
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Html(
                                    data: jsonDecode(controller
                                        .allCoursesDetailsData!
                                        .description!)['data'][i]['title'],
                                  ),
                                ),
                              ],
                            ),
                      jsonDecode(controller.allCoursesDetailsData!
                                  .description!)['data'][i]['image'] ==
                              ""
                          ? const SizedBox()
                          : SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Image.network(
                                jsonDecode(controller.allCoursesDetailsData!
                                    .description!)['data'][i]['image'],
                                fit: BoxFit.contain,
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (jsonDecode(controller.allCoursesDetailsData!
                              .description!)['data'][i]['table']
                          .isEmpty)
                        const SizedBox()
                      else
                        Table(
                          border: TableBorder.all(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                          children: [
                            for (var k = 0;
                                k <
                                    jsonDecode(controller.allCoursesDetailsData!
                                            .description!)['data'][i]['table']
                                        .length;
                                k++)
                              TableRow(
                                decoration: BoxDecoration(
                                  color: k == 0
                                      ? const Color(0xff6777ef)
                                      : Colors.white,
                                ),
                                children: [
                                  for (var j = 0;
                                      j <
                                          jsonDecode(controller
                                                      .allCoursesDetailsData!
                                                      .description!)['data'][i]
                                                  ['table'][k]
                                              .length;
                                      j++)
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        jsonDecode(controller
                                                    .allCoursesDetailsData!
                                                    .description!)['data'][i]
                                                ['table'][k][j]
                                            .toString(),
                                        style: TextStyle(
                                          color: k == 0
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      for (var j = 0;
                          j <
                              jsonDecode(controller.allCoursesDetailsData!
                                      .description!)['data'][i]['list']
                                  .length;
                          j++)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              FontAwesome.circle,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                jsonDecode(controller.allCoursesDetailsData!
                                        .description!)['data'][i]['list'][j]
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
              ],
            ),
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 5),
            // decoration: BoxDecoration(
            //   color: ColorConst.primaryColor,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Row(
              children: [
                const Text(
                  'Requirements ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),

          requirements_row(
            controller.allCoursesDetailsData!,
          ),

          const SizedBox(
            height: 20,
          ),
          if (controller.allCoursesDetailsData!.faqs!.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: ColorConst.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'FAQs',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            )
          else
            const Text(''),
          const SizedBox(
            height: 10,
          ),
          reusableTileTwo(controller.allCoursesDetailsData!)
          // reusableTileTwo(controller.allCoursesDetailsData!)
        ],
      ),
    );
  }

  courseContent() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
        itemCount: controller.allCoursesDetailsData!.chapters!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 5,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: Text(
                    controller.allCoursesDetailsData!.chapters![index]['title'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                contentbuilder(index),
              ],
            ),
          );
        },
      ),
    );
  }

  List getCOntents(int index) {
    List newContents = [];
    for (var element in controller.allCoursesDetailsData!.chapters![index]
        ['chapter_items']) {
      if (checkFileType(element).contains("Demo") == false) {
        newContents.add(element);
      }
    }

    return newContents;
  }

  ListView contentbuilder(int index) {
    List newContents = getCOntents(index);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      shrinkWrap: true,
      itemCount: newContents.length,
      itemBuilder: (BuildContext context, int i) {
        final data = newContents[i];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade100,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              if (!controller.hasBought.value) {
                return;
              }
              if (controller.isInitialized.value) {
                controller.videoplayercontroller.pause();
              }
              if (data['type'] == "quiz") {
                Get.toNamed(
                  RoutesName.quizDetailsPageTwo,
                  arguments: newContents[i]['quiz']['id'],
                );
                return;
              }
              if (data['type'] == "text_lesson") {
                Get.to(
                  () => TextLessonPage(
                    title: data['text_lesson']['title'],
                    description: data['text_lesson']['content'],
                  ),
                );
                return;
              }
              if (data['type'] == 'session') {
                if (data['session'] == null) {
                  SnackBarService.showSnackBar(
                    context,
                    'No session found',
                  );
                  return;
                }
                Get.toNamed(
                  RoutesName.meetingDetailsPage,
                  arguments: {
                    'id': data['item_id'],
                    'imageCover': '',
                    'title': data['session']['title'],
                    'discription': data['session']['description'] ?? "",
                    'sessionId': data['session']
                  },
                );
                return;
              }
              learningPageController.openFile(
                type: newContents[i]['type'],
                url: newContents[i]['fileData']['file'],
              );
            },
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    checkFileType(
                      newContents[i],
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (controller.hasBought.value)
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  )
                else
                  const Icon(Icons.lock)
              ],
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Text(
                (i + 1).toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool isExpanded = false;

  demoWidget() {
    final data = controller.allCoursesDetailsData;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (controller.allCoursesDetailsData!.videoDemoSource == "youtube")
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: RoutesName.baseImageUrl +
                    controller.allCoursesDetailsData!.videoDemo!,
                width: Get.width,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 100,
                ),
              ),
            )
          else
            VideoPlayerWidget(
              controller: controller.videoplayercontroller,
              onFullScreen: (value) {
                setState(() {
                  isFullScreen = value;
                });
              },
            ),
          if (!isFullScreen)
            const SizedBox(
              height: 10,
            ),
          if (!isFullScreen)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data!.title!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 5,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          jsonDecode(data.description!)['data']
                                              [0]['imagess'],
                                      fit: BoxFit.contain,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          jsonDecode(data.description!)['data']
                                              [0]['facultyname'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          jsonDecode(data.description!)['data']
                                              [0]['qualifications'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          jsonDecode(data.description!)['data']
                                              [0]['Experience'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (jsonDecode(data.description!)['data'][0]
                                    ['description']
                                .toString()
                                .isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Description",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  for (int i = 0;
                                      i <
                                          jsonDecode(data.description!)['data']
                                                  [0]['description']
                                              .length;
                                      i++)
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 10,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text(
                                            jsonDecode(data.description!)[
                                                        'data'][0]
                                                    ['description'][i]['title']
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GetBuilder<AddToFavouriteController>(
                            init: AddToFavouriteController(),
                            initState: (_) {},
                            builder: (favController) {
                              bool? isFav = GetStorage().read(
                                "isFav${controller.allCoursesDetailsData!.slug!}",
                              );
                              favController.isFav = isFav ?? false;
                              return Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      favController.addToFav(
                                        controller.allCoursesDetailsData!.slug!,
                                      );
                                    },
                                    splashRadius: 25,
                                    icon: Icon(
                                      favController.isFav
                                          ? Icons.bookmark
                                          : Icons.bookmark_outline_outlined,
                                      color: favController.isFav
                                          ? ColorConst.primaryColor
                                          : Colors.black,
                                      size: 29,
                                    ),
                                  ),
                                  const Text(
                                    'Bookmark',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.videoplayercontroller.pause();
                                  final url =
                                      "https://aimpariksha.com/share.php?slug=${controller.allCoursesDetailsData!.slug!.replaceAll(" ", "_")}";
                                  Share.share(url);
                                },
                                splashRadius: 25,
                                icon: const Icon(
                                  Icons.share_outlined,
                                  color: Colors.black,
                                  size: 29,
                                ),
                              ),
                              const Text(
                                'Share',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (widget.latestWebinars != null &&
                          widget.latestWebinars!.isNotEmpty)
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Related Videos",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 190,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: relatedvideos.length,
                          itemBuilder: (context, index) {
                            final data = relatedvideos;
                            return InkWell(
                              onTap: () async {
                                final controller =
                                    Get.find<AllCoursesController>();
                                controller.getAllCourseDetails(
                                  data[index].slug!,
                                );

                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AllCoursesPageDetails(
                                              isDemo: true,
                                              latestWebinars: [
                                                ...data,
                                                widget.notIncludedLatestWebinars
                                              ],
                                              notIncludedLatestWebinars:
                                                  data[index],
                                            )));
                              },
                              child: Container(
                                width: 160,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                margin: const EdgeInsets.only(
                                    right: 10, top: 10, bottom: 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 90,
                                      width: 160,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: CachedNetworkImage(
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                                  Icons.hide_image_rounded),
                                          useOldImageOnUrlChange: true,
                                          imageUrl: RoutesName.baseImageUrl +
                                              data[index].thumbnail!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      height: 35,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                    Container(
                                      width: 160,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: ColorConst.primaryColor,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'View',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.white,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Icon getIcon(var data) {
    if (data == 'quiz') {
      return const Icon(Icons.quiz);
    }
    if (data == 'session') {
      return const Icon(Icons.school);
    }

    return const Icon(Icons.file_copy);
  }

  String getText(var data) {
    if (data == 'quiz') {
      return "Start";
    } else if (data == 'file') {
      return "View";
    } else if (data == 'session') {
      return "Join";
    }
    return "View";
  }

  String checkFileType(var data) {
    if (data['type'] == 'quiz') {
      return data['quiz']['title'];
    } else if (data['type'] == 'file') {
      return data['fileData']['title'];
    } else if (data['type'] == 'session') {
      return data['session'] == null ? "" : data['session']['title'];
    } else if (data['type'] == 'text_lesson') {
      return data['text_lesson']['title'];
    }
    return "";
  }

  Widget requirements_row(Course controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.webinarExtraDescription!.length,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return controller.webinarExtraDescription![index].type!
                .contains('requirements')
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesome.hand_o_right,
                      color: Colors.black,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        controller.webinarExtraDescription![index].value!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Container();
      },
    );
  }

  Future<bool> onexit() async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
            height: 120,
            child: Column(
              children: <Widget>[
                const Text("Are you sure you want to Buy this Course?"),
                Container(
                  margin: const EdgeInsets.only(top: 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.back(result: false);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  offset: const Offset(0.0, 1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0)
                            ],
                            color: ColorConst.buttonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Get.back();
                          // _openCheckout(
                          //     controller.allCoursesDetailsData!.price);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CoursesCheckOutPage()));
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  offset: const Offset(0.0, 1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0)
                            ],
                            color: ColorConst.buttonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                        ),
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

  Widget buildAdvanceExpandedTiles(
    AdvanceExpandedListTile tile,
    Course controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        color: Colors.grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 10, bottom: 10),
                child: Container(
                  height: 65,
                  width: 65,
                  decoration: BoxDecoration(
                      color: ColorConst.buttonColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(
                        tile.imgUrl,
                        color: Colors.white,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.title!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
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

  //
  // Widget reusableTabOne(Course controller) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10),
  //     child: ListView.builder(
  //       shrinkWrap: true,
  //       itemCount: 2,
  //       itemBuilder: (BuildContext context, index) {
  //         return ExpansionPanelList.radio(
  //           children: [
  //             ...expandedTilesList
  //                 .map((tile) => ExpansionPanelRadio(
  //                 value: tile.title,
  //                 headerBuilder: (context, isExpanded) =>
  //                     buildAdvanceExpandedTiles(tile,controller),
  //                 body: Column(
  //                   children: [
  //                     ...tile.tiles.map(buildAdvanceExpandedTiles).toList(),
  //                   ],
  //                 )))
  //                 .toList(),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }
  Widget reusableTileOne(Course controller) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
          itemCount: controller.chapters!.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade100)),
              child: ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                onExpansionChanged: (isExpanded) {
                  // browseCategory.subCategories!.isEmpty
                  //     ? Get.toNamed(RoutesName.categoryDetailsPage, arguments: [
                  //   browseCategory.id,
                  //   browseCategory.title,
                  //   null
                  // ])!
                  //     : Container();
                },
                backgroundColor: Colors.transparent,
                title: Text(
                  controller.chapters![index]['title'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: controller.chapters![index]['chapter_items'].isEmpty
                    ? const SizedBox()
                    : null,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    // itemCount:
                    //     controller.chapters![index]['chapter_items'].length,
                    itemCount: controller.files!.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade100)),
                        child: ExpansionTile(
                          leading: const CircleAvatar(
                            radius: 15,
                            child: Icon(
                              Icons.file_copy_rounded,
                              size: 15,
                            ),
                          ),
                          title: Text(
                            // controller.chapters![index]['chapter_items'][i]
                            //     ['type'],
                            controller.files![i]['title'],
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_downward,
                                          size: 17,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('312.87 kb'),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      downloadFile(
                                          controller.files![index]['file']);
                                      // downloadFunc(controller.files![index]['file']);
                                      isDownloading
                                          ? const SizedBox(
                                              height: 200,
                                              width: 100,
                                              child: Column(
                                                children: [
                                                  CircularProgressIndicator(),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text('Downloading File')
                                                ],
                                              ),
                                            )
                                          : SnackBarService.showSnackBar(
                                              context, 'File not downloadable');
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: ColorConst.buttonColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: const Center(
                                          child: Text(
                                            'Download',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }

  // Widget buildPlayPause() {
  //   return Positioned.fill(
  //     child: Align(
  //       alignment: Alignment.center,
  //       child: InkWell(
  //         onTap: !visible
  //             ? () {
  //                 setState(() {
  //                   visible = !visible;
  //                 });
  //               }
  //             : () {
  //                 setState(() {
  //                   isPlaying
  //                       ? controller.videoplayercontroller.pause()
  //                       : controller.videoplayercontroller.play();
  //                   isPlaying
  //                       ? animatedController.reverse()
  //                       : animatedController.forward();
  //                   isPlaying = !isPlaying;
  //                 });
  //               },
  //         child: AnimatedOpacity(
  //           opacity: visible ? 1.0 : 0.0,
  //           duration: const Duration(milliseconds: 500),
  //           child: AnimatedIcon(
  //             icon: AnimatedIcons.play_pause,
  //             progress: animatedController,
  //             color: Colors.white,
  //             size: 50,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // String videoDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final hours = twoDigits(duration.inHours);
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return [
  //     if (duration.inHours > 0) hours,
  //     minutes,
  //     seconds,
  //   ].join(": ");
  // }

  // changeFullScreen() {
  //   setState(() {
  //     isFullScreen = !isFullScreen;
  //   });
  //   log(isFullScreen.toString());
  //   if (isFullScreen) {
  //     SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.landscapeLeft,
  //       DeviceOrientation.landscapeRight,
  //     ]);
  //     SystemChrome.setEnabledSystemUIMode(
  //       SystemUiMode.immersiveSticky,
  //     );
  //   } else {
  //     SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.portraitUp,
  //       DeviceOrientation.portraitDown,
  //     ]);
  //     SystemChrome.setEnabledSystemUIMode(
  //       SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values,
  //     );
  //     SystemChrome.setSystemUIOverlayStyle(
  //       const SystemUiOverlayStyle(
  //         statusBarColor: Colors.transparent,
  //         statusBarIconBrightness: Brightness.dark,
  //       ),
  //     );
  //   }
  // }

  // Widget buildFullScreen(BuildContext context) {
  //   return Positioned.fill(
  //     bottom: 10,
  //     right: 10,
  //     child: Align(
  //       alignment: Alignment.bottomRight,
  //       child: InkWell(
  //         onTap: () {
  //           changeFullScreen();
  //         },
  //         child: const Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
  //           child: Icon(Icons.fullscreen, color: Colors.white),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildBackward() {
  //   return Positioned.fill(
  //       child: Padding(
  //     padding: const EdgeInsets.only(left: 70),
  //     child: Align(
  //         alignment: Alignment.centerLeft,
  //         child: AnimatedOpacity(
  //           opacity: visible ? 1.0 : 0.0,
  //           duration: const Duration(milliseconds: 500),
  //           child: IconButton(
  //             onPressed: !visible
  //                 ? () {
  //                     setState(() {
  //                       visible = !visible;
  //                     });
  //                   }
  //                 : () {
  //                     controller.videoplayercontroller.seekTo(
  //                         controller.videoplayercontroller.value.position -
  //                             const Duration(seconds: 5));
  //                   },
  //             icon: const Icon(
  //               Icons.fast_rewind_rounded,
  //               color: Colors.white,
  //               size: 28,
  //             ),
  //           ),
  //         )),
  //   ));
  // }

  // bool isMutted = true;

  // Widget buildMutetoggle() {
  //   return Positioned.fill(
  //     child: Padding(
  //       padding: const EdgeInsets.only(
  //         left: 0,
  //         bottom: 10,
  //       ),
  //       child: Align(
  //         alignment: Alignment.bottomLeft,
  //         child: IconButton(
  //           onPressed: () {
  //             isMutted
  //                 ? controller.videoplayercontroller.setVolume(1)
  //                 : controller.videoplayercontroller.setVolume(0);
  //             setState(() {
  //               isMutted = !isMutted;
  //             });
  //           },
  //           icon: Icon(
  //             isMutted ? Icons.volume_off : Icons.volume_up,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget reusableTileTwo(Course controller) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ListView.builder(
          // itemCount: controller.chapters!.length,
          itemCount: controller.faqs!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                onExpansionChanged: (isExpanded) {},
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,
                backgroundColor: Colors.transparent,
                title: Text(
                  "${index + 1}. ${controller.faqs![index]['title']}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // trailing: controller.chapters![index]['chapter_items'].isEmpty
                //     ? const SizedBox()
                //     : null,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 1,
                    padding: const EdgeInsets.all(0),
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 3,
                        ),
                        child: ListTile(
                          tileColor: Colors.transparent,

                          title: Text(
                            controller.faqs![index]['answer'],
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          // contentPadding: const EdgeInsets.all(0),

                          // onTap: () =>
                          // Get.toNamed(RoutesName.categoryDetailsPage, arguments: [
                          //   browseCategory.id,
                          //   browseCategory.title,
                          //   browseCategory.subCategories![0].id,
                          // ]),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget second_row(Course controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.webinarExtraDescription!.length,
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
      itemBuilder: (context, index) {
        if (controller.webinarExtraDescription![index].type!
            .contains('learning_materials')) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Icon(
                  FontAwesome.hand_o_right,
                  color: Colors.black.withOpacity(0.8),
                  size: 13,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    controller.webinarExtraDescription![index].value!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      // backgroundColor: Color(0xffedf3ed),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  String timeLeft(int seconds) {
    int diff = seconds;

    int days = diff ~/ (24 * 60 * 60);
    diff -= days * (24 * 60 * 60);
    int hours = diff ~/ (60 * 60);
    diff -= hours * (60 * 60);
    int minutes = diff ~/ (60);
    diff -= minutes * (60);

    int sec = diff % (60);

    String result =
        "${twoDigitNumber(days)} Days ${twoDigitNumber(hours)}h ${twoDigitNumber(minutes)}min ${twoDigitNumber(sec)}s";
    return result;
  }

  String twoDigitNumber(int? dateTimeNumber) {
    if (dateTimeNumber == null) return "0";
    if (dateTimeNumber == 9) return "0$dateTimeNumber";
    return (dateTimeNumber < 9 ? "0$dateTimeNumber" : dateTimeNumber)
        .toString();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentTime = DateTime.now();
      final countDownTime = DateTime.parse("2022-12-30");
      final diff = countDownTime.difference(currentTime).inSeconds;
      remainTime.value = timeLeft(diff);
    });
  }
}

/*void downloadFunc(String file) async {
  try {
    var dio = Dio();
    var res = await dio.download('', file);

    print(res);
  } catch (e) {
    print(e);
  }
}*/

class YtPlayer extends StatelessWidget {
  final YoutubePlayerController controller;
  final VoidCallback onFullScreen;
  final bool isFullScreen;
  final bool demo;
  const YtPlayer({
    super.key,
    required this.controller,
    required this.onFullScreen,
    this.isFullScreen = false,
    this.demo = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isFullScreen ? MediaQuery.of(context).size.height - 34 : 220,
      width: isFullScreen ? MediaQuery.of(context).size.width : double.infinity,
      child: YoutubePlayer(
        controller: controller,
        bottomActions: [
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          const PlaybackSpeedButton(),
          const SizedBox(width: 8.0),
          if (demo)
            IconButton(
              onPressed: onFullScreen,
              icon: Icon(
                isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<RestartWidgetState>()!.restartApp();
  }

  @override
  RestartWidgetState createState() => RestartWidgetState();
}

class RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
