import 'package:cached_network_image/cached_network_image.dart';
import '../Controller/cart_controller.dart';
import '../Model/cart_model.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Home/Controller/home_controller.dart';

class CoursesCheckOutPage extends StatefulWidget {
  const CoursesCheckOutPage({Key? key}) : super(key: key);

  @override
  State<CoursesCheckOutPage> createState() => _CoursesCheckOutPageState();
}

class _CoursesCheckOutPageState extends State<CoursesCheckOutPage> {
  late Razorpay razorpay;
  CartController cartController = Get.put(CartController());

  int? orderId;
  List<Carts>? itemData;
  List<Carts> deleted = [];

  @override
  void initState() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    cartController.getCart();
    super.initState();
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // print(response.paymentId);
    cartController.verifyPayment(orderId!, response.paymentId!);
    // Get.toNamed(RoutesName.paymentSuccessPage);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
  }

  void _openCheckout(price) {
    final amount = double.parse((price * 100).toStringAsFixed(2));
    var options = {
      'key': 'rzp_test_12NU2uJHBrgQPX',
      'amount': amount,
      'name': 'Live Divine',
      // 'order_id' : orderId,
      'description': 'Purchase your course',
      'timeout': 300,
    };
    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  double cal(int value) {
    double percent = (10 / 100) * value.toDouble();
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, deleted);
        return false;
      },
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Checkout',
          backgroundColor: ColorConst.primaryColor,
          titleColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context, deleted);
            },
          ),
        ),
        body: GetBuilder<CartController>(
          init: CartController(),
          initState: (_) {},
          builder: (controller) {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : controller.cartData!.carts!.isEmpty
                    ? const Center(child: Text("Please add some courses"))
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: cartDetails(
                          context,
                          controller.cartData,
                        ),
                      );
          },
        ),
      ),
    );
  }

  Widget cartDetails(
    BuildContext context,
    CartData? cartData,
  ) {
    return Column(
      children: [
        Expanded(child: crashCoursesTwo(cartData!.carts)),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '₹ ${cartData.subTotal}',
                      style: const TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Discount',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      '₹ ${cartData.totalDiscount}',
                      style: const TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tax(10.0%)',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '₹ ${cartData.taxPrice!}',
                      style: const TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                    Text(
                      '₹ ${cartData.total!}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: GetBuilder<CartController>(
                        init: CartController(),
                        initState: (_) {},
                        builder: (controller) {
                          return MyElevatedButton(
                            isLoading: controller.isBtLoading.value,
                            label: 'CheckOut',
                            onPressed: () async {
                              await controller.checkoutCart().then((value) {
                                if (value != null) {
                                  _openCheckout(value.totalAmount);
                                  setState(() {
                                    orderId = value.id;
                                  });
                                }
                                final homeController =
                                    Get.find<HomeController>();
                                homeController.getCart();
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget crashCoursesTwo(
    List<Carts>? data,
  ) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data!.length,
      itemBuilder: (BuildContext context, index) {
        return Row(
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin: const EdgeInsets.only(
                    left: 12, right: 5, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    //
                    Stack(
                      children: [
                        SizedBox(
                          width: Get.width * 0.38,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                                imageUrl: RoutesName.baseImageUrl +
                                    data[index].webinar!.thumbnail!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: Get.width * 0.42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].webinar!.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  data[index].webinar!.price != null
                                      ? Row(
                                          children: [
                                            const Text('₹',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 15)),
                                            Text(
                                              "${data[index].webinar!.price}",
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        )
                                      : const Text(
                                          'Free',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          ),
                          GetBuilder<CartController>(
                            init: CartController(),
                            initState: (_) {},
                            builder: (controller) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                width: 40,
                                height: 40,
                                child: IconButton(
                                  onPressed: () {
                                    deleted.add(
                                        controller.cartData!.carts![index]);

                                    debugPrint(
                                        'LOG : cart delete : ${controller.cartData!.carts![index].id!}');
                                    controller.deleteFromCart(
                                      controller.cartData!.carts![index].id!,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        );
      },
    );
  }
}
