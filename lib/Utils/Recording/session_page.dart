import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../Models/AllCources/Controller/all_courses_controller.dart';
import '../Constants/constants_colors.dart';
import '../Wdgets/appbar.dart';
import 'list_of_recording.dart';

class SessionPage extends StatefulWidget {
  final String title;
  final String slug;
  const SessionPage({Key? key, required this.title, required this.slug})
      : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  final controller = Get.put(AllCoursesController());
  List<dynamic> recordings = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    List sessionId = [];
    final data = await controller.getDetails(widget.slug);
    // log(data!.data!.course!.chapters!.toString());
    for (var element in data!.data!.course!.chapters!) {
      for (var item in element['chapter_items']) {
        if (item['type'] == "session") {
          sessionId.add(item['session']);
        }
      }
    }
    setState(() {
      recordings = sessionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        backgroundColor: ColorConst.primaryColor,
        title: widget.title,
        titleColor: Colors.white,
      ),
      body: Obx(
        () => controller.islinearLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: recordings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Get.to(
                          () => ListOfRecording(
                            slug: widget.slug,
                            title: widget.title,
                            sessionId: recordings[index]['id'],
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
                                recordings[index]['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
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
      ),
    );
  }
}
