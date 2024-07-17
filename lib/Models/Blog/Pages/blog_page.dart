import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Blog',
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                  onTap: () {
                    _filterBottomSheet(context);
                  },
                  child: const Icon(
                    Icons.filter_list,
                    color: Colors.black,
                    size: 23,
                  )),
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(RoutesName.blogPostPage);
              },
              child: blogBuilder()),
          itemCount: 10,
        ));
  }

  Widget blogBuilder() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      // decoration: BoxDecoration(boxShadow: [
      //   BoxShadow(
      //     color: Colors.grey.withOpacity(0.1),
      //     spreadRadius: 2,
      //     blurRadius: 1,
      //     offset: const Offset(0, .1),
      //   ),
      // ], borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://img.freepik.com/free-photo/successful-businesswoman-working-laptop-computer-her-office-dressed-up-white-clothes_231208-4809.jpg",
                      fit: BoxFit.fill,
                    )),
              ),
              Positioned(
                left: 10,
                bottom: 8,
                child: Center(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: ColorConst.buttonColor,
                        backgroundImage: AssetImage(Images.pngBlog),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Linda Hamilton",
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.0, top: 10),
                child: Text(
                  "Become a Straight -A Student",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "In this article,i'll explain the two rules i followed to become a straight- A student.if you take my advice,you'll get better grades a learn and more",
                  // overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.grey,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "01 Jul 2022",
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: Icon(
                              Icons.comment,
                              color: Colors.grey,
                              size: 14,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "0",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> _filterBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: true,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(''),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Center(child: Icon(Icons.close))),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                // height: MediaQuery.of(context).size.height*0.30,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                // margin: EdgeInsets.symmetric(vertical: 30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Blog Categories',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      listTile('Announcements'),
                      listTile('Articles'),
                      listTile('Events'),
                      listTile('News'),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget listTile(String text) {
    return SizedBox(
      height: 40,
      child: ListTile(
        leading: Text(
          text,
          style: const TextStyle(fontSize: 13),
        ),
      ),
    );
  }
}
