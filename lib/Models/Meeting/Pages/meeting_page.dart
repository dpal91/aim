import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/BottomNavigation/controller.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../Controller/meeting_controller.dart';
import 'meetings_sections.dart';

class MaeetingsPage extends StatefulWidget {
  final bool isBack;
  const MaeetingsPage({Key? key, this.isBack = true}) : super(key: key);

  @override
  State<MaeetingsPage> createState() => _MaeetingsPageState();
}

class _MaeetingsPageState extends State<MaeetingsPage> {
  MeetingController controller = Get.put(MeetingController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          title: const Text(
            "Live Courses",
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
              if (widget.isBack) {
                Get.back();
              } else {
                final controller = Get.find<BottomNavigationController>();
                controller.changeTabIndex(0);
              }
            },
          ),
        ),
        body: Obx(
          () {
            return controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: [meetingBuilder()],
                  );
          },
        ),
      ),
    );
  }

  Widget meetingBuilder() {
    final meetings = controller.meetingList.value
        .where((element) =>
            element.webinar != null &&
            element.webinar!.type == "webinar" &&
            element.webinar!.sessions!.isNotEmpty)
        .toList();
    if (meetings.isEmpty) {
      return const Center(
        child: Text('No Course Purchased'),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: meetings.length,
      itemBuilder: (BuildContext context, index) {
        return InkWell(
          onTap: () {
            Get.to(
              () => const MeetingSections(),
              arguments: {
                'id': meetings[index].id!,
                'imageCover': meetings[index].webinar != null
                    ? meetings[index].webinar!.thumbnail!
                    : '',
                'title': meetings[index].webinar!.title!,
                'discription': meetings[index].webinar!.description!,
                'sessionId': meetings[index].webinar!.sessions!
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: ColorConst.primaryColor.withOpacity(0.2),
                  child: Icon(
                    Icons.tv,
                    color: ColorConst.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    meetings[index].webinar!.title ?? "Live Class",
                    style: const TextStyle(
                      fontSize: 13,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: ColorConst.primaryColor,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
