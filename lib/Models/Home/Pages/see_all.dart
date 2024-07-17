import 'package:cached_network_image/cached_network_image.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../Category/Widgets/category_details_widgets.dart';
import '../Model/home_model.dart';
import 'study_material_page.dart';
import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AllCources/Pages/all_courses_pages_details.dart';

class SeeAllPage extends StatefulWidget {
  final List? webinars;
  final bool? isDemo;
  const SeeAllPage({
    Key? key,
    this.webinars,
    this.isDemo = false,
  }) : super(key: key);

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  bool isChecked = false;
  bool status = false;
  String? groupValue;
  String title = "";
  List data = [];
  bool isAttempt = false;
  List<Webinar>? webinarData = [];
  bool isDemo = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      data = Get.arguments[1];
      title = Get.arguments[0];
      isAttempt = Get.arguments[3];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200]!.withOpacity(.5),
      appBar: MyAppBar(
        centerTitle: true,
        title: title,
        backgroundColor: ColorConst.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        titleColor: Colors.white,
      ),
      body: data.isEmpty
          ? const SafeArea(child: Center(child: Text("Coming Soon")))
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // _header(),
                    // SizedBox(height: 20,),
                    // _body(),
                    _footer(context),
                  ],
                ),
              ),
            ),
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
            padding: const EdgeInsets.only(bottom: 120, left: 10, right: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.82,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              bool isFree = data[index].price == null || data[index].price == 0;
              if (isFree) {
                return Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: InkWell(
                        onTap: () async {
                          if (Get.arguments[2]) {
                            Get.dialog(
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                              barrierDismissible: false,
                            );
                            final AllCoursesController allCoursesController =
                                Get.put(AllCoursesController());
                            await allCoursesController.getAllCourseDetails(
                              data[index].slug!,
                            );
                            Get.back();
                            Get.to(
                              () => DemoStudyMaterial(
                                title: data[index].title!,
                              ),
                            );
                            return;
                          } else if (Get.arguments[3]) {
                            Get.dialog(
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                              barrierDismissible: false,
                            );
                            final AllCoursesController allCoursesController =
                                Get.put(AllCoursesController());
                            await allCoursesController.getAllCourseDetails(
                              data[index].slug!,
                            );
                            Get.back();

                            Get.toNamed(
                              RoutesName.quizDetailsPageTwo,
                              arguments: allCoursesController
                                      .allCoursesDetailsData!.chapters![0]
                                  ['chapter_items'][0]['quiz']['id'],
                            );
                            return;
                          }
                          cnt.getAllCourseDetails(
                            data[index].slug!,
                          );
                          Get.to(
                            () => AllCoursesPageDetails(
                              isDemo: true,
                              latestWebinars: widget.webinars,
                              notIncludedLatestWebinars:
                                  widget.webinars![index],
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(),
                              Center(
                                child: CachedNetworkImage(
                                  height: 100,
                                  imageUrl: RoutesName.baseImageUrl +
                                      data[index].thumbnail!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  data[index].title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 35,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorConst.primaryColor,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        isAttempt ? " Attempt" : " View",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  SizedBox(
                    child: InkWell(
                      onTap: () async {
                        if (Get.arguments[2]) {
                          Get.dialog(
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                            barrierDismissible: false,
                          );
                          final AllCoursesController allCoursesController =
                              Get.put(AllCoursesController());
                          await allCoursesController.getAllCourseDetails(
                            data[index].slug!,
                          );
                          Get.back();
                          Get.to(
                            () => DemoStudyMaterial(
                              title: data[index].slug!,
                            ),
                          );
                        } else if (Get.arguments[3]) {
                          Get.dialog(
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                            barrierDismissible: false,
                          );
                          final AllCoursesController allCoursesController =
                              Get.put(AllCoursesController());
                          await allCoursesController.getAllCourseDetails(
                            data[index].slug!,
                          );
                          Get.back();

                          Get.toNamed(
                            RoutesName.quizDetailsPageTwo,
                            arguments: allCoursesController
                                .allCoursesDetailsData!
                                .chapters![0]['chapter_items'][0]['quiz']['id'],
                          );
                        } else {
                          Get.toNamed(RoutesName.allCoursesPageDetails);
                        }
                        cnt.getAllCourseDetails(data[index].slug!);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Get.height * 0.1,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CachedNetworkImage(
                                imageUrl: RoutesName.baseImageUrl +
                                    data[index].thumbnail!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10.0,
                                  top: 5,
                                ),
                                child: Text(
                                  data[index].title!,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  data[index].price != null
                                      ? Row(
                                          children: [
                                            const Text(
                                              '₹ ',
                                              style: TextStyle(
                                                color: Color(0xffee6c4d),
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              "${data[index].price}",
                                              style: const TextStyle(
                                                color: Color(0xffee6c4d),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        )
                                      : const Text(
                                          '',
                                          style: TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 34,
                              decoration: BoxDecoration(
                                color: ColorConst.primaryColor,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    isAttempt ? 'Attempt' : 'View',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {
              _modalBottomSheetMenuOptions(context);
            },
            child: reusableHeaderButton('Options', Images.svgOptions)),
        GestureDetector(
            onTap: () {
              _modalBottomSheetMenuFilter(context);
            },
            child: reusableHeaderButton('Filter', Images.svgFilter)),
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
