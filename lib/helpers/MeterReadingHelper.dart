import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class MeterReadingHelper {
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

      print(response.statusCode);

      return response.statusCode == 204;
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred, hello: $e");
      }

      return false;
    }
  }

  static Future<bool> confirmationCall() async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString("submissionId");
    final url = Uri.http(Config.meterApiUrl, "${Config.confirmImage}$id");

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      return response.statusCode == 204;
    } catch (e) {
      await prefs.setBool('isAuthenticated', false);
      return false;
    }
  }

  static Future<bool> payBill() async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString("submissionId");

    final url = Uri.http(Config.meterApiUrl, "${Config.payBill}$id");

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      return response.statusCode == 204;
    } catch (e) {
      await prefs.setBool('isAuthenticated', false);
      return false;
    }
  }
}
