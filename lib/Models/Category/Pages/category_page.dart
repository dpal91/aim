import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Utils/BottomNavigation/controller.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../Controller/category_controller.dart';

// ignore: must_be_immutable
class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});
  CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.scafoldColor,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: const Text(
          "Browse Categories",
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
          return controller.isLoading.value ||
                  controller.isCategoryLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 15.0, top: 15),
                    //   child: Text(
                    //     'Trending',
                    //     style: TextStyle(
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 110,
                    //   child: ListView.separated(
                    //     physics: const BouncingScrollPhysics(),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: controller.trendingCategory.length,
                    //     itemBuilder: (context, index) =>
                    //         reusableCard(controller.trendingCategory[index]),
                    //     separatorBuilder: (context, _) =>
                    //         const SizedBox(width: 0),
                    //   ),
                    // ),
                    // const Divider(),
                    // const Padding(
                    //   padding: EdgeInsets.all(15.0),
                    //   child: Text(
                    //     'Browse Categories',
                    //     style: TextStyle(
                    //         fontSize: 14, fontWeight: FontWeight.bold),
                    //   ),
                    // ),

                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.browseCategory.length,
                          separatorBuilder: (context, _) => Divider(
                            thickness: 1.2,
                            height: 1,
                            color: Colors.grey[100],
                          ),
                          itemBuilder: (context, index) {
                            final mycid =
                                GetStorage().read(RoutesName.categoryId);
                            final browseCategory =
                                controller.browseCategory[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                onTap: () {
                                  controller.changeCategory(browseCategory.id);
                                },
                                // leading: Container(
                                //   padding: const EdgeInsets.all(8),
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(100),
                                //     color: Colors.grey[100],
                                //   ),
                                //   child: CachedNetworkImage(
                                //     imageUrl:
                                //         "${RoutesName.baseImageUrl}${browseCategory.icon}",
                                //     width: 25,
                                //   ),
                                // ),
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey[100],
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${RoutesName.baseImageUrl}${browseCategory.icon}",
                                    width: 25,
                                  ),
                                ),
                                title: Text(
                                  browseCategory.title,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                // subtitle: Text(
                                //   '(${browseCategory.subCategories!.length} Exams)',
                                //   style: TextStyle(
                                //     color: Colors.grey[500],
                                //     fontSize: 13,
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                                trailing: mycid == browseCategory.id ||
                                        mycid == browseCategory.parentId
                                    ? Checkbox(
                                        value: true,
                                        shape: const CircleBorder(),
                                        onChanged: (value) {},
                                      )
                                    : Checkbox(
                                        value: false,
                                        shape: const CircleBorder(),
                                        onChanged: (value) {
                                          controller.changeCategory(
                                              browseCategory.id);
                                        },
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ) //vertical list-view
                  ],
                );
        },
      ),
    );
  }
}
