import 'package:cached_network_image/cached_network_image.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../AllCources/Pages/all_courses_pages_details.dart';
import '../Controller/favourite_controller.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class FavoutiesPage extends StatefulWidget {
  const FavoutiesPage({Key? key}) : super(key: key);

  @override
  State<FavoutiesPage> createState() => _FavoutiesPageState();
}

class _FavoutiesPageState extends State<FavoutiesPage> {
  final homeController = Get.put(AllCoursesController());

  final favouriteController = Get.put(FavouriteController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      favouriteController.getFavouriteList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Bookmarks',
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        return favouriteController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : favoriteCourses();
      }),
    );
  }

  Widget favoriteCourses() {
    final favouriteController = Get.find<FavouriteController>();

    if (favouriteController.favouriteList.isEmpty) {
      return const Center(
        child: Text('No Courses Bookmarked'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: favouriteController.favouriteList.length,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
          onTap: () {
            homeController.getAllCourseDetails(
              favouriteController.favouriteList[index].webinar.slug,
            );
            Get.to(
              () => AllCoursesPageDetails(
                isDemo:
                    favouriteController.favouriteList[index].webinar.price == 0
                        ? true
                        : false,
              ),
            )?.then((value) => favouriteController.getFavouriteList());
          },
          child: Container(
            width: Get.width,
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, .1),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        RoutesName.baseImageUrl +
                            favouriteController
                                .favouriteList[index].webinar.thumbnail,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        favouriteController.favouriteList[index].webinar.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              // color: ColorConst.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'View',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.red,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
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
