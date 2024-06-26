

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class AuthHelper{

  static Future<bool> loginHelper(String email, String password)async {

    final url = Uri.http(Config.apiUrl, Config.login);
    final prefs = await SharedPreferences.getInstance();
    final body = {
      'email':email,
      'password':password
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {

        final body = json.decode(response.body);

        print("token -> ${body["access_token"]}");


         await prefs.setBool('isAuthenticated', true);

        // i also need to store the JWT token, and from later requests i need to include it
        await prefs.setString('token', body["access_token"]);

        print("Bearer ${prefs.getString('token')}");
        return true;
      } else {
        // Handle error response

        await prefs.setBool('isAuthenticated', false);
        return false;
      }
    } catch (e) {

      await prefs.setBool('isAuthenticated', false);
      return false;
    }

  }


  static Future<bool> signUpHelper(Map<String, String> data)async {

    final url = Uri.http(Config.apiUrl, Config.register);

    final prefs = await SharedPreferences.getInstance();

      data["role"]="CUSTOMER";

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      print(response.statusCode.toString());



      if (response.statusCode == 200) {

        final body = json.decode(response.body);

        await prefs.setBool('isAuthenticated', true);

        // i also need to store the JWT token, and from later requests i need to include it
        await prefs.setString('token', body["access_token"]);

        return true;
      } else {
        // Handle error response
        await prefs.setBool('isAuthenticated', false);
        return false;
      }
    } catch (e) {
      await prefs.setBool('isAuthenticated', false);
      return false;
    }

  }


  static Future<int> fetchUAN(Map<String, String> data)async {

    final url = Uri.http(Config.utilityApiUrl, Config.fetchUAN);

    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {

        final body = json.decode(response.body);

        prefs.setString("utilityAccountNumber", body['utilityAccountNumber'].toString());

        int data = body['utilityAccountNumber'];

        return data;
      } else {
        print(response.statusCode);
        return -1;
      }
    } catch (e) {
      print(e);
      return -1;
    }

  }



}