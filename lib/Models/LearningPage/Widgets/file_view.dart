// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FileView extends StatefulWidget {
  final String url;
  const FileView({Key? key, required this.url}) : super(key: key);

  @override
  FileViewState createState() => FileViewState();
}

class FileViewState extends State<FileView> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            // child: SfPdfViewer.network(
            //   widget.url,
            //   scrollDirection: PdfScrollDirection.vertical,
            //   pageLayoutMode: PdfPageLayoutMode.single,
            // ),
            ),
      ),
    );
  }
}
