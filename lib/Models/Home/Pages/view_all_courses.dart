import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/routes.dart';

class ViewAllCourses extends StatefulWidget {
  final String? title;
  final List<dynamic> courses;
  const ViewAllCourses({
    Key? key,
    this.title,
    required this.courses,
  }) : super(key: key);

  @override
  State<ViewAllCourses> createState() => _ViewAllCoursesState();
}

class _ViewAllCoursesState extends State<ViewAllCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: widget.courses.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Get.toNamed(
                  RoutesName.categoryDetailsPage,
                  arguments: [
                    widget.courses[index]['parent_id'],
                    widget.courses[index]['title'],
                    widget.courses[index]['id'],
                  ],
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.1),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(widget.courses[index]['title']),
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.2),
                    backgroundImage: NetworkImage(
                      RoutesName.baseImageUrl + widget.courses[index]['icon'],
                    ),
                    radius: 25,
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
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
