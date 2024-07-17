import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import '../Home/Controller/home_controller.dart';
import '../../Service/service.dart';
import '../../Utils/Constants/constants_colors.dart';
import '../../Utils/Wdgets/appbar.dart';
import '../../main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/Constants/routes.dart';
import 'change_number_page.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> profileDetails;
  const EditProfilePage({
    Key? key,
    required this.profileDetails,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? image;
  String imageUrl = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLoading = false;
      });
    });
    nameController.text = widget.profileDetails['full_name'] ?? '';
    phoneController.text = widget.profileDetails['mobile'] ?? '';
  }

  pickImage() async {
    final pickedFile =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    await Future.delayed(const Duration(milliseconds: 100));
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path).path;
      });
    }
  }

  showNameChangeBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.25,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Your Name',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Name',
                // border: InputBorder.none,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  updateProfile() async {
    try {
      Get.dialog(
        const Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Updating Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
      if (image != null) {
        await uploadProfileImage();
      }
      final response = await ApiService.post(
        key: 'update_profile',
        body: {
          "profile_image": imageUrl == ''
              ? widget.profileDetails['profile_image'] ?? ""
              : imageUrl,
          "full_name": nameController.text,
          "phone_no": phoneController.text,
        },
      );
      final data = jsonDecode(response.toString());
      if (data['statusCode'] == 200) {
        GetStorage().write('userName', nameController.text);
        GetStorage().write(
          'userImage',
          imageUrl == ''
              ? widget.profileDetails['profile_image'] ?? ""
              : imageUrl,
        );

        Get.back();
        Get.back();
        Get.offAllNamed(RoutesName.bottomNavigation);
      } else {
        Get.back();
      }
    } catch (e) {
      debugPrint("Err : updateProfile $e");
    } finally {
      Get.back();
    }
  }

  uploadProfileImage() async {
    try {
      Get.back();
      Get.dialog(
        const Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Uploading Image',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
      final ref = gFirebaseStorage.ref().child('profileImage');
      await ref.putFile(File(image!));
      imageUrl = await ref.getDownloadURL();
      // updating controller profile value
      final homeController = Get.find<HomeController>();
      homeController.profileDetails['profile_image'] = imageUrl;
      setState(() {});
      Get.back();
      Get.dialog(
        const Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Updaing Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
      return imageUrl;
    } catch (e) {
      debugPrint("Err : uploadProfileImage $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Edit Profile',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        const Row(),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: CircleAvatar(
                                radius: 64,
                                child: CircleAvatar(
                                  radius: 63,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage: image != null
                                      ? FileImage(File(image!))
                                      : widget.profileDetails[
                                                      'profile_image'] !=
                                                  null &&
                                              widget.profileDetails[
                                                      'profile_image'] !=
                                                  ""
                                          ? CachedNetworkImageProvider(
                                              widget.profileDetails[
                                                  'profile_image'],
                                            )
                                          : const NetworkImage(
                                              'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                                            ) as ImageProvider,
                                  child: image != null
                                      ? null
                                      : widget.profileDetails[
                                                      'profile_image'] !=
                                                  null ||
                                              widget.profileDetails[
                                                      'profile_image'] !=
                                                  ""
                                          ? null
                                          : const Icon(
                                              Icons.person,
                                              color: Colors.grey,
                                              size: 50,
                                            ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 20,
                                child: InkWell(
                                  onTap: () {
                                    pickImage();
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Name",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            nameController.text,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            showNameChangeBottomSheet();
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(5),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Email",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.profileDetails['email'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget.profileDetails['mobile'] ??
                                                "",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                              () => ChangeNumberPage(
                                                profileDetails:
                                                    widget.profileDetails,
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    updateProfile();
                  },
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorConst.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Update Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
