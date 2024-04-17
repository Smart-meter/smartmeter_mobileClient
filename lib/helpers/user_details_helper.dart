

import 'dart:collection';
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
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json',
        'Authorization' : 'Bearer ${prefs.getString('token')}'
        },
      );


      if (response.statusCode == 200) {

        final body = json.decode(response.body);

        // later store the data inside shared preferences.

        prefs.setString("userDetails", "valid");
        prefs.setString("id", "${body["id"]}");
        prefs.setString("firstName", body["firstname"]);
        prefs.setString("lastName", body["lastname"]);
        prefs.setString("email", body["email"]);
        prefs.setString("utilityAccountNumber", "${body["currentUtilityAccountNumber"]}" ?? "4");
        prefs.setString("readingValue", '${body["readingValue"]}');
        prefs.setString("dateOfReading", body["dateOfReading"]);


      } else {
        // Handle error response
        if (kDebugMode) {
          print("User details fetch error: ${response.statusCode}");
        }


      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }


    }

  }


  static Future<List<String>> fetchUserMessages() async{
    final url = Uri.http(Config.apiUrl, Config.fetchUserMessages);
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json',
          'Authorization' : 'Bearer ${prefs.getString('token')}'
        },
      );
      if (response.statusCode == 200) {

        final body = json.decode(response.body);

        // later store the data inside shared preferences.

        List<String> data =[];

        for(var d in body){
          data.add(d);
        }
        return data;

      } else {
        // Handle error response
        if (kDebugMode) {
          print("User details fetch error: ${response.statusCode}");
        }

      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }
    }

    List<String> l =[];
    return l;
  }


  static Future<bool> updateUserName(String userName) async{
    final url = Uri.http(Config.apiUrl, Config.updateUserName);
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json',
          'Authorization' : 'Bearer ${prefs.getString('token')}'
        },
        body:jsonEncode(userName)
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
  static Future<bool> updateEmail(String email) async{
    final url = Uri.http(Config.apiUrl, Config.updateEmail);
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json',
            'Authorization' : 'Bearer ${prefs.getString('token')}'
          },
          body:jsonEncode(email)
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
  static Future<bool> updatePassword(String password) async{
    final url = Uri.http(Config.apiUrl, Config.updatePassword);
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json',
            'Authorization' : 'Bearer ${prefs.getString('token')}'
          },
          body:jsonEncode(password)
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateAddress(Map<String, String> address) async{
    final url = Uri.http(Config.apiUrl, Config.updateAddress);
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json',
            'Authorization' : 'Bearer ${prefs.getString('token')}'
          },
          body:jsonEncode(address)
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}