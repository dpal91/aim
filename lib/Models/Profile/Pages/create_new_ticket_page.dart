import 'dart:convert';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Service/service.dart';
import '../model/support_webinar_suport_model.dart';

class CreateNewTicketPage extends StatefulWidget {
  final Map<String, dynamic> profileDetails;
  const CreateNewTicketPage({
    Key? key,
    required this.profileDetails,
  }) : super(key: key);

  @override
  State<CreateNewTicketPage> createState() => _CreateNewTicketPageState();
}

class _CreateNewTicketPageState extends State<CreateNewTicketPage> {
  Department? selectedDepartment;
  Webinar? selectedWebinar;
  int selectedCategory = 1;
  List<Department> departments = [];
  List<Webinar> webinars = [];
  bool isLoading = false;
  final titleController = TextEditingController();
  final messageController = TextEditingController();

  SupportwebinarandContentModel? webinarAndContentData;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    final data = await ApiService.get(key: 'support/getSuportAndCourse');
    setState(() {
      webinarAndContentData =
          supportwebinarandContentModelFromJson(data.toString());
      departments = webinarAndContentData!.departments!;
      webinars = webinarAndContentData!.webinars!;
      isLoading = false;
    });
  }

  createSupportTicket() async {
    if (titleController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter subject',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (messageController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter message',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (selectedCategory == 2 && selectedDepartment == null) {
      Get.snackbar(
        'Error',
        'Please select department',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    if (selectedCategory == 1 && selectedWebinar == null) {
      Get.snackbar(
        'Error',
        'Please select webinar',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    final data = {
      "title": titleController.text,
      "type": selectedCategory == 1 ? 'course_support' : 'platform_support',
      "message": messageController.text,
    };
    if (selectedCategory == 2) {
      data['department_id'] = selectedDepartment!.id.toString();
    }
    if (selectedCategory == 1) {
      data['webinar_id'] = selectedWebinar!.id.toString();
    }
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
    );
    final response = await ApiService.post(
      key: 'support/store',
      body: data,
    );
    final res = jsonDecode(response.toString());
    Get.back();
    if (res['statusCode'] == 200) {
      Get.back(result: true);
    }
    if (res['statusCode'] == 200) {
      Get.snackbar(
        'Success',
        'Ticket created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        res['message'],
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Create New Ticket',
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    " Subject",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Subject',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    " Category",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // DropdownButton
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<int>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      hint: const Text('Select Category'),
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: Text('Course Support'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text('Platform Support'),
                        ),
                      ],
                      value: selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (selectedCategory == 1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          " Course",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // DropdownButton
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: const Text('Select Course'),
                            items: webinars
                                .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(e.title!),
                                    ))
                                .toList(),
                            value: selectedWebinar?.id,
                            onChanged: (value) {
                              setState(() {
                                selectedWebinar = webinars.firstWhere(
                                    (element) => element.id == value);
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  else if (selectedCategory == 2)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          " Topic",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        // DropdownButton
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<int>(
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: const Text('Select Topic'),
                            items: departments
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.title!),
                                  ),
                                )
                                .toList(),
                            value: selectedDepartment?.id,
                            onChanged: (value) {
                              setState(() {
                                selectedDepartment = departments.firstWhere(
                                    (element) => element.id == value);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    " Description",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      maxLines: 5,
                      controller: messageController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Description',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Submit Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(
              onPressed: createSupportTicket,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConst.primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
