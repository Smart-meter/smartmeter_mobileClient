import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import '../model/BoundingBox.dart';

class ImageUploadHelper {
  static Future<bool> uploadImage(File image) async {
    final prefs = await SharedPreferences.getInstance();

    Uint8List bytes = image.readAsBytesSync();

    String fileName = image.path.split("/").last;

    final uri =
        Uri.parse("http://${Config.meterApiUrl}${Config.uploadMeterImage}");
    var request = http.MultipartRequest('POST', uri);
    final httpImage =
        http.MultipartFile.fromBytes("imageFile", bytes, filename: fileName);
    request.files.add(httpImage);

    print(prefs.getString("token"));

    request.headers["Authorization"] = "Bearer ${prefs.getString("token")}";
    //todo, later change these from static to dynamic.
    request.fields["readingValue"] = "27";
    //todo
    request.fields["utilityAccountNumber"] =
        prefs.getString("utilityAccountNumber")!.isEmpty
            ? "1"
            : prefs.getString("utilityAccountNumber")!;

    print(prefs.getString("utilityAccountNumber"));

    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> uploadCoordinates(BoundingBox box) async {
    final url = Uri.http(Config.apiUrl, Config.uploadBoundingBox);

    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: jsonEncode(box),
      );

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }

      return false;
    }
  }


  static Future<bool> uploadProfileImage(File image) async {
    final prefs = await SharedPreferences.getInstance();

    Uint8List bytes = image.readAsBytesSync();

    String fileName = image.path.split("/").last;

    final uri =
    Uri.parse("http://${Config.meterApiUrl}${Config.uploadMeterImage}");
    var request = http.MultipartRequest('POST', uri);
    final httpImage =
    http.MultipartFile.fromBytes("imageFile", bytes, filename: fileName);
    request.files.add(httpImage);

    request.headers["Authorization"] = "Bearer ${prefs.getString("token")}";

    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  static Future<bool> invalidateImage() async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString("submissionId");

    final url = Uri.http(Config.meterApiUrl, "${Config.invalidateImage}$id");


    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred, hello: $e");
      }

      return false;
    }
  }
}
