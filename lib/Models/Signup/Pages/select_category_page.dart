import '../../Category/Model/category_model.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Category/Controller/category_controller.dart';
import '../Controllers/signuo_landing_controller.dart';

class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({Key? key}) : super(key: key);

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  int selectedId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Select Category',
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CategoryController>(
              init: CategoryController(),
              initState: (_) {},
              builder: (controller) {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: controller.browseCategory.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.62,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.selectedVal =
                              controller.browseCategory[index].title;
                          controller.selectedId =
                              controller.browseCategory[index].id;
                          setState(() {
                            selectedId = controller.browseCategory[index].id;
                          });
                          controller.update();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: controller.selectedId ==
                                    controller.browseCategory[index].id
                                ? ColorConst.primaryColor
                                : Colors.grey.shade100,
                            border: Border.all(
                              color: controller.selectedId !=
                                      controller.browseCategory[index].id
                                  ? ColorConst.primaryColor
                                  : Colors.transparent,
                              width: 0.4,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      controller.browseCategory[index].title,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: controller.selectedId ==
                                                controller
                                                    .browseCategory[index].id
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  /*ImageIcon(
                                    NetworkImage(
                                      RoutesName.baseImageUrl +
                                          controller.browseCategory[index].icon,
                                    ),
                                    */ /*color:
                                        controller.selectedId == controller.browseCategory[index].id
                                            ? Colors.white
                                            : Colors.black,*/ /*
                                  ),*/
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  "( ${getSubCategory(subCategories: controller.browseCategory[index].subCategories!)} )",
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: controller.selectedId ==
                                            controller.browseCategory[index].id
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Obx(
            () => Get.find<SignupLandingController>().isLoading.value
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  )
                : selectedId == 0
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: ColorConst.primaryColor,
                          ),
                          onPressed: () async {
                            final controller =
                                Get.find<SignupLandingController>();

                            await controller.sendOtp(selectedId);
                          },
                          child: const Text("Next"),
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  getSubCategory({
    required List<BrowseCategory> subCategories,
  }) {
    final List<String> subCategory = [];
    for (int i = 0; i < subCategories.length; i++) {
      subCategory.add(subCategories[i].title);
    }
    return subCategory.join(', ');
  }
}
