import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import '../Model/all_courses_details_model.dart';
import '../Model/all_courses_model.dart';
import '../Model/checkout_model.dart';
import '../Model/purchased_model.dart';
import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../Utils/Wdgets/snackbar.dart';
import '../../Home/Controller/home_controller.dart';

class AllCoursesController extends GetxController {
  var isLoading = true.obs;
  RxBool isFullScreen = false.obs;
  var allCourseData = <AllCourseData>[].obs;
  var purchasedCourseData = <SalesData>[].obs;
  var myClasses = <SalesData>[].obs;
  var hasBought = false.obs;
  var isFav = false.obs;
  TextEditingController reviewController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  Course? allCoursesDetailsData;
  YoutubePlayerController? ytController;
  late VideoPlayerController videoplayercontroller;
  RxBool isInitialized = false.obs;

  initvideoController({
    required String url,
  }) async {
    videoplayercontroller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        isInitialized.value = true;
        videoplayercontroller.play();
        update();
      });
  }

  disposeVideoController() {
    if (isInitialized.value) {
      videoplayercontroller.dispose();
      isInitialized.value = false;
      update();
    }
  }

  Future getAllCourseDetails(String slug) async {
    // const String sampleSlug = "Complete Course For NDA";
    isLoading(true);
    try {
      var data = await ApiService.get(key: "course_detail?slug=$slug");
      if (data == null) {
        return;
      }
      var res = AllCoursesDetailsModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        allCoursesDetailsData = res.data!.course;
        hasBought.value = res.data!.hasBought!;
        // log("Url: ${allCoursesDetailsData!.videoDemo}");
        if (allCoursesDetailsData!.videoDemoSource == "youtube") {
          String initialVideoId = allCoursesDetailsData!.videoDemo!;
          var id = YoutubePlayer.convertUrlToId(initialVideoId);
          if (id != null) {
            ytController = YoutubePlayerController(
              initialVideoId: id,
              flags: const YoutubePlayerFlags(
                loop: true,
              ),
            );
          }
        } else {
          if (allCoursesDetailsData!.videoDemo != null) {
            initvideoController(
              url:
                  "${RoutesName.baseImageUrl}${allCoursesDetailsData!.videoDemo}",
            );
          }
        }
        isLoading(false);
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  closeFunction() async {
    isLoading.value = false;
    Get.back();
  }

  RxBool islinearLoading = false.obs;

  Future<AllCoursesDetailsModel?> getDetails(String slug) async {
    // const String sampleSlug = "Complete Course For NDA";
    islinearLoading(true);
    try {
      var data = await ApiService.get(key: "course_detail?slug=$slug");
      // debugPrint(data "coursedata");
      var res = AllCoursesDetailsModel.fromJson(json.decode(data));
      islinearLoading(false);
      if (res.statusCode == 200) {
        return res;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<AllCoursesDetailsModel?> getCurrentAffairsData(String slug) async {
    // const String sampleSlug = "Complete Course For NDA";
    // log("CurrentAffairs: $slug");
    try {
      var data = await ApiService.get(key: "course_detail?slug=$slug");

      var res = AllCoursesDetailsModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        return res;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future addToCart(
    int? itemId, {
    bool showNotification = true,
  }) async {
    try {
      var data = await ApiService.post(key: 'cart/store', body: {
        "item_id": itemId.toString(),
        "item_name": "webinar_id",
      });
      var res = json.decode(data);
      if (res['statusCode'] == 200) {
        if (showNotification) {
          SnackBarService.showSnackBar(Get.context!, res["message"]['title']);
        }
      } else {
        if (showNotification) {
          SnackBarService.showSnackBar(Get.context!, res["message"]);
        }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      SnackBarService.showSnackBar(
        Get.context!,
        "Something went wrong!, Pls try again later",
      );
      isLoading(false);
    }
    final homeController = Get.find<HomeController>();
    // homeController.getCart();
  }

  // check for applied coupon code and calculate total amount
  Future<Map<String, dynamic>?> applyCoupon({
    required String code,
    String? type = "buy_now",
  }) async {
    Get.dialog(
      Center(
        child: WillPopScope(
          onWillPop: () async => true,
          child: const CircularProgressIndicator(),
        ),
      ),
      barrierDismissible: false,
    );
    var response = await ApiService.post(
      key: 'cart/coupon/validate',
      body: {
        "coupon": code,
        "type": type,
      },
    );
    final data = json.decode(response);
    return data;
  }

  // show order summery bottom sheet using this api
  Future<Map<String, dynamic>?> checkoutDirectly() async {
    Get.dialog(
      Center(
        child: WillPopScope(
          onWillPop: () async => true,
          child: const CircularProgressIndicator(),
        ),
      ),
      barrierDismissible: false,
    );
    var response = await ApiService.post(
      key: 'cart/buy_now',
      body: {
        "item_id": allCoursesDetailsData!.id.toString(),
        "item_name": "buy_now"
      },
    );
    debugPrint(response +
        "------------------------------------------------------------------------------------------------");
    final data = json.decode(response);
    if (data['statusCode'] == 200) {
      return data;
    } else {
      Get.back();
      SnackBarService.showSnackBar(Get.context!, data['message'] ?? "");
    }
    return null;
  }

  Future<List<SalesData>> getAllCourse() async {
    isLoading(true);
    var data = await ApiService.get(key: "purchases");
    var res = PurchasedModel.fromJson(json.decode(data));
    purchasedCourseData.value = res.data!.sales!.data!;
    isLoading(false);
    return res.data!.sales!.data!;
  }

  RxBool isRecording = false.obs;
  Future getRecordings() async {
    isRecording(true);
    myClasses.clear();
    var data = await ApiService.get(key: "purchases");
    var res = PurchasedModel.fromJson(json.decode(data));
    var newList = res.data!.sales!.data!.where((element) {
      log("Type: ${element.type}");
      return element.webinar!.type == "webinar";
    }).toList();
    myClasses(newList);
    isRecording(false);
  }

  RxBool isdetailsLoading = false.obs;
  Future<Map<String, dynamic>?> getRecordingDetails(int id) async {
    // log("Id: $id");
    isdetailsLoading(true);
    var data = await ApiService.get(key: "meetings/getrecordinglist?id=$id");
    var res = jsonDecode(data);
    if (res['statusCode'] == 200) {
      isdetailsLoading(false);
      update();
      return res;
    }
    return null;
  }

  double getAverageRating(List data) {
    double sum = 0.0;
    // looping over data array
    if (data.isEmpty) {
      return 0;
    }
    for (var item in data) {
      //getting the key direectly from the name of the key
      sum += double.parse("${item["rates"]}");
    }
    return double.parse((sum / data.length).toString());
  }

  double getRateCount(double rateCount) {
    return 0;
  }

  double getContentQuality(List data) {
    double sum = 0.0;
    // looping over data array
    if (data.isEmpty) {
      return 0;
    }
    for (var item in data) {
      sum += double.parse("${item["content_quality"]}");
    }
    return double.parse((sum / data.length).toString());
  }

  double getInstructorSkills(List data) {
    double sum = 0.0;
    if (data.isEmpty) {
      return 0;
    }
    // looping over data array
    for (var item in data) {
      sum += double.parse("${item["instructor_skills"]}");
    }
    return double.parse((sum / data.length).toString());
  }

  double getPurchaseWorth(List data) {
    double sum = 0.0;
    if (data.isEmpty) {
      return 0;
    }
    // looping over data array
    for (var item in data) {
      sum += double.parse("${item["purchase_worth"]}");
    }
    return double.parse((sum / data.length).toString());
  }

  double getSupportQuality(List data) {
    double sum = 0.0;
    if (data.isEmpty) {
      return 0;
    }
    // looping over data array
    for (var item in data) {
      sum += double.parse("${item["support_quality"]}");
    }
    return double.parse((sum / data.length).toString());
  }

  late Rx<Order?> orderData;

  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  final String _productID = '25.aimpariksha.com';

  bool _available = true;
  final RxList<ProductDetails> _products = <ProductDetails>[].obs;
  final RxList<PurchaseDetails> _purchases = <PurchaseDetails>[].obs;

  get getProductList => _products;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  void onInit() {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      _purchases.addAll(purchaseDetailsList);
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (Object error) {
      // handle error here.
      _subscription.cancel();
    });
    _initialize();

    super.onInit();
  }

  void _initialize() async {
    _available = await _inAppPurchase.isAvailable();

    List<ProductDetails> products = await _getProducts(
      productIds: <String>{_productID},
    );

    _products.value = products;
  }

  Future<List<ProductDetails>> _getProducts(
      {required Set<String> productIds}) async {
    ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(productIds);

    return response.productDetails;
  }

  void subscribe({required ProductDetails product}) async {
    try {
      EasyLoading.show(
          indicator: const CircularProgressIndicator(),
          status: "Loading...",
          maskType: EasyLoadingMaskType.black);

      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: product);

      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
      await Future.delayed(const Duration(seconds: 6));
    } on PlatformException catch (issue) {
      Get.snackbar(
        'Error',
        issue.message.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      debugPrint("Err : PlatformException subscribe $issue");
    } on Exception catch (_, e) {
      debugPrint("Err : Exception subscribe $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          //  _showPendingUI();
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          bool valid = await _verifyPurchase(purchaseDetails);
          if (!valid) {
            _handleInvalidPurchase(purchaseDetails);
          }
          break;
        case PurchaseStatus.error:
          debugPrint("${purchaseDetails.error!}");
          break;
        default:
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  ListTile buildProduct({required ProductDetails product}) {
    return ListTile(
      leading: const Icon(Icons.attach_money),
      title: Text('${product.title} - ${product.price}'),
      subtitle: Text(product.description),
      trailing: ElevatedButton(
        onPressed: () {
          subscribe(product: product);
        },
        child: const Text(
          'Subscribe',
        ),
      ),
    );
  }

  ListTile _buildPurchase({required PurchaseDetails purchase}) {
    if (purchase.error != null) {
      return ListTile(
        title: Text('${purchase.error}'),
        subtitle: Text(purchase.status.toString()),
      );
    }

    String? transactionDate;
    if (purchase.status == PurchaseStatus.purchased) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(purchase.transactionDate!),
      );
      transactionDate = ' @ ${DateFormat('yyyy-MM-dd HH:mm:ss').format(date)}';
    }

    return ListTile(
      title: Text('${purchase.productID} ${transactionDate ?? ''}'),
      subtitle: Text(purchase.status.toString()),
    );
  }
}
