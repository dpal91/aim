import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
  var tabIndex = 0.obs;
  final zoomDrawerController = ZoomDrawerController();

  @override
  void onInit() {
    // Get.put(HomeController());
    super.onInit();
    tabIndex.value;
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}
