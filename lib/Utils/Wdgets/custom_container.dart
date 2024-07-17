import "package:flutter/material.dart";

class CustomContainer extends StatelessWidget {
  final double? width, height;
  final child, decoration, margin, padding, borderColor, color;
  final BorderRadiusGeometry? borderRadiusGeometry;
  CustomContainer({
    required this.child,
    this.height,
    this.width,
    this.decoration,
    this.margin,
    this.padding,
    this.borderColor,
    this.color,
    this.borderRadiusGeometry,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: child,
      padding: padding,
      margin: margin,
      decoration: decoration ??
          BoxDecoration(
            border: Border.all(
                color: borderColor ?? Colors.transparent, width: 1.0),
            color: color ?? Colors.white,
            borderRadius: borderRadiusGeometry ?? BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), //color of shadow
                spreadRadius: 5, //spread radius
                blurRadius: 7, // blur radius
                offset: const Offset(0, 2), // changes position of shadow
              ),
              //you can set more BoxShadow() here
            ],
          ),
    );
  }
}
