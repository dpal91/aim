import 'dart:convert';
import '../Model/home_model.dart';
import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Utils/Constants/constans_assets.dart';
import '../../AllCources/Model/cart_model.dart' as cart;

class HomeController extends GetxController {
  var isLoading = true.obs;
  var current = 0.obs;
  List<Map<String, dynamic>> subCategories = [];

  List<Map<String, dynamic>> images = [];
  HomeModel? homeData;
  double heigth = 21;
  List<Webinar> studymaterial = [];
  List<Webinar> testSeries = [];
  List<Webinar> sectionaltest = [];
  List<Webinar> crashCourse = [];
  RxMap<String, dynamic> profileDetails = <String, dynamic>{}.obs;

  @override
  void onInit() async {
    // getCart();
    int id = GetStorage().read(RoutesName.categoryId) ?? 0;
    debugPrint("id : $id");
    await getHomeData(id);
    await getProfileDetails();
    super.onInit();
  }

  getAllHome() async {
    int id = GetStorage().read(RoutesName.categoryId) ?? 0;
    debugPrint("id : $id");
    await getHomeData(id);
    await getProfileDetails();
  }

  getProfileDetails() async {
    try {
      final data = await ApiService.get(key: 'get_profile');
      final response = jsonDecode(data.toString());
      if (response['statusCode'] == 200) {
        debugPrint("home profile data fetched");
        profileDetails.value = response['data'];
        debugPrint("data : ${profileDetails.toString()}");
      }
    } catch (e) {
      debugPrint("Err : getProfileDetails $e");
    }
  }

  void currentIndex(int index) {
    current.value = index;
    update();
  }

  Future getHomeData(int id) async {
    try {
      var data = await ApiService.get(key: "dashboard?category_id=$id");
      var res = homeModelFromJson(data);
      homeData = res;
      update();
      if (res.statusCode == 200) {
        for (var element in res.data!.banners) {
          images.add(element);
        }

        studymaterial.addAll(homeData!.data!.latestWebinars
            .where((element) => element.type == "study"));
        studymaterial.addAll(homeData!.data!.freeWebinars
            .where((element) => element.type == "study"));
        testSeries.addAll(homeData!.data!.latestWebinars
            .where((element) => element.type == "test"));
        testSeries.addAll(homeData!.data!.freeWebinars
            .where((element) => element.type == "test"));
        crashCourse.addAll(homeData!.data!.latestWebinars
            .where((element) => element.type == "crashcourse"));
        sectionaltest.addAll(homeData!.data!.latestWebinars
            .where((element) => element.type == "section_time_test"));
        update();
        isLoading(false);

        for (var element in homeData!.data!.freeWebinars) {
          purchaseFree(element.id!);
        }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      isLoading(false);
    }
  }

  Future<void> getCart() async {
    try {
      var data = await ApiService.get(key: "cart/course_list");
      var res = cart.CartModel.fromJson(json.decode(data));
      if (res.statusCode == 200) {
        var cartData = res.data;
        cartCount.value = cartData!.carts!.length;
        update();
      }
    } on Exception catch (e) {
      debugPrint("Err : getCart $e");
      update();
    }
  }

  purchaseFree(int id) async {
    // final data =
    // await ApiService.post(
    //   key: 'cart/checkOutFree',
    //   body: {
    //     'webinar_id': id.toString(),
    //   },
    // );
    // log("Purchased $id:  $data ");
  }
}
