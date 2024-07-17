import '../Controller/home_controller.dart';
import 'course_builder.dart';
import 'other_widgets.dart';
import 'package:flutter/material.dart';

class LiveCoursesWidget extends StatelessWidget {
  const LiveCoursesWidget({required this.controller, super.key});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.grey.withOpacity(0.2),
          thickness: 8,
        ),
        const SizedBox(
          height: 20,
        ),
        reusableTitle(
          'Live Courses',
          context,
          controller.homeData!.data!.latestWebinars
              .where((element) => element.type == "webinar")
              .toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 230,
          margin: const EdgeInsets.only(bottom: 10),
          child: controller.homeData!.data!.latestWebinars.isEmpty
              ? const Center(
                  child: Text("No live classes latest webinar available!"),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.homeData!.data!.latestWebinars
                              .where((element) => element.type == "webinar")
                              .length >
                          6
                      ? 6
                      : controller.homeData!.data!.latestWebinars
                          .where((element) => element.type == "webinar")
                          .length,
                  itemBuilder: (context, index) => coursesBuilder(
                    controller.homeData!.data!.latestWebinars
                        .where((element) => element.type == "webinar")
                        .toList(),
                    context,
                    index,
                  ),
                  separatorBuilder: (context, _) => const SizedBox(
                    width: 0,
                  ),
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
          thickness: 8,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
