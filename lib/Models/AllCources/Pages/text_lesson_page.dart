import 'dart:convert';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TextLessonPage extends StatefulWidget {
  final String? title;
  final String? description;
  const TextLessonPage({
    Key? key,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  State<TextLessonPage> createState() => _TextLessonPageState();
}

class _TextLessonPageState extends State<TextLessonPage> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title!,
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: WebViewPlus(
              onWebViewCreated: (controllerPlus) {
                controllerPlus.loadString(
                  widget.description!,
                  mimeType: 'text/html',
                  encoding: Encoding.getByName('utf-8'),
                );
              },
              zoomEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (url) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
