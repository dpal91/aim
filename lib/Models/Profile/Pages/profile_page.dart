import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import '../../Home/Controller/home_controller.dart';
import 'help_and_support_page.dart';
import '../../../Service/service.dart';
import '../../../Utils/Constants/constants_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/routes.dart';
import '../edit_profile_details.dart';
import 'change_password_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    getProfileDetails();
  }

  Map<String, dynamic> profileDetails = {};
  bool isLoading = true;

  getProfileDetails() async {
    final data = await ApiService.get(key: 'get_profile');
    final response = jsonDecode(data.toString());
    if (response['statusCode'] == 200) {
      setState(() {
        profileDetails = response['data'];
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: () async {
            await getProfileDetails();
            _refreshController.refreshCompleted();
          },
          enablePullDown: true,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: GestureDetector(
                    onDoubleTap: () {},
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        _body(),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        _footer()
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _body() {
    final homeController = Get.find<HomeController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 46,
              backgroundColor: ColorConst.primaryColor,
              child: CircleAvatar(
                radius: 43,
                backgroundImage: CachedNetworkImageProvider(
                  homeController.profileDetails['profile_image'] == "" ||
                          homeController.profileDetails['profile_image'] == null
                      ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                      : homeController.profileDetails['profile_image'],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileDetails['full_name'],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                profileDetails['email'],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reusable_listTile(
    String ImageUrl,
    String category,
    VoidCallback onTap,
  ) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            ImageUrl,
            height: 25,
            width: 25,
            color: Colors.black,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            category,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget _footer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Accounts",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _reusable_listTile(Images.svgProfile, 'Edit Profile', () {
            Get.to(
              () => EditProfilePage(
                profileDetails: profileDetails,
              ),
            );
          }),
          _reusable_listTile(Images.svgPrivacy, 'Change Password', () {
            Get.to(() => const ChangePasswordPage());
          }),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Others",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _reusable_listTile(Images.svgHelp, 'Help and Support', () {
            Get.to(
              () => HelpAndSupportPage(
                profileDetails: profileDetails,
              ),
            );
          }),
          _reusable_listTile(Images.svgInvite, 'Invite a Friend', () {
            Share.share(
                "Hey, I'm studying from AimPariksha App for my Exams. Download it now from https://play.google.com/store/apps/details?id=com.aimparikshaa.app");
          }),
          _reusable_listTile(Images.svgLogout, 'Logout', () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actionsPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        logout();
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }

  logout() async {
    GetStorage().remove(RoutesName.token);
    GetStorage().remove(RoutesName.id);
    GetStorage().erase();
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Get.offAndToNamed(RoutesName.loginInPageEmail);
  }
}
