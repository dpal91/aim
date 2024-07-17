import '../../../Utils/Constants/constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../Utils/Constants/routes.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // body: SfCalendar(
        //   view: CalendarView.month,
        //   initialSelectedDate: DateTime.now(),
        //   cellBorderColor: Colors.transparent,
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(RoutesName.eventEditingPage);
          },
          backgroundColor: ColorConst.buttonColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
