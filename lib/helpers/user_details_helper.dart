

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class UserDetailsHelper{
  static Future<void> fetchUserDetails()async {

    final url = Uri.http(Config.apiUrl, Config.fetchUserDetails);


    final prefs = await SharedPreferences.getInstance();


    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json',
        'Authorization' : 'Bearer ${prefs.getString('token')}'
        },
      );

      if (response.statusCode == 200) {

        final body = json.decode(response.body);

        // later store the data inside shared preferences.
        
        prefs.setString("id", body["id"]);
        prefs.setString("firstName", body["firstName"]);
        prefs.setString("lastName", body["lastName"]);
        prefs.setString("email", body["email"]);
        prefs.setString("utilityAccountNumber", body["currentUtilityAccountNumber"]);


      } else {
        // Handle error response
        if (kDebugMode) {
          print("Login error: ${response.body}");
        }


      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }


    }

  }
}