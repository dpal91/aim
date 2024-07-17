import 'package:cached_network_image/cached_network_image.dart';
import '../Controller/cart_controller.dart';
import '../../Home/Model/home_model.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/all_courses_controller.dart';

class AllStudyMaterialPage extends StatefulWidget {
  final List<Webinar> studymaterials;
  final String title;
  const AllStudyMaterialPage(
      {Key? key, required this.studymaterials, this.title = "Study Material"})
      : super(key: key);

  @override
  State<AllStudyMaterialPage> createState() => _AllStudyMaterialPageState();
}

class _AllStudyMaterialPageState extends State<AllStudyMaterialPage> {
  List<bool> isAddedList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.studymaterials.length; i++) {
      isAddedList.add(false);
    }
    getCartData();
  }

  getCartData() async {
    final controller = Get.put(CartController());
    await controller.getCart();
    for (var i = 0; i < widget.studymaterials.length; i++) {
      for (var j = 0; j < controller.cartData!.carts!.length; j++) {
        if (widget.studymaterials[i].id == controller.cartData!.carts![j].id) {
          isAddedList[i] = true;
        }
      }
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  addToCart({
    required int id,
    required String title,
    required int index,
  }) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    final controller = Get.find<AllCoursesController>();
    await controller.addToCart(
      id,
      showNotification: false,
    );
    setState(() {
      isAddedList[index] = true;
    });
    Get.back();
  }

  removeFromCart({
    required int id,
    required String title,
    required int index,
  }) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    final controller = Get.put(CartController());
    await controller.deleteFromCart(id, showNotification: false);
    setState(() {
      isAddedList[index] = false;
    });
    Get.back();
    await controller.getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.studymaterials.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: RoutesName.baseImageUrl +
                                  widget.studymaterials[index].thumbnail!,
                              height: 50,
                              width: 80,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              widget.studymaterials[index].title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          subtitle: Text(
                            "₹${widget.studymaterials[index].price}",
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          trailing: CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              if (isAddedList[index]) {
                                removeFromCart(
                                  id: widget.studymaterials[index].id!,
                                  title: widget.studymaterials[index].title!,
                                  index: index,
                                );
                              } else {
                                addToCart(
                                  id: widget.studymaterials[index].id!,
                                  title: widget.studymaterials[index].title!,
                                  index: index,
                                );
                              }
                            },
                            child: Container(
                              height: 30,
                              width: isAddedList[index] ? 80 : 60,
                              decoration: BoxDecoration(
                                color: isAddedList[index]
                                    ? Colors.transparent
                                    : ColorConst.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: isAddedList[index]
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Colors.red,
                                            width: 1,
                                          ),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Remove",
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 13,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      )
                                    : const Text(
                                        "Add +",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (isAddedList.contains(true))
                  Container(
                    height: 80,
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorConst.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${isAddedList.where((element) => element == true).length} Items Added\n"
                                "₹${widget.studymaterials.where((element) => isAddedList[widget.studymaterials.indexOf(element)] == true).map((e) => e.price).toList().reduce((value, element) => value! + element!)}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                              // const Text(
                              //   "",
                              //   style: TextStyle(
                              //     color: Colors.white,
                              //     fontSize: 13,
                              //   ),
                              // ),
                            ],
                          ),
                          const Spacer(),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: ColorConst.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed(
                                RoutesName.coursesCheckOutPage,
                              );
                            },
                            child: const Text(
                              "Go to Cart",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
