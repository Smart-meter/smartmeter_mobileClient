import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/model/BoundingBoxWrapper.dart';

import '../config.dart';
import '../model/BoundingBox.dart';

class ImageUploadHelper {
  static Future<bool> uploadImage(File image) async {
    final prefs = await SharedPreferences.getInstance();

    Uint8List bytes = image.readAsBytesSync();


    print(image.path.split("/"));
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

  static Future<bool> uploadCoordinates(String reading) async {
    final prefs = await SharedPreferences.getInstance();
    String? subId = prefs.getString("submissionId");
    final url = Uri.http(Config.apiUrl, Config.uploadBoundingBox+subId!);


    //var ob = BoundingBoxWrapper(reading, BoundingBox(100, 200, 300, 400));

//todo
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
        body: jsonEncode({
          "readingValue":int.parse(reading),
          "meterImageMetadata": {
            "xCoordinate": 100,
            "yCoordinate": 200,
            "width": 300,
            "height": 400
          }
        }),
      );


      print(response.statusCode);

      return response.statusCode == 204;
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



}
