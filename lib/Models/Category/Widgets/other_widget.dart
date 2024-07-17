import 'package:cached_network_image/cached_network_image.dart';
import '../Model/category_model.dart';
import '../../../Utils/Constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constants_colors.dart';

Widget reusableCard(TrendingCategory trendingCategory) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8, 20, 8, 13),
    child: InkWell(
      onTap: () {
        Get.toNamed(RoutesName.categoryDetailsPage, arguments: [
          trendingCategory.categoryId,
          trendingCategory.category.title
        ]);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: HexColor.fromHex(trendingCategory.color),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CachedNetworkImage(
                        imageUrl:
                            "${RoutesName.baseImageUrl}${trendingCategory.icon}"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 15,
                  bottom: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      trendingCategory.category.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          trendingCategory.category.webinarsCount.toString(),
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          ' Courses',
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget reusableTileOne(BrowseCategory browseCategory) {
  return Theme(
    data: ThemeData().copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      onExpansionChanged: (isExpanded) {
        browseCategory.subCategories!.isEmpty
            ? Get.toNamed(RoutesName.categoryDetailsPage,
                arguments: [browseCategory.id, browseCategory.title, null])!
            : Container();
      },
      backgroundColor: Colors.transparent,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.grey[100]),
        child: CachedNetworkImage(
          imageUrl: "${RoutesName.baseImageUrl}${browseCategory.icon}",
          width: 25,
        ),
      ),
      title: Text(
        browseCategory.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        '(${browseCategory.subCategories!.length})',
        style: TextStyle(
            color: Colors.grey[500], fontSize: 13, fontWeight: FontWeight.w400),
      ),
      trailing: browseCategory.subCategories!.isEmpty ? const SizedBox() : null,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: browseCategory.subCategories!.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Row(
                children: [
                  // CachedNetworkImage(
                  //   imageUrl:
                  //       "${RoutesName.baseImageUrl}${browseCategory.subCategories![index].icon}",
                  //   width: 30,
                  // ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  Text(browseCategory.subCategories![index].title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                ],
              ),
              // contentPadding: const EdgeInsets.all(0),
              leading: Image.network(
                "${RoutesName.baseImageUrl}${browseCategory.subCategories![index].icon}",
                width: 30,
              ),
              onTap: () =>
                  Get.toNamed(RoutesName.categoryDetailsPage, arguments: [
                browseCategory.id,
                browseCategory.title,
                browseCategory.subCategories![0].id,
              ]),
            );
          },
        ),
      ],
    ),
  );
}
