import 'package:cached_network_image/cached_network_image.dart';
import '../Controller/meeting_controller.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/elevated_button.dart';

class MeetingDetailsPage extends StatefulWidget {
  const MeetingDetailsPage({Key? key}) : super(key: key);

  @override
  State<MeetingDetailsPage> createState() => _MeetingDetailsPageState();
}

class _MeetingDetailsPageState extends State<MeetingDetailsPage> {
  var controller = {};
  MeetingController mcontroller = Get.put(MeetingController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = Get.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Meeting Details',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Stack(
                    children: [
                      TweenAnimationBuilder(
                        duration: const Duration(seconds: 0),
                        tween: Tween(begin: 0.0, end: 1.0),
                        builder: (context, value, _) => SizedBox(
                          width: 160,
                          height: 160,
                          child: CircularProgressIndicator(
                            value: value as double,
                            backgroundColor: Colors.grey,
                            color: ColorConst.primaryColor,
                            strokeWidth: 16,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 18,
                        left: 7,
                        right: 7,
                        top: 18,
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            RoutesName.baseImageUrl + controller['imageCover'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    controller['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () {
                  if (mcontroller.isLoadingmeeting.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    final data = controller['sessionId'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              reusableRow(
                                  'Start Date',
                                  DateFormat('dd/MM/yyyy').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      data['date'] * 1000,
                                    ),
                                  ),
                                  Icons.calendar_month_outlined),
                              const SizedBox(height: 15),
                              reusableRow(
                                  'Start Time',
                                  DateFormat('hh:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      data['date'] * 1000,
                                    ),
                                  ),
                                  Icons.access_time_filled_outlined),
                              const SizedBox(height: 15),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              reusableRow(
                                'Duration',
                                "${double.parse((data['duration']).toString()).toStringAsFixed(2)} Min",
                                Icons.access_time_filled_outlined,
                              ),
                              const SizedBox(height: 15),
                              reusableRow(
                                'Status',
                                data['status'],
                                Icons.chat_bubble,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Html(
                        data: controller['sessionId']['description'] ?? "",
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GetBuilder<MeetingController>(
                    init: MeetingController(),
                    initState: (_) {},
                    builder: (cnt) {
                      return MyElevatedButton(
                        isLoading: cnt.isLoading.value,
                        label: 'Start Meeting',
                        onPressed: () {
                          cnt.getMeetingLink(controller['sessionId']['id']);
                        },
                      );
                    },
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget reusableRow(String title, String subtitle, IconData iconData) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(
            iconData,
            color: Colors.black54,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 10, color: Colors.black54),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.black)),
            ],
          ),
        )
      ],
    );
  }

  Future<dynamic> _menuSheet(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(''),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Center(child: Icon(Icons.close))),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // height: MediaQuery.of(context).size.height*0.30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                // margin: EdgeInsets.symmetric(vertical: 30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Text(
                          'Meeting Options',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.calenderPage);
                          },
                          child: listTileMenu('Add to Calender',
                              Icons.calendar_month_outlined)),
                      InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: 'Finish',
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    children: <Widget>[
                                      const Text(
                                          "Are you sure you want to Finish this Meeting?",
                                          style: TextStyle(fontSize: 13)),
                                      Container(
                                        margin: const EdgeInsets.only(top: 22),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 40,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.blue
                                                            .withOpacity(0.1),
                                                        offset: const Offset(
                                                            0.0, 1.0),
                                                        blurRadius: 1.0,
                                                        spreadRadius: 0.0)
                                                  ],
                                                  color: ColorConst.buttonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Text(
                                                  "Yes",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Get.back();
                                              },
                                              child: Container(
                                                width: 100,
                                                height: 40,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.blue
                                                            .withOpacity(0.1),
                                                        offset: const Offset(
                                                            0.0, 1.0),
                                                        blurRadius: 1.0,
                                                        spreadRadius: 0.0)
                                                  ],
                                                  color: ColorConst.buttonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: const Text("Cancel",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                          child: listTileMenu('Finish Meeting',
                              Icons.check_circle_outline_outlined))
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

Widget listTileMenu(String title, IconData icons) {
  return SizedBox(
    height: 50,
    child: ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 13),
      ),
      leading: Icon(
        icons,
        color: Colors.black,
      ),
    ),
  );
}
