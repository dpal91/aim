import '../Controller/notification_controller.dart';
import '../Model/notification_model.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/constans_assets.dart';
import '../../../Utils/Constants/constants_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Notifications',
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          // color: backgroundColor == Colors.transparent
          //     ? Theme.of(context).iconTheme.color
          //     : Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: ColorConst.buttonColor,
                  ),
                )
              : ListView.builder(
                  /*shrinkWrap: true,*/
                  itemCount: controller.notificationdata.length,
                  itemBuilder: (BuildContext context, index) {
                    return reusableNotificationCard(
                      Images.pngSecurity,
                      controller.notificationdata[index],
                    );
                  },
                ),
        ),
      ),
    );
  }

  Widget reusableNotificationCard(
      String imgUrl, NotificationData notificationdata) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        color: Colors.grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    color: ColorConst.buttonColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.notifications_active_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ApiService.parseHtmlString(
                          notificationdata.title!,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        ApiService.parseHtmlString(
                          notificationdata.message!,
                        ),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat('dd-MM-yyyy | ').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                notificationdata.createdAt! * 1000,
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('hh:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                notificationdata.createdAt! * 1000,
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
