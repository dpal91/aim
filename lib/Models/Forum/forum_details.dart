import 'dart:convert';

import '../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../../Utils/Constants/constants_colors.dart';

class JobDetails extends StatefulWidget {
  final String job;
  final String? title;
  const JobDetails({
    Key? key,
    required this.job,
    this.title,
  }) : super(key: key);

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
            title: widget.title!,
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
                      widget.job ?? "",
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
        ),

        // Scaffold(
        //   body: isLoading
        //       ? const Center(
        //           child: CircularProgressIndicator(),
        //         )
        //       : Container(
        //           color: ColorConst.primaryColor,
        //           child: SafeArea(
        //             child: Column(
        //               children: [
        //                 SizedBox(
        //                   height: kToolbarHeight,
        //                   child: Row(
        //                     children: [
        //                       IconButton(
        //                         onPressed: () {
        //                           // if (ttsState == TtsState.playing) {
        //                           //   flutterTts.stop();
        //                           // }
        //                           Get.back();
        //                         },
        //                         icon: const Icon(
        //                           Icons.arrow_back_ios,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 20),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     children: [
        //                       Expanded(
        //                         child: Text(
        //                           widget.title!,
        //                           style: const TextStyle(
        //                             fontSize: 16,
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.white,
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   height: 10,
        //                 ),
        //                 Expanded(
        //                   child: Container(
        //                     decoration: const BoxDecoration(
        //                       color: Colors.white,
        //                       borderRadius: BorderRadius.only(
        //                         topLeft: Radius.circular(30),
        //                         topRight: Radius.circular(30),
        //                       ),
        //                     ),
        //                     padding: const EdgeInsets.symmetric(
        //                       horizontal: 20,
        //                       vertical: 20,
        //                     ),
        //                     clipBehavior: Clip.antiAliasWithSaveLayer,
        //                     child: WebView(
        //                       javascriptMode: JavascriptMode.unrestricted,
        //                       onPageFinished: (finish) {
        //                         setState(() {
        //                           isLoading = false;
        //                         });
        //                       },
        //                       zoomEnabled: false,
        //                       onWebViewCreated: (controller) {
        //                         controller.loadUrl(
        //                           Uri.dataFromString(
        //                             widget.job,
        //                             mimeType: 'text/html',
        //                             encoding: Encoding.getByName(
        //                               'utf-8',
        //                             ),
        //                           ).toString(),
        //                         );
        //                       },
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        // ),
      ),
    );
  }
}
