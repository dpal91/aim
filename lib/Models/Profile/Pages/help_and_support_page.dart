import 'create_new_ticket_page.dart';
import 'view_conversations.dart';
import '../model/raise_support_data.dart';
import '../../../Service/service.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class HelpAndSupportPage extends StatefulWidget {
  final Map<String, dynamic> profileDetails;
  const HelpAndSupportPage({Key? key, required this.profileDetails})
      : super(key: key);

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  AllSupportModel? supportData;
  CourseSupportModel? courseSupportData;
  int totalLength = 0;

  @override
  void initState() {
    super.initState();
    getSupportData();
  }

  bool isLoading = false;

  getSupportData() async {
    setState(() {
      isLoading = true;
    });
    final data = await ApiService.get(key: 'support/tickets');
    setState(() {
      supportData = allSupportModelFromJson(data);
    });
    getCourseSupportData();
  }

  getCourseSupportData() async {
    final data = await ApiService.get(key: 'support');
    setState(() {
      courseSupportData = courseSupportModelFromJson(data);

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Help & Support',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Raise a ticket",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        final data = await Get.to(
                          () => CreateNewTicketPage(
                            profileDetails: widget.profileDetails,
                          ),
                        );
                        if (data != null) {
                          getSupportData();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.receipt_long,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Raise a new ticket",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            "Course Support",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Platform Support",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          buidCourseSupport(),
                          buidPlatformSupport(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  buidCourseSupport() {
    return ListView.builder(
      itemCount: courseSupportData!.supports!.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final data = courseSupportData!.supports![index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
            onTap: () {
              Get.to(
                () => ViewConverSations(
                  support: data,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey[200]!,
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.2),
                //     spreadRadius: 1,
                //     blurRadius: 7,
                //     offset: const Offset(0, 3),
                //   ),
                // ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Ionicons.chatbox_ellipses_outline,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              data.status!.toUpperCase(),
                              style: TextStyle(
                                color: data.status == 'close'
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.conversations!.isNotEmpty
                                    ? data.conversations![0].message!
                                    : "No message",
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  buidPlatformSupport() {
    return ListView.builder(
      itemCount: supportData!.data!.supports!.length,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final data = supportData!.data!.supports![index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: InkWell(
            onTap: () {
              Get.to(
                () => ViewConverSations(
                  support: data,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey[200]!,
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.2),
                //     spreadRadius: 1,
                //     blurRadius: 7,
                //     offset: const Offset(0, 3),
                //   ),
                // ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Ionicons.chatbox_ellipses_outline,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              data.status!.toUpperCase(),
                              style: TextStyle(
                                color: data.status == 'close'
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                data.conversations!.isNotEmpty
                                    ? data.conversations![0].message!
                                    : "No message",
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
