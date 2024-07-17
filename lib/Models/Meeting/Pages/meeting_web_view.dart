import '../Controller/meeting_controller.dart';
import '../../../Utils/Constants/constants_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MeetingWebView extends StatefulWidget {
  final String? url;
  final bool allow;
  const MeetingWebView({Key? key, this.url, this.allow = false})
      : super(key: key);

  @override
  State<MeetingWebView> createState() => _MeetingWebViewState();
}

class _MeetingWebViewState extends State<MeetingWebView> {
  MeetingController controller = Get.put(MeetingController());
  bool isLoading = true;

  @override
  void initState() {
    if (widget.allow) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    getPermission();
    super.initState();
  }

  getPermission() async {
    if (await Permission.camera.status.isDenied) {
      await Permission.camera.request();
    }
    if (await Permission.microphone.status.isDenied) {
      await Permission.microphone.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: MyAppBar(
        title: 'Meeting',
        backgroundColor: ColorConst.primaryColor,
        titleColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),*/
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onexit,
          child: Stack(
            children: [
              // WebViewPlus(
              //   initialUrl: widget.url,
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onPageFinished: (url) {
              //     setState(() {
              //       isLoading = false;
              //     });
              //   },
              // ),
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url!)),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    mediaPlaybackRequiresUserGesture: false,
                  ),
                ),
                onLoadStop: (InAppWebViewController controller, Uri? url) {
                  setState(() {
                    isLoading = false;
                  });
                },
                onTitleChanged: (controller, title) {
                  if (title == "Login") {
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                      DeviceOrientation.portraitDown,
                    ]);
                    Get.back();
                  }
                },
                androidOnPermissionRequest: (InAppWebViewController controller,
                    String origin, List<String> resources) async {
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT,
                  );
                },
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onexit() async {
    return await showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
            height: 150,
            child: Column(
              children: <Widget>[
                const Text("Are you sure you want to exit?"),
                Container(
                  margin: const EdgeInsets.only(top: 22, bottom: 12),
                  padding: const EdgeInsets.only(top: 22, bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.back(result: false);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  offset: const Offset(0.0, 1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0)
                            ],
                            color: ColorConst.buttonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown,
                          ]);
                          Get.back();
                          Get.back();
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  offset: const Offset(0.0, 1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0)
                            ],
                            color: ColorConst.buttonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
