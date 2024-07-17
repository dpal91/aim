import '../Controller/home_controller.dart';
import 'course_builder.dart';
import 'other_widgets.dart';
import 'package:flutter/material.dart';

class OnlineStudyMaterialWidget extends StatelessWidget {
  const OnlineStudyMaterialWidget({required this.controller, super.key});
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
          height: 10,
        ),
        reusableTitle(
          'Online Study Material',
          context,
          controller.studymaterial
              .where((element) => element.price != 0 && element.price != null)
              .toList(),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: controller.studymaterial
                  .where(
                      (element) => element.price != null || element.price != 0)
                  .any((element) => element.title.length > 25)
              ? 230
              : 210,
          margin: const EdgeInsets.only(bottom: 10),
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 10),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.studymaterial
                        .where((element) =>
                            element.price != 0 && element.price != null)
                        .length >
                    6
                ? 6
                : controller.studymaterial
                    .where((element) =>
                        element.price != 0 && element.price != null)
                    .length,
            itemBuilder: (context, index) => coursesBuilder(
              controller.studymaterial
                  .where(
                      (element) => element.price != 0 && element.price != null)
                  .toList(),
              context,
              index,
            ),
            separatorBuilder: (context, _) => const SizedBox(
              width: 0,
            ),
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
          thickness: 8,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
