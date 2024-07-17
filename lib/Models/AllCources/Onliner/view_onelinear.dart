import 'dart:convert';

import '../../../Utils/Constants/constants_colors.dart';
import '../../../Utils/Wdgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewOneLinearPage extends StatefulWidget {
  final String? title;
  final String? content;
  const ViewOneLinearPage({
    Key? key,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  State<ViewOneLinearPage> createState() => _ViewOneLinearPageState();
}

class _ViewOneLinearPageState extends State<ViewOneLinearPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: widget.title,
        titleColor: Colors.white,
        backgroundColor: ColorConst.primaryColor,
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.loadUrl(
            Uri.dataFromString(
              widget.content!,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString(),
          );
        },
      ),
    );
  }
}
