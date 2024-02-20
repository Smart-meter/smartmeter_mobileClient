

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class ImageUploadHelper{
  static Future<bool> uploadImage(File image)async {

    final prefs = await SharedPreferences.getInstance();

    Uint8List bytes = image.readAsBytesSync();

    String fileName = image.path.split("/").last;

    final uri = Uri.parse("http://${Config.meterApiUrl}${Config.uploadMeterImage}");
    var request = http.MultipartRequest('POST', uri);
    final httpImage = http.MultipartFile.fromBytes("imageFile",bytes, filename: fileName);
    request.files.add(httpImage);

    print(prefs.getString("token"));

    request.headers["Authorization"] = "Bearer ${prefs.getString("token")}";
    //todo, later change these from static to dynamic.
    request.fields["readingValue"] ="27";
    //todo
    request.fields["utilityAccountNumber"] =prefs.getString("utilityAccountNumber")!.isEmpty? "1" : prefs.getString("utilityAccountNumber")!;

    final response = await request.send();

    print(response.statusCode);

    if(response.statusCode == 200){

      return true;
    }else{
      return false;
    }

  }
}