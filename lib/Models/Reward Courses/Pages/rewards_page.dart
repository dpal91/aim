import 'package:cached_network_image/cached_network_image.dart';
import '../../AllCources/Controller/all_courses_controller.dart';
import '../../Category/Widgets/category_details_widgets.dart';
import '../../Reward%20Courses/Controller/reward_controller.dart';
import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';

import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RewardsPage extends StatefulWidget {
  const RewardsPage({Key? key}) : super(key: key);

  @override
  State<RewardsPage> createState() => _RewardsPageState();
}

class _RewardsPageState extends State<RewardsPage> {
  RewardController controller = Get.put(RewardController());

  bool isChecked = false;
  bool status = false;
  String? groupValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200]!.withOpacity(.5),
      appBar: const MyAppBar(
        centerTitle: true,
        title: "Reward Courses",
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.rewardDetails.isEmpty
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
            itemCount: controller.rewardDetails.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(RoutesName.allCoursesPageDetails);
                cnt.getAllCourseDetails(controller.rewardDetails[index].slug!);
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
                                  controller.rewardDetails[index].imageCover!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 23.0),
                    child: Text(
                      controller.rewardDetails[index].title!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.person_outline_sharp,
                              size: 12,
                              color: Colors.black54,
                            ),
                            Text(
                              'Mr. Ajay Kumar',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 12,
                              color: Colors.black54,
                            ),
                            Text(
                              controller.rewardDetails[index].duration!
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Text(' Hours',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600))
                          ],
                        )
                      ],
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
                              '₹',
                              style: TextStyle(
                                  color: ColorConst.greenColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              controller.rewardDetails[index].price!.toString(),
                              style: TextStyle(
                                  color: ColorConst.greenColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Text(
                          controller.rewardDetails[index].status!,
                          style: TextStyle(
                              color: ColorConst.greenColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
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
            fontSize: 20,
            letterSpacing: 1,
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
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: MyElevatedButton(
            label: 'Filter Items',
          ),
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
        const MyElevatedButton(label: 'Apply Options'),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
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
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
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
