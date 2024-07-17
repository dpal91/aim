import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Constants/routes.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/drawer_menu_page.dart';
import '../Widgets/financial_widgets.dart';

class FinancialPage extends StatelessWidget {
  const FinancialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: MyAppBar(
            title: 'Financial',
            height: Get.height * 0.13,
            bottom: _header(),
          ),
          body: _body()),
    );
  }

  TabBar _header() {
    return TabBar(
      indicatorColor: ColorConst.buttonColor,
      labelColor: ColorConst.buttonColor,
      labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      unselectedLabelColor: Colors.black,
      tabs: [
        const Tab(
          child: Text(
            'Summary',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
            overflow: TextOverflow.fade,
          ),
        ),
        const Tab(
            child: Text(
          'Offline Payments',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
        )),
        box.read(RoutesName.isTeacher)
            ? const Tab(
                child: Text(
                'Sales',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
              ))
            : Container(),
        box.read(RoutesName.isTeacher)
            ? const Tab(
                child: Text(
                'Payout',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
              ))
            : Container(),
      ],
    );
  }

  TabBarView _body() {
    return TabBarView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          '\$281.40',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const Text(
                          'Account Balance',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: ColorConst.buttonColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                'Charge',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, top: 10, bottom: 10),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: ColorConst.buttonColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Balances History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: reusableTabone(
                      'Paid from Credit',
                      Icons.keyboard_arrow_down_rounded,
                      '27 Jun 2022| 14:50',
                      Colors.red,
                      Colors.red,
                      '-\$17.00')),
            ],
          ),
        ),
        reusableTabtwo('JPMorgan', Icons.account_balance_wallet,
            '22 September 2022 | 14:50', ColorConst.buttonColor),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                  Expanded(
                      child: reusableHeaderwidget('17', 'Class Sales',
                          Icons.videocam_sharp, '\$1025.00', Colors.green)),
                  Expanded(
                      child: reusableHeaderwidget('3', 'Meeting Sales',
                          Icons.groups, '\$1025.00', Colors.blueAccent)),
                  Expanded(
                      child: reusableHeaderwidget(
                          '20',
                          'Total Sales',
                          Icons.calendar_month,
                          '\$1025.00',
                          Colors.yellow.shade900)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Sales History',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: salesBuilder())
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          '\$281.40',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const Text(
                          'Ready to payout',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: ColorConst.buttonColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                              child: Text(
                                'Request payout',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 28.0, top: 10, bottom: 10),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Balances History',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: reusableTabone(
                      'Quatar National Bank',
                      Icons.keyboard_arrow_up,
                      '27 Jun 2022| 14:50',
                      Colors.green,
                      Colors.green,
                      '\$+\$0.00')),
            ],
          ),
        ),
      ],
    );
  }
}
