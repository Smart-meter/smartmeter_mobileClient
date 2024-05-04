import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/model/CallToActions.dart';
import 'package:smartmeter/model/Message.dart';

import '../config.dart';

class UserDetailsHelper {
  static Future<void> fetchUserDetails() async {
    final url = Uri.http(Config.apiUrl, Config.fetchUserDetails);

    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      print(prefs.getString('token'));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        // later store the data inside shared preferences.
        print("user details set");
        prefs.setString("userDetails", "valid");
        prefs.setString("id", "${body["id"]}");
        prefs.setString("firstName", body["firstname"]);
        prefs.setString("lastName", body["lastname"]);
        prefs.setString("email", body["email"]);
        prefs.setString("utilityAccountNumber", "${body["currentUtilityAccountNumber"]}");
        prefs.setString("readingValue", '${body["readingValue"]}');
        prefs.setString("dateOfReading", body["dateOfReading"]);
        prefs.setString("dateOfLink", body["dateOfLink"]);
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


  static Future<void> fetchRecentReading() async {
    final prefs = await SharedPreferences.getInstance();
    String? uan = prefs.getString("utilityAccountNumber");
    final url = Uri.http(Config.meterApiUrl, "${Config.fetchRecentReading}$uan");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        // later store the data inside shared preferences.

        if(body['readingValue']!=null) {
          prefs.setString("readingValue", body['readingValue'].toString());
        }
        prefs.setString("dateOfReading", body["dateOfReading"]);
        prefs.setString("imageURL", body["imageURL"]);
        prefs.setString("submissionId", body["readingId"].toString());
        prefs.setString("billAmount", body["billAmount"]==null?"0":body["billAmount"].toString());
        prefs.setString("status", body["status"]);
      } else {
        // Handle error response
        if (kDebugMode) {
          print("fetchRecentReading : ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred, hello: $e");
      }
    }
  }

  static Future<List<Message>> fetchUserMessages() async {
    final url = Uri.http(Config.apiUrl, Config.fetchUserMessages);
    final prefs = await SharedPreferences.getInstance();
    try{
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        // later store the data inside shared preferences.
        List<Message> data = [];

        for (var d in body) {
          data.add(Message(d['message'], CallToActions.values.asNameMap()[d['action']]!));
        }
        return data;
      }
    }catch(e){
      if (kDebugMode) {
        print("fetchUserMessages: $e");
      }


    }

    List<Message> m = [];

    return m;

  }

  static Future<bool> updateFLName(String fName, String lName) async {
    final url = Uri.http(Config.apiUrl, Config.updateUserName);
    final prefs = await SharedPreferences.getInstance();

    var map = {};
    map['firstname'] = fName;
    map['lastname'] = lName;

    try {
      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token')}'
          },
          body: jsonEncode(map));

      if(response.statusCode == 200){

        prefs.setString("firstName", fName);
        prefs.setString("lastName", lName);
        return true;

      }


      return false;
    } catch (e) {
      return false;
    }
  }


  static Future<bool> updatePassword(String password) async {
    final url = Uri.http(Config.apiUrl, Config.updatePassword);
    final prefs = await SharedPreferences.getInstance();

    var map= {};
    map['password'] = password;

    try {
      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token')}'
          },
          body: jsonEncode(map));


      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateAddress(Map<String, String> data) async {
    final url = Uri.http(Config.apiUrl, Config.updateAddress);
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token')}'
          },
          body: jsonEncode(data));

      print(response.statusCode);


      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
