import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import '../../Current%20Affair/current_affair_model.dart';
import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Service/service.dart';
import '../../../Utils/Constants/routes.dart';
import '../forum_details.dart';

class JobAlertsPage extends StatefulWidget {
  const JobAlertsPage({Key? key}) : super(key: key);

  @override
  State<JobAlertsPage> createState() => _JobAlertsPageState();
}

class _JobAlertsPageState extends State<JobAlertsPage> {
  CurrentAffairsModel? latestJobs;
  CurrentAffairsModel? upcomingJobs;
  RefreshController latestrefreshcontroller = RefreshController();
  RefreshController upcomigrefreshcontroller = RefreshController();

  int latestcurrentPage = 1;
  int latesttotalItems = 0;
  int upcomingcurrentPage = 1;
  int upcomingtotalItems = 0;

  @override
  void initState() {
    super.initState();
    getLatestJobs();
    getUpcomingJobs();
  }

  bool latestLoading = false;
  bool upcomingLoading = false;

  getLatestJobs({
    bool refresh = false,
  }) async {
    setState(() {
      latestLoading = true;
    });
    final response = await ApiService.post(
      key: 'previousyearpaper?page=$latestcurrentPage',
      body: {
        "type": "job_alert_latest",
      },
    );
    if (response != null) {
      if (refresh || latestJobs == null) {
        latestJobs = currentAffairsModelFromJson(response);
      } else {
        latestJobs!.webinars.data!
            .addAll(currentAffairsModelFromJson(response).webinars.data!);
      }
      latesttotalItems = jsonDecode(response)['totalWebinars'];
      latestcurrentPage = jsonDecode(response)['webinars']['current_page'];
    }
    setState(() {
      latestLoading = false;
    });
  }

  getUpcomingJobs({
    bool refresh = false,
  }) async {
    setState(() {
      upcomingLoading = true;
    });
    final response = await ApiService.post(
      key: 'previousyearpaper?page=$upcomingcurrentPage',
      body: {
        "type": "job_alert_upcoming",
      },
    );
    if (response != null) {
      if (refresh || upcomingJobs == null) {
        upcomingJobs = currentAffairsModelFromJson(response);
      } else {
        upcomingJobs!.webinars.data!
            .addAll(currentAffairsModelFromJson(response).webinars.data!);
      }
      upcomingtotalItems = jsonDecode(response)['totalWebinars'];
      upcomingcurrentPage = jsonDecode(response)['webinars']['current_page'];
    }
    setState(() {
      upcomingLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            backgroundColor: ColorConst.primaryColor,
            titleColor: Colors.white,
            title: "Job Alerts",
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
          ),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                child: TabBar(
                  indicatorColor: ColorConst.primaryColor,
                  labelColor: ColorConst.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(
                      text: "Latest Jobs",
                    ),
                    Tab(
                      text: "Upcoming Jobs",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    reusableTabLatest(),
                    reusableTabUpcoming(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reusableTabUpcoming() {
    if (upcomingLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: SmartRefresher(
            controller: upcomigrefreshcontroller,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () async {
              upcomingcurrentPage = 1;
              getUpcomingJobs(refresh: true);
              upcomigrefreshcontroller.refreshCompleted();
            },
            onLoading: () async {
              if (upcomingtotalItems > upcomingJobs!.webinars.data!.length) {
                upcomingcurrentPage++;
                getUpcomingJobs(refresh: false);
                upcomigrefreshcontroller.loadComplete();
              } else {
                upcomigrefreshcontroller.loadNoData();
              }
            },
            child: (latestJobs!.webinars.data?.isEmpty ?? true)
                ? const Center(child: Text("No upcoming jobs available!"))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: upcomingJobs!.webinars.data!.length,
                    itemBuilder: (BuildContext context, index) {
                      final latest = upcomingJobs!.webinars.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 1,
                                offset: const Offset(0, .1),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: RoutesName.baseImageUrl +
                                          latest.thumbnail!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          latest.title!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Row(
                                          children: [
                                            // Row(
                                            //   children: [
                                            //     Image.asset(
                                            //       'assets/calendar.png',
                                            //       height: 13,
                                            //       width: 13,
                                            //     ),
                                            //     Text(
                                            //       DateFormat(' dd MMM yyyy ').format(
                                            //         DateTime
                                            //             .fromMillisecondsSinceEpoch(
                                            //           latest['created_at'] * 1000,
                                            //         ),
                                            //       ),
                                            //       style: const TextStyle(
                                            //           color: Colors.black,
                                            //           fontSize: 10),
                                            //     )
                                            //   ],
                                            // ),
                                            // const Spacer(),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(top: 1.0),
                                            //   child: Row(children: [
                                            //     Image.asset(
                                            //       'assets/eye.png',
                                            //       height: 13,
                                            //       width: 13,
                                            //     ),
                                            //     Text(
                                            //       " ${latest.!} Views",
                                            //       style: const TextStyle(
                                            //         color: Colors.black,
                                            //         fontSize: 10,
                                            //       ),
                                            //     )
                                            //   ]),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConst.primaryColor,
                                          ),
                                          onPressed: () {
                                            Get.to(
                                              () => JobDetails(
                                                job: latest.description!,
                                                title: latest.title,
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'View',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget reusableTabLatest() {
    if (latestLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: SmartRefresher(
            controller: latestrefreshcontroller,
            enablePullUp: true,
            onRefresh: () {
              latestcurrentPage = 1;
              getLatestJobs(refresh: true);
              latestrefreshcontroller.refreshCompleted();
            },
            onLoading: () async {
              if (latesttotalItems > latestJobs!.webinars.data!.length) {
                latestcurrentPage++;
                getLatestJobs(refresh: false);
                latestrefreshcontroller.loadComplete();
              } else {
                latestrefreshcontroller.loadNoData();
              }
            },
            child: (latestJobs!.webinars.data?.isEmpty ?? true)
                ? const Center(child: Text("No latest jobs available!"))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: latestJobs!.webinars.data!.length,
                    itemBuilder: (BuildContext context, index) {
                      final latest = latestJobs!.webinars.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 7),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(0, .1),
                            ),
                          ], borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 10,
                                ),
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: RoutesName.baseImageUrl +
                                          latest.thumbnail!,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          latest.title!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Row(
                                          children: [
                                            // Row(
                                            //   children: [
                                            //     Image.asset(
                                            //       'assets/calendar.png',
                                            //       height: 13,
                                            //       width: 13,
                                            //     ),
                                            //     Text(
                                            //       DateFormat(' dd MMM yyyy').format(
                                            //         DateTime
                                            //             .fromMillisecondsSinceEpoch(
                                            //           latest['created_at'] * 1000,
                                            //         ),
                                            //       ),
                                            //       style: const TextStyle(
                                            //         color: Colors.black,
                                            //         fontSize: 10,
                                            //       ),
                                            //     ),
                                            //   ],
                                            // ),
                                            // const Spacer(),
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(top: 1.0),
                                            //   child: Row(
                                            //     children: [
                                            //       Image.asset(
                                            //         'assets/eye.png',
                                            //         height: 13,
                                            //         width: 13,
                                            //       ),
                                            //       Text(
                                            //         " ${latest.visitCount} Views",
                                            //         style: const TextStyle(
                                            //           color: Colors.black,
                                            //           fontSize: 10,
                                            //         ),
                                            //       )
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConst.primaryColor,
                                          ),
                                          onPressed: () {
                                            Get.to(
                                              () => JobDetails(
                                                job: latest.description!,
                                                title: latest.title,
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            'View',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
