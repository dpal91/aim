import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' show parse;
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import '../../Current%20Affair/current_affair_model.dart';

class CurrentAffairsDetailScreen extends StatefulWidget {
  final Datum currentAffairl;
  const CurrentAffairsDetailScreen({
    Key? key,
    required this.currentAffairl,
  }) : super(key: key);

  @override
  State<CurrentAffairsDetailScreen> createState() =>
      _CurrentAffairsDetailScreenState();
}

class _CurrentAffairsDetailScreenState
    extends State<CurrentAffairsDetailScreen> {
  // FlutterTts flutterTts = FlutterTts();
  // TtsState ttsState = TtsState.stopped;

  // Future _speak({
  //   required String text,
  // }) async {}
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (ttsState == TtsState.playing) {
        //   flutterTts.stop();
        // }
        Get.back();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            backgroundColor: ColorConst.primaryColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            title: widget.currentAffairl.title!,
            titleColor: Colors.white,
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : WebViewPlus(
                  javascriptMode: JavascriptMode.unrestricted,
                  zoomEnabled: false,
                  onWebViewCreated: (wcontroller) {
                    wcontroller.loadUrl(Uri.dataFromString(
                      widget.currentAffairl.description ?? "",
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'),
                    ).toString());
                  },
                  onPageFinished: (url) {
                    print('Page finished loading: $url');
                  },
                  onWebResourceError: (error) {
                    print('Web resource error: ${error.description}');
                    // Handle the error and display an appropriate message
                  },
                ),
          bottomNavigationBar: Container(
            height: kBottomNavigationBarHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Get.back(result: "home");
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/ideas.png",
                              height: 25,
                              width: 25,
                            ),
                            const Text(
                              "Quiz",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: dowloadPdf,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/download.png",
                              height: 25,
                              width: 25,
                            ),
                            const Text(
                              "Get Pdf",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dowloadPdf() async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    if (widget.currentAffairl.description == "") {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Pdf Available"),
        ),
      );
      return;
    }
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Downloading... "),
          ),
        );
        // final externalDir = await getExternalStorageDirectory();
        try {
          await Dio().download(
            parse(widget.currentAffairl.description).documentElement!.text,
            "/storage/emulated/0/Download/LiveDivine/${widget.currentAffairl.title}.pdf",
            onReceiveProgress: (rec, total) {},
          );
        } on DioError catch (e) {
          log(e.toString());
        }
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Downloaded Successfully"),
          ),
        );
      } else {
        Get.back();
        Get.snackbar(
          "Permission Denied",
          "Please allow storage permission",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
