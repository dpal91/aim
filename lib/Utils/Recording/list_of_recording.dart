import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Models/AllCources/Controller/all_courses_controller.dart';
import '../../Models/Meeting/Pages/meeting_web_view.dart';
import '../Constants/constants_colors.dart';
import '../Wdgets/appbar.dart';

class ListOfRecording extends StatefulWidget {
  final String? title;
  final String? slug;
  final int? sessionId;
  const ListOfRecording({
    Key? key,
    this.title,
    this.slug,
    required this.sessionId,
  }) : super(key: key);

  @override
  State<ListOfRecording> createState() => _ListOfRecordingState();
}

class _ListOfRecordingState extends State<ListOfRecording> {
  final controller = Get.put(AllCoursesController());
  List<dynamic> recordings = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    List<dynamic> recordings = [];
    final data = await controller.getRecordingDetails(widget.sessionId!);
    recordings = data!['data'][1];
    log(recordings.toString());
    setState(() {
      this.recordings = recordings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title!,
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.islinearLoading.value ||
              controller.isdetailsLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: recordings.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              log(recordings[i].toString());
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      () => MeetingWebView(
                        url: recordings[i]['url'],
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recordings[i]['title'],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getDuration(recordings[i]),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy').format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            int.parse(
                                                recordings[i]['startTime']))),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
          );
        },
      ),
    );
  }

  String getDuration(dynamic recording) {
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(
        recording['startTime'],
      ),
    );
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(
        recording['endTime'],
      ),
    );
    String timeString = '';
    Duration difference = endTime.difference(startTime);
    if (difference.inHours > 0) {
      timeString = '${difference.inHours}h ${difference.inMinutes % 60}m';
    } else {
      timeString = '${difference.inMinutes % 60}m';
    }
    return "Duration: $timeString";
  }
}
