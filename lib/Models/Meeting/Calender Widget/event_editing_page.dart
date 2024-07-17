import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Wdgets/appbar.dart';
import '../../../Utils/Wdgets/textfield.dart';
import '../Class/calender_classes.dart';
import '../Class/utils.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;
  final titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          leading: const Icon(
            Icons.close,
            color: Colors.black,
            size: 20,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    Text(
                      'SAVE',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTile(),
                  const SizedBox(
                    height: 20,
                  ),
                  buildDateTimePicker()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTile() {
    return MyTextFormField(
      hintText: 'Schedule an Event',
      controller: titleController,
      validator: (title) =>
          title != null && title.isEmpty ? 'Title cannot be empty' : null,
    );
  }

  Widget buildDateTimePicker() {
    return Column(
      children: [
        buildFrom(),
        buildTo(),
      ],
    );
  }

  Widget buildFrom() {
    return buildHeader(
      header: 'FROM',
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: buildDropDownField(
                  text: Utils.toDate(fromDate),
                  onClicked: () {
                    pickFromDateTime(pickDate: true);
                  })),
          Expanded(
              flex: 1,
              child: buildDropDownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () {
                    pickFromDateTime(pickDate: false);
                  }))
        ],
      ),
    );
  }

  Widget buildTo() {
    return buildHeader(
      header: 'TO',
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: buildDropDownField(
                  text: Utils.toDate(toDate),
                  onClicked: () {
                    pickToDateTime(pickDate: true);
                  })),
          Expanded(
              flex: 1,
              child: buildDropDownField(
                  text: Utils.toTime(toDate),
                  onClicked: () {
                    pickToDateTime(pickDate: false);
                  }))
        ],
      ),
    );
  }

  Widget buildDropDownField(
      {required String text, required VoidCallback onClicked}) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
      trailing: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      onTap: onClicked,
    );
  }

  Widget buildHeader({required String header, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        child
      ],
    );
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      fromDate = date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(toDate,
        pickDate: pickDate, firstDate: pickDate ? fromDate : null);
    if (date == null) return;
    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      toDate = date;
    });
  }

  Future<DateTime?> pickDateTime(DateTime initialDate,
      {required bool pickDate, DateTime? firstDate}) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final event = Event(
          title: titleController.text,
          from: fromDate,
          description: 'Description',
          to: toDate,
          isAllDay: false,
          backgroundColor: Colors.black);
    }
  }
}
