

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class AuthHelper{

  static Future<bool> loginHelper(String email, String password)async {

    final url = Uri.http(Config.apiUrl, Config.login);


    Map<String,String> data ={};

    final prefs = await SharedPreferences.getInstance();

    data["email"] = email;
    data["password"] = password;

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: data,
      );

      if (response.statusCode == 200) {
        // Save the counter value to persistent storage under the 'counter' key.
        await prefs.setBool('isAuthenticated', true);
        //todo change the id
        //await prefs.setString('userId', response.body.id);

        // i also need to store the JWT token, and from later requests i need to include it
        return true;
      } else {
        // Handle error response
        if (kDebugMode) {
          print("Login error: ${response.body}");
        }
        await prefs.setBool('isAuthenticated', false);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
      await prefs.setBool('isAuthenticated', false);
      return false;
    }

  }



}