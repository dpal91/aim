import '../../Utils/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  double opacity = 0;
  double opacity0 = 0;
  final box = GetStorage();
  bool isinited = false;

  @override
  void initState() {
    String? token = box.read(RoutesName.token);
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.offAndToNamed(token == null
            ? RoutesName.onboardingPages
            : RoutesName.bottomNavigation);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo_ic.jpg',
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
        ),
      ),
    );
  }
}
