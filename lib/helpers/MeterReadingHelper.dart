

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';



class MeterReadingHelper{


  static Future<bool> confirmationCall()async {

    //todo
    final url = Uri.http(Config.apiUrl, Config.login);
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      return response.statusCode == 200;
    } catch (e) {

      await prefs.setBool('isAuthenticated', false);
      return false;
    }

  }
}