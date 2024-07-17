import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';

class MeetingSections extends StatefulWidget {
  const MeetingSections({Key? key}) : super(key: key);

  @override
  State<MeetingSections> createState() => _MeetingSectionsState();
}

class _MeetingSectionsState extends State<MeetingSections> {
  var data = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      data = Get.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Classes',
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
      body: ListView.builder(
        itemCount: data['sessionId'].length,
        itemBuilder: (context, index) {
          final classe = data['sessionId'][index];
          return InkWell(
            onTap: () {
              Get.toNamed(
                RoutesName.meetingDetailsPage,
                arguments: {
                  'id': data['id'],
                  'imageCover': data['imageCover'],
                  'title': data['title'],
                  'discription': data['discription'],
                  'sessionId': classe,
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
                      classe['title'],
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
      ),
    );
  }
}
