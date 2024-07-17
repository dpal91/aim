import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_links/uni_links.dart';

import 'Models/AllCources/Controller/all_courses_controller.dart';
import 'Models/AllCources/Pages/all_courses_pages_details.dart';
import 'Utils/Constants/global_data.dart';
import 'Utils/Constants/routes.dart';

StreamSubscription? _sub;

Future<void> initUniLinks() async {
  try {
    final initialLink = await getInitialLink();
  } on PlatformException {
    // Handle exception by warning the user their action did not succeed
    // return?
  }
}

void startListner() async {
  await initUniLinks();
  _sub = uriLinkStream.listen((Uri? uri) {
    if (uri != null) {
      final controller = Get.put(AllCoursesController());
      controller.getAllCourseDetails(
        uri.path.split('/').last.replaceAll("_", " "),
      );
      Get.to(
        () => AllCoursesPageDetails(
          isDemo: true,
        ),
      );
    }
  }, onError: (Object err) {
    // Handle exception by warning the user their action did not succeed
    //  return?
  });
}

late FirebaseStorage gFirebaseStorage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Plugin must be initialized before using
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  gFirebaseStorage = FirebaseStorage.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  isSkippedButtonPressed = GetStorage().read("skip") ?? false;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    startListner();
  }

  @override
  void dispose() {
    super.dispose();
    _sub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Divine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      initialRoute: RoutesName.splashScreen,
      getPages: Routes.pages,
      builder: EasyLoading.init(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}
