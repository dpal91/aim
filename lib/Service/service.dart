import 'dart:developer';
import 'dart:io';

import '../Utils/Constants/routes.dart';
import '../Utils/Wdgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();
  static String baseUrl = RoutesName.baseUrl;
  static final box = GetStorage();

  static Future post({required String key, required Map body}) async {
    String? token = GetStorage().read(RoutesName.token);
    log('Post request : ${baseUrl + key} body: ${body.toString()}');
    var response =
        await client.post(Uri.parse(baseUrl + key), body: body, headers: {
      'Authorization': 'Bearer $token',
    });
    log(response.body.toString());
    if (response.statusCode == 200) {
      var data = response.body;
      return data;
    } else {
      return null;
    }
  }

  static Future get({required String key}) async {
    try {
      String? token = GetStorage().read(RoutesName.token);
      log('Get request : ${baseUrl + key} token : $token');

      var response = await client.get(
        Uri.parse(baseUrl + key),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log(
        'Get response : ${response.body.toString()}',
      );
      if (response.statusCode == 200) {
        var data = response.body;
        return data;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Err : token $e");
    }
  }

  static Future multipart({
    required String key,
    required Map<String, String> body,
    required File file,
  }) async {
    try {
      var stream = http.ByteStream(Stream.castFrom(file.openRead()));
      var length = await file.length();

      var request = http.MultipartRequest("POST", Uri.parse(baseUrl + key));

      var multipartFileSign =
          http.MultipartFile('user_image', stream, length, filename: file.path);
      request.files.add(multipartFileSign);
      request.headers.addAll({"Content-Type": "multipart/form-data;"});
      request.fields.addAll(body);
      log('multipart request : $request');

      var response = await request.send();
      var data = await response.stream.bytesToString();
      return data;
    } catch (e) {
      SnackBarService.showSnackBar(Get.context!, "Something whent wrong");
    }
  }

  //here goes the function
  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
