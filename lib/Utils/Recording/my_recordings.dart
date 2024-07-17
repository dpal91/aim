import '../../Models/AllCources/Controller/all_courses_controller.dart';
import '../BottomNavigation/controller.dart';
import '../Constants/constants_colors.dart';
import 'session_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyRecordingPage extends StatefulWidget {
  const MyRecordingPage({Key? key}) : super(key: key);

  @override
  State<MyRecordingPage> createState() => _MyRecordingPageState();
}

class _MyRecordingPageState extends State<MyRecordingPage> {
  final controller = Get.put(AllCoursesController());

  @override
  void initState() {
    super.initState();
    controller.getRecordings();
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Text(
          "My Recordings",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorConst.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            final controller = Get.find<BottomNavigationController>();
            controller.changeTabIndex(0);
          },
        ),
      ),
      body: Obx(
        () {
          if (controller.isRecording.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            onRefresh: () async {
              await controller.getRecordings();
              _refreshController.refreshCompleted();
            },
            child: ListView.builder(
              itemCount: controller.myClasses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => SessionPage(
                          title: controller.myClasses[index].webinar!.title!,
                          slug: controller.myClasses[index].webinar!.slug!,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            // radius: 15,
                            backgroundColor:
                                ColorConst.primaryColor.withOpacity(0.2),
                            child: Icon(
                              Ionicons.videocam,
                              color: ColorConst.primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              controller.myClasses[index].webinar!.title!,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: ColorConst.primaryColor,
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
