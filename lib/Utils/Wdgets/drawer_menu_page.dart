import 'package:cached_network_image/cached_network_image.dart';
import '../../Models/Forum/Pages/fourm_page.dart';
import '../../Models/Home/Controller/home_controller.dart';
import '../../Models/Meeting/Pages/meeting_page.dart';
import '../../Models/Profile/Pages/profile_page.dart';
import '../../Models/Quizes/Pages/quizes_page.dart';
import '../BottomNavigation/controller.dart';
import '../Constants/constants_colors.dart';
import '../Constants/global_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Models/PreviousPapers/previous_paper_page.dart';
import '../Constants/routes.dart';

final box = GetStorage();

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);
  final homeController = Get.isRegistered()
      ? Get.find<HomeController>()
      : Get.put<HomeController>(HomeController());
  final bottomNavigationController = Get.put(BottomNavigationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.7, 12),
          end: const Alignment(1, -2),
          stops: const [0.2, 0.5, 1],
          colors: [
            Colors.green,
            Colors.teal,
            ColorConst.primaryColor,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      width: Get.width / 1.6,
      child: GetBuilder<BottomNavigationController>(
        init: BottomNavigationController(),
        initState: (_) {},
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    Get.to(() => const ProfilePage());
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 43,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: CachedNetworkImageProvider(
                              homeController.profileDetails['profile_image'] ==
                                          "" ||
                                      homeController.profileDetails[
                                              'profile_image'] ==
                                          null
                                  ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                                  : homeController
                                      .profileDetails['profile_image'],
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 14,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  box.read('userName') ?? "User",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                drawerItems(
                  icon: Icons.home_rounded,
                  title: "Home",
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    controller.tabIndex.value = 0;
                  },
                ),
                drawerItems(
                  icon: Ionicons.bookmark,
                  title: "My Bookmarks",
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    Get.toNamed(RoutesName.favoutiesPage);
                  },
                ),
                drawerItems(
                  icon: Icons.quiz,
                  title: "Previous Years Papers",
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    Get.to(() => const PreviousPapersPage());
                  },
                ),
                drawerItems(
                  icon: Icons.book_rounded,
                  title: "My Content",
                  hight: 30,
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    Get.toNamed(RoutesName.allCoursesPage);
                  },
                ),
                drawerItems(
                  icon: Icons.tv,
                  title: "Live Class",
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    Get.to(
                      () => const MaeetingsPage(
                        isBack: true,
                      ),
                    );
                  },
                ),
                drawerItems(
                  icon: Icons.lightbulb_outline_rounded,
                  title: "Quizzes",
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    // Directly take user to quiz page from menu option
                    Get.to(
                      () => QuizesPage(
                          testSeries: Get.find<HomeController>().testSeries),
                    );
                  },
                ),
                drawerItems(
                  icon: Icons.notifications,
                  title: "Job Alerts",
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    // controller.tabIndex.value = 4;
                    Get.to(() => const JobAlertsPage());
                  },
                ),
                // Hide for current build only
                if (false)
                  drawerItems(
                    icon: Ionicons.trophy,
                    title: "Subscription",
                    onTap: () {
                      ZoomDrawer.of(context)!.close();
                      Get.toNamed(RoutesName.subscriptionPage);
                    },
                  ),
                drawerItems(
                  icon: Icons.logout_rounded,
                  title: "Logout",
                  onTap: () async {
                    box.remove(RoutesName.token);
                    box.remove(RoutesName.id);
                    box.erase();
                    try {
                      await FirebaseAuth.instance.signOut();
                      await GoogleSignIn().signOut();
                    } catch (e) {
                      // TODO
                    }
                    Get.offAndToNamed(RoutesName.loginInPageEmail);
                    isSkippedButtonPressed =
                        false; // reset skipped button to default
                    GetStorage().write("skip", isSkippedButtonPressed);
                  },
                ),
                drawerItems(
                  icon: Icons.delete_forever,
                  title: "Delete Account",
                  onTap: () async {
                    box.remove(RoutesName.token);
                    box.remove(RoutesName.id);
                    box.erase();
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();
                    Get.offAndToNamed(RoutesName.loginInPageEmail);
                    isSkippedButtonPressed =
                        false; // reset skipped button to default
                    GetStorage().write("skip", isSkippedButtonPressed);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget drawerItems({
    required String title,
    void Function()? onTap,
    IconData? icon,
    double? hight,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
          height: 1,
        ),
      ],
    );
  }
}
