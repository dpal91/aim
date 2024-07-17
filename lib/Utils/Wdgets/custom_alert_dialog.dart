import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Constants/constants_colors.dart';
import 'custom_container.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    super.key,
    this.title,
    this.description,
    this.height,
    this.boldDescription,
    this.routeNameOne,
    this.routeNameTwo,
    this.width,
    this.isNonLogin = false,
    this.buttons,
    this.callback,
  });
  final String? title;
  final String? description;
  final double? width;
  final double? height;
  final bool? boldDescription;
  final String? routeNameOne;
  final String? routeNameTwo;
  final bool? isNonLogin;
  final List<Widget>? buttons;
  final VoidCallback? callback;

  @override
  State<StatefulWidget> createState() => CustomAlertDialogState();
}

class CustomAlertDialogState extends State<CustomAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // This checks is for check is description has dear customer or not for making that bold
    String finalDescription = widget.description ?? "",
        heading = "",
        subHeading = "";

    if (widget.description?.contains("\n") ?? false) {
      finalDescription = widget.description?.replaceAll("\n", "") ?? "";
    }
    if (finalDescription.toLowerCase().contains("dear customer")) {
      heading = "Dear Customer,";
      subHeading = finalDescription.replaceAll("Dear Customer,", "");
    }
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: CustomContainer(
              width: kIsWeb ? Get.width / 2 : null,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Text(
                      widget.title ?? "",
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  widget.description == ""
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 10, right: 10),
                          child: Divider(
                            color: Colors.grey[300],
                            height: 1,
                          )),
                  if (subHeading.isNotEmpty)
                    Text(
                      heading,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  if (subHeading.isNotEmpty) const SizedBox(height: 10),
                  widget.description == ""
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 10.0, right: 10.0),
                          child: Text(
                            (subHeading.isNotEmpty
                                    ? subHeading
                                    : widget.description) ??
                                "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                  ((widget.buttons?.isEmpty) ?? true)
                      ?
                      // Okay button
                      Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 20.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 90.0,
                              child: MaterialButton(
                                  color: ColorConst.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  splashColor: Colors.white.withAlpha(40),
                                  onPressed: widget.callback ??
                                      () {
                                        Get.back();
                                      },
                                  child: const Text(
                                    'Ok',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ))))
                      :

                      /// Multiple buttons
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.buttons ?? [],
                        )
                ],
              )),
        ),
      ),
    );
  }
}
