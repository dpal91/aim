import '../../Utils/Constants/constants_colors.dart';
import '../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Utils/Constants/routes.dart';
import '../../Utils/Wdgets/elevated_button.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({Key? key}) : super(key: key);

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Payment Success',
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/57490-successful.json',
              height: 200.0,
              controller: controller,
              repeat: true,
              reverse: true,
              animate: true, onLoaded: (composition) {
            controller
              ..duration = composition.duration
              ..forward();
          }),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
            child: Text(
              'Successful !!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          subtitle(),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: MyElevatedButton(
                label: "Go to My courses",
                onPressed: () {
                  Get.toNamed(RoutesName.allCoursesPage);
                },
              ))
        ],
      ),
    );
  }

  Widget subtitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
      child: Text(
        'Your payment was done successfully.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12, color: Colors.black54),
      ),
    );
  }
}
