import 'package:flutter/material.dart';

Widget reusableTabone(String title, IconData iconData, String subtitle,
    Color color, Color colortext, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            color: Colors.grey.withOpacity(0.1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 10, bottom: 10),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: color,
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
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              subtitle,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(text,
                      style: TextStyle(
                        color: colortext,
                      ))
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget reusableTabtwo(
    String title, IconData iconData, String subtitle, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            color: Colors.grey.withOpacity(0.1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 10, bottom: 10),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: color,
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
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Text(
                              '1647726485',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  child: Text(
                                    subtitle,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.brown.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                            child: Text(
                              "waiting",
                              style:
                                  TextStyle(fontSize: 9, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '-\$17.00',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget reusableTabfour(
    String title, IconData iconData, String subtitle, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Card(
            color: Colors.grey.withOpacity(0.1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 28.0, top: 10, bottom: 10),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              color: color,
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
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              subtitle,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    '-\$17.00',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget reusableHeaderwidget(
  String title,
  String subtitle,
  IconData iconData,
  String subtitletwo,
  Color colortext,
) {
  return Column(
    children: [
      CircleAvatar(
        backgroundColor: colortext.withOpacity(0.2),
        radius: 30,
        child: Icon(
          iconData,
          color: colortext,
          size: 33,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(subtitle,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                subtitletwo,
                style: TextStyle(fontSize: 10, color: colortext),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget salesBuilder() {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: 2,
    itemBuilder: (BuildContext context, index) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            //
            Stack(
              children: [
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        "https://img.freepik.com/free-photo/successful-businesswoman-working-laptop-computer-her-office-dressed-up-white-clothes_231208-4809.jpg",
                        fit: BoxFit.fill,
                      )),
                ),
              ],
            ),
            const SizedBox(width: 15),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Linda Hamilton",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Center(
                        child: Text(
                          "product",
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                            size: 14,
                          ),
                          Text(
                            " Tue 15 March 2022",
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey, fontSize: 11),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Row(children: [
                        Text(
                          "\$",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          "45.50",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        )
                      ]),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
