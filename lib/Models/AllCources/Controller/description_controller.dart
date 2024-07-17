import 'dart:developer';

// import 'dart:io';

// import 'package:elera/Models/AllCources/Model/description_model.dart';
import 'package:get/get.dart';

class DescriptionController extends GetxController {
  // final RxString _descriptionData = RxString('');
  // String get getdescriptionData => descriptionData.value;
  // set setdescriptionData(String data)  => descriptionData.value = data;

  // String _tryBaseUrl = 'client-admin.gameapp.tech';
  // String _tryBaseApiKey = '/api/walkThrow';

  // String baseUrl = 'https://aimpariksha.com';
  String baseUrl = 'livedivine.in';
  String apiPath = '/api/course_detail?slug=Complete Course For NDA';

  // String apiPath_2 = '/course/CONSTITUTION%20ACT%20DEMO%20VIDEO';

  String bearerToken =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZjY4MDcwNDkyMTNlMDZlYzAxZjI4NzY0YWEwMThiZDM4OTI1YzdlMGYzOTA1NDQ5ZTZlZjIzZWRjNDdjODg5Y2VmMDdhZDA1NTRiNzQ0ZDgiLCJpYXQiOjE2NjI0MDc1NzcuMjEzNjY1OTYyMjE5MjM4MjgxMjUsIm5iZiI6MTY2MjQwNzU3Ny4yMTM2NjgxMDc5ODY0NTAxOTUzMTI1LCJleHAiOjE2OTM5NDM1NzcuMjExOTk4OTM5NTE0MTYwMTU2MjUsInN1YiI6IjEwNDAiLCJzY29wZXMiOltdfQ.J6azumfNFqGPv1wo8KZU1RSIiYU8-TtbR6moqQSv4DnI2JEV1UuUfsgI6k_PiXTCc9RhP_OPVR3qiR2PPyo5xpwzYyqKMZXIuepHZoT1uyQQjFZTdxZ0GYaKyjVyLzOTIE33XTTeZ1Qqryekse1OBu7C_aht6LRZvGmIAQQu1GOX-Gr4Tkri_YhkarDYTUqIsOM2BpV1TQ3yDwzhsXw7EhnsB-x-AcuKI3xM0OblcpDbQ5slSmzNnXNiKGb1wIjcwquZ2GbPrw3jn81r4Z2lYmLOpj_F4az-M-2Omm--eilkvDjExn-ALBKasRHkrqZccR4C5epOPuRWkRHvaBlvL2KnJCIJn0VWAMnSLkTv7qt0XUXAWLJr1zt98ONC-0NxnJfLNn3lx0UJJHlLW11UQQ6NSp9ceWbU70gVU5CCwwfQwR1gf0QK4lEa4AerknNLgug5Xirh1JohQp4aA5L2010JxEb_sG83nBs5YRwW73-fjEQ3CQknyfkuudlkeSKub0awPjqvViuWmX_ykrVkqSO2FaHFmqlHd54wOOm6-DJFnmpsFWM1amNszHJlMS5XZAw-MPAJXZvVxQA01jefNTGy5fopwRMb1e-3cLilV3teXOLdrMnl-XmDVHTaS_R_UjqNAz2WvJmSgCMyfFhafg9mBF6ogQx9iR3EhAZXh-0';

  Future<dynamic> getDescriptionData() async {
    final descriptionUrl = Uri.https(baseUrl, apiPath);
//     final descriptionUrl = Uri.https(_tryBaseUrl, _tryBaseApiKey, {
//     "answerId": 14,
//     "question_id": 115,
//     "stage_id": 76,
//     "question_type": 1,
//     "token": "1cQXuCBqWNZyYy6eZYNvnqt1Rjt1DLNAsbQSnsouqeoWrOOW5UsIvPIv40Ibz7KD",
// },);

    try {
      // final response = await http.get(descriptionUrl, headers: {HttpHeaders.authorizationHeader: "Bearer $bearerToken"},);
      // final resp = await http.get(descriptionUrl);
      // final data = DescriptionModel.fromJson(response.body);
      // setdescriptionData = response.body;
      // log("lkj: ${resp.body}");
      // log(getdescriptionData);
      // log(response.body);
      // return resp.body;
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<dynamic> getDescriptionData() async {
  //   final descriptionUrl = Uri.https(baseUrl, apiPath_2);
  //   try {
  //     final resp = await http.get(descriptionUrl);
  //     final data = resp.body;
  //     // log(resp.body);
  //     // log('hello');
  //     return data;
  //   } catch (e) {
  //     // log('hi');
  //     log(e.toString());
  //     return e;
  //   }
  // }
}
