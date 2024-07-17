import 'package:flutter/material.dart';

Row reusableRowWidget(
    String title, String subtitle, IconData iconData, Color color) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(
          iconData,
          color: color,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
