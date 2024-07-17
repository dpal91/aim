import 'package:cached_network_image/cached_network_image.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../Controller/category_details_controller.dart';
import '../Widgets/category_details_widgets.dart';
import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({Key? key}) : super(key: key);

  @override
  State<CategoryDetailsPage> createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  CategoryDetailsController controller = Get.put(CategoryDetailsController());

  bool isChecked = false;
  bool status = false;
  String? groupValue;
  String title = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200]!.withOpacity(.5),
      appBar: MyAppBar(
        centerTitle: true,
        title: title,
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
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
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.categoryDetails.isEmpty
                ? const Center(child: Text("Coming Soon"))
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        _header(),
                        const SizedBox(
                          height: 20,
                        ),
                        // _body(),
                        _footer(context),
                      ],
                    ),
                  );
      }),
    );
  }

  Widget _footer(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GetBuilder<AllCoursesController>(
        init: AllCoursesController(),
        initState: (_) {},
        builder: (cnt) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: controller.categoryDetails.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(RoutesName.allCoursesPageDetails);
                cnt.getAllCourseDetails(
                    controller.categoryDetails[index].slug!);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 100,
                      width: 180,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(RoutesName
                                      .baseImageUrl +
                                  controller.categoryDetails[index].thumbnail!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 23.0, top: 10),
                    child: Text(
                      controller.categoryDetails[index].title!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 40, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '₹ ',
                              style: TextStyle(
                                color: ColorConst.greenColor,
                                fontSize: 15,
                              ),
                            ),
                            controller.categoryDetails[index].price != null
                                ? Text(
                                    controller.categoryDetails[index].price!
                                        .toString(),
                                    style: TextStyle(
                                      color: ColorConst.greenColor,
                                      fontSize: 14,
                                    ),
                                  )
                                : Text(
                                    'Free',
                                    style: TextStyle(
                                      color: ColorConst.greenColor,
                                      fontSize: 14,
                                    ),
                                  ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConst.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "View",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
            onTap: () {
              _modalBottomSheetMenuOptions(context);
            },
            child: Container(
              width: 120,
              decoration: BoxDecoration(
                color: ColorConst.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Images.svgOptions,
                    height: 20,
                    width: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    "Options",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
            )),
        GestureDetector(
          onTap: () {
            _modalBottomSheetMenuFilter(context);
          },
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: ColorConst.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Images.svgFilter,
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 6,
                ),
                const Text(
                  "Sort",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        'Featured Courses',
        style: TextStyle(
            color: Colors.black,
            fontFamily: "Nunito",
            fontSize: 18,
            fontWeight: FontWeight.w900),
      ),
    );
  }

  void _modalBottomSheetMenuFilter(context) {
    _botomSheet(
      context,
      children: [
        reusableTitleTwo('Level'),
        reusableCheckBoxes('Begginer', context),
        reusableCheckBoxes('Intermediate', context),
        reusableCheckBoxes('Expert', context),
        reusableTitleTwo('Language'),
        reusableCheckBoxes('English', context),
        reusableCheckBoxes('Espanol', context),
        reusableCheckBoxes('Hindi', context),
        reusableCheckBoxes('Urdu', context),
        reusableTitleTwo('PhotoShop'),
        reusableCheckBoxes('Adobe Illustrator', context),
        reusableCheckBoxes('Blender', context),
        reusableCheckBoxes('After effects', context),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyElevatedButton(label: 'Filter Items', onPressed: () {}),
        )
      ],
    );
  }

  void _modalBottomSheetMenuOptions(context) {
    _botomSheet(
      context,
      children: [
        reusableTitleTwo('Type'),
        reusableCheckBoxes('Live Classes', context),
        reusableCheckBoxes('Course', context),
        reusableCheckBoxes('Text course', context),
        reusableTitleTwo('Options'),
        reusableToggleChoices('UpComing Live Classes'),
        reusableToggleChoices('Free Courses'),
        reusableToggleChoices('Discounted Courses'),
        reusableToggleChoices('Downloadable Content'),
        reusableTitleTwo('Sort By'),
        reusableRadioOptions('All'),
        reusableRadioOptions('Newest'),
        reusableRadioOptions('Highest Prices'),
        reusableRadioOptions('Lowest Prices'),
        reusableRadioOptions('Best Sellers'),
        const SizedBox(
          height: 10,
        ),
        MyElevatedButton(
          label: 'Apply Options',
          onPressed: () {},
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Future<dynamic> _botomSheet(context,
      {List<Widget> children = const <Widget>[]}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        )),
        builder: (builder) {
          return DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.2,
            maxChildSize: 0.75,
            expand: false,
            builder: (context, s) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                    physics: const BouncingScrollPhysics(),
                    controller: s,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: children),
              );
            },
          );
        });
  }

  Widget reusableCheckBoxes(String type, context) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    color: ColorConst.buttonColor,
                    fontSize: 12,
                  ),
                ),
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }) //
              ],
            ),
          ));
    });
  }

  Widget reusableToggleChoices(String category) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: TextStyle(
                    color: ColorConst.buttonColor,
                    fontSize: 12,
                  ),
                ),
                CupertinoSwitch(
                    trackColor: Colors.grey,
                    activeColor: ColorConst.buttonColor,
                    value: status,
                    onChanged: (value) {
                      setState(() {
                        status = value;
                      });
                    })
              ],
            ),
          ));
    });
  }

  Widget reusableRadioOptions(String type) {
    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    color: ColorConst.buttonColor,
                    fontSize: 12,
                  ),
                ),
                Radio(
                    value: type,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() {
                        groupValue = value.toString();
                      });
                    })
              ],
            ),
          ));
    });
  }
}
