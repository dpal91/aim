import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleName;
  final String? title;
  final Widget? leading;
  final double height;
  final double? elevation;
  final Color? backgroundColor, titleColor, statusBarColor;
  final Brightness? statusBarIconBrightness;
  final bool? centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? fontSize;

  const MyAppBar({
    super.key,
    this.titleName,
    this.title,
    this.leading,
    this.height = kToolbarHeight,
    this.elevation = 0.0,
    this.backgroundColor = Colors.white,
    this.titleColor,
    this.statusBarColor,
    this.statusBarIconBrightness,
    this.centerTitle = false,
    this.actions,
    this.bottom,
    this.fontSize,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            // bottomLeft: Radius.circular(18),
            // bottomRight: Radius.circular(18),
            ),
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: centerTitle,
      bottom: bottom,
      automaticallyImplyLeading: false,
      leadingWidth: 0,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 30,
            child: leading ??
                IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title ?? "",
              style: TextStyle(
                color: titleColor ?? Colors.black,
                fontSize: fontSize ?? 15,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }
}
