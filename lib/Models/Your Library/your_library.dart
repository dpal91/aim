import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/Constants/constants_colors.dart';
import '../../Utils/Wdgets/appbar.dart';

class YourLibraryPage extends StatelessWidget {
  const YourLibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: MyAppBar(
            title: 'Your Library',
            height: Get.height * 0.13,
            bottom: TabBar(
              indicatorColor: ColorConst.buttonColor,
              labelColor: ColorConst.buttonColor,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(
                  child: Text(
                    'Current Affairs',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                    overflow: TextOverflow.fade,
                  ),
                ),
                Tab(
                    child: Text(
                  'Saved News',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                )),
                Tab(
                  child: Text(
                    'Saved Note',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                  ),
                ),
                Tab(
                    child: Text(
                  'Saved Question',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              reusableTab(
                  'Entrance Quiz', Icons.quiz, '5 Questions |10 minutes'),
              reusableTab('News', Icons.newspaper_sharp, '22 September 2022'),
              reusableTab(
                  'Saved Note', Icons.note_alt_outlined, 'Author Charles'),
              reusableTab('Saved Question', Icons.question_answer, 'IAS')
            ],
          )),
    );
  }

  Widget reusableTab(String title, IconData iconData, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              color: Colors.grey.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, top: 10, bottom: 10),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: ColorConst.buttonColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Icon(
                              iconData,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 9,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
