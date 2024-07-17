import 'package:cached_network_image/cached_network_image.dart';
import '../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';

class VideoSectionPage extends StatelessWidget {
  const VideoSectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: 'Video section',
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => demoVideo(),
          itemCount: 7,
        ));
  }

  Widget demoVideo() {
    return Container(
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
          //
          Stack(
            children: [
              SizedBox(
                height: 95,
                width: 150,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      "https://img.freepik.com/free-photo/successful-businesswoman-working-laptop-computer-her-office-dressed-up-white-clothes_231208-4809.jpg",
                      fit: BoxFit.fill,
                    )),
              ),
              Positioned.fill(
                child: CachedNetworkImage(
                  width: 30,
                  height: 30,
                  imageUrl:
                      "https://icons.veryicon.com/png/o/miscellaneous/play-pc-play-page/video-web-play.png",
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    "Health and Fitness Masterclass",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Row(children: [
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 14,
                        ),
                        Expanded(
                          child: Text(
                            "Linda Address",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 70,
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                            size: 13,
                          ),
                          Expanded(
                            child: Text(
                              "35 Minutes",
                              // overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "4.0",
                          style: TextStyle(color: Colors.green, fontSize: 17),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "12k Views",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
