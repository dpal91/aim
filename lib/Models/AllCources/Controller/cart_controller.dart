import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/snackbar.dart';
import '../Model/cart_model.dart';
import '../Model/checkout_model.dart';
import 'all_courses_controller.dart';

class CartController extends GetxController {
  var isLoading = true.obs;
  var isBtLoading = false.obs;
  CartData? cartData;
  var cartItem = 0.obs;

  @override
  void onInit() async {
    await getCart();
    super.onInit();
  }

  Future<void> getCart() async {
    try {
      var data = await ApiService.get(key: "cart/course_list");
      // log("getCart ${data.toString()}");
      if (data == null) {
        return;
      }
      var res = CartModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        cartData = res.data;
        cartCount.value = cartData!.carts!.length;
        isLoading(false);
        update();
      }
      return;
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
      isBtLoading(false);
      update();
    }
  }

  Future deleteFromCartUsingProductId(int productId) async {
    try {
      final id = cartData!.carts!
          .where((element) => element.webinar!.id == productId)
          .first
          .id;
      if (id == null) return;
      return deleteFromCart(id);
    } catch (_) {}
  }

  Future deleteFromCart(int id, {bool showNotification = true}) async {
    try {
      var data = await ApiService.get(key: 'cart/delete?id=$id');
      var res = json.decode(data);
      getCart();
      update();
      if (showNotification) {
        SnackBarService.showSnackBar(Get.context!, res["message"]);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }

  // whatever in the card now can be placed order
  Future<Order?> checkoutCart({String? body}) async {
    isBtLoading(true);
    update();
    try {
      var data = await ApiService.post(
          key: 'cart/checkout', body: body == null ? {} : {'type': "buy_now"});
      var decode = json.decode(data);
      var res = CheckoutModel.fromJson(decode);
      isBtLoading(false);
      update();
      return res.data!.order!;
    } on Exception catch (e) {
      debugPrint(e.toString());
      isBtLoading(false);
      update();
      return null;
    }
  }

  Future verifyPayment(int id, String paymentId, {bool refresh = false}) async {
    isBtLoading(true);
    update();
    try {
      var data = await ApiService.get(
        key: 'payments/verify?order_id=$id&razorpay_payment_id=$paymentId',
      );
      var res = json.decode(data);
      isBtLoading(false);
      if (res['statusCode'] == 200) {
        getCart();
        update();
        if (Get.isDialogOpen!) {
          Get.back();
        }
        if (refresh) {
          Get.back();
          Get.offAndToNamed(RoutesName.paymentSuccessPage);
        } else {
          Get.toNamed(RoutesName.paymentSuccessPage);
        }
        AllCoursesController controller = Get.put(AllCoursesController());
        controller.getAllCourse();
        SnackBarService.showSnackBar(Get.context!, res['message']);
      } else {
        Get.back();
        SnackBarService.showSnackBar(Get.context!, res["data"]['msg']);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }
}
