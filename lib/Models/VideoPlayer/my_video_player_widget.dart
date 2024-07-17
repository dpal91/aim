import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyVideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const MyVideoPlayerWidget({Key? key, required this.videoUrl})
      : super(key: key);

  @override
  State<MyVideoPlayerWidget> createState() => _MyVideoPlayerWidgetState();
}

class _MyVideoPlayerWidgetState extends State<MyVideoPlayerWidget> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive,
    );
    // controller = VideoPlayerController.network(widget.videoUrl)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
  }

  @override
  Widget build(BuildContext context) {
    // YoutubePlayerController controller = YoutubePlayerController(
    //   initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: true,
    //     mute: false,
    //   ),
    // );
    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        return true;
      },
      child: Stack(
        children: [
          Scaffold(
            body: WebView(
              initialUrl: widget.videoUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {},
              onPageFinished: (url) {
                setState(() {
                  isLoading = false;
                });
              },
              onProgress: (progress) {
                setState(() {
                  isLoading = true;
                });
              },
            ),
          ),
          Visibility(
            visible: isLoading,
            child: const Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
