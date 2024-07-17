import 'dart:io' show Platform;

import '../../Models/AllCources/Pages/all_courses_page.dart';
import '../../Models/Category/Pages/category_page.dart';
import '../../Models/Home/Pages/lms_newest_home_page.dart';
import '../../Models/Meeting/Pages/meeting_page.dart';
import 'controller.dart';
import '../Constants/constans_assets.dart';
import '../Constants/constants_colors.dart';
import '../Constants/global_data.dart';
import '../Wdgets/dialog_login.dart';
import '../Wdgets/drawer_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../Recording/my_recordings.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});
  BottomNavigationController controller = Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int index = controller.tabIndex.toInt();
      return Scaffold(
        backgroundColor: ColorConst.scafoldColor,
        body: Stack(children: [
          ZoomDrawer(
            controller: controller.zoomDrawerController,
            // openCurve: const Interval(0.0, 1.0, curve: Curves.),
            menuBackgroundColor: Colors.white,
            borderRadius: 24.0,
            showShadow: true,
            angle: 0.0,
            boxShadow: const [BoxShadow(blurRadius: 5)],
            drawerShadowsBackgroundColor: Colors.white,
            slideWidth: MediaQuery.of(context).size.width * 0.69,
            duration: .5.seconds,
            reverseDuration: .5.seconds,
            menuScreen: MenuPage(),
            mainScreen: Scaffold(
              // drawer: const MyDrawer(),
              body: WillPopScope(
                onWillPop: () async {
                  if (index == 0) {
                    onexit();
                    return true;
                  } else {
                    controller.changeTabIndex(0);
                    return false;
                  }
                },
                child: IndexedStack(
                  index: index,
                  children: [
                    // HomePage(),
                    const HomePageNewest(),
                    CategoryPage(),
                    // const CurrentAffairPage(),
                    const AllCoursesPage(
                      showbar: false,
                    ),
                    // const QuizesPage(),
                    const MaeetingsPage(isBack: false),
                    // const JobAlertsPage()
                    // ProfilePage()
                    const MyRecordingPage(),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                height: kBottomNavigationBarHeight + (Platform.isIOS ? 40 : 10),
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(0.0, 0.0), // shadow direction: bottom right
                    )
                  ],
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: BottomNavigationBar(
                  selectedItemColor: ColorConst.buttonColor,
                  currentIndex: index,
                  onTap: (index) {
                    if (index > 0 && isSkippedButtonPressed) {
                      DialogLogin().dialog(context);
                    } else {
                      controller.changeTabIndex(index);
                    }
                  },
                  type: BottomNavigationBarType.fixed,
                  items: [
                    bottomBar(
                      icon: SvgPicture.asset(
                        Images.svgHome,
                        color: controller.tabIndex.value == 0
                            ? ColorConst.buttonColor
                            : Colors.grey.shade500,
                      ),
                      label: "Home",
                    ),
                    bottomBar(
                      icon: Image.asset(
                        Images.category,
                        scale: 26,
                        color: controller.tabIndex.value == 1
                            ? ColorConst.buttonColor
                            : Colors.grey.shade500,
                      ),
                      label: "Category",
                    ),
                    bottomBar(
                      icon: SvgPicture.asset(
                        Images.svgDoc,
                        color: controller.tabIndex.value == 2
                            ? ColorConst.buttonColor
                            : Colors.grey.shade500,
                      ),
                      label: "Content",
                    ),
                    bottomBar(
                      icon: const Icon(Icons.tv),
                      label: "Live Class",
                    ),
                    bottomBar(
                      icon: Icon(
                        Ionicons.videocam,
                        color: controller.tabIndex.value == 4
                            ? ColorConst.buttonColor
                            : Colors.grey.shade500,
                      ),
                      label: "Recording",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }

  BottomNavigationBarItem bottomBar({required Widget icon, String? label}) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
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
            margin:
                const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text("Are you sure you want to exit?"),
                Container(
                  margin: const EdgeInsets.only(top: 22, bottom: 10),
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
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
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
}
