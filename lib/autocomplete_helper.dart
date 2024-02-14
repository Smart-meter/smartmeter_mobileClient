import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

class AutoCompleteHelper {
  static Future<List<String>> addressHelper(String prompt) async {
    Map<String,String> query={};
    query['text'] = prompt;
    query['apiKey'] = Config.apiKey;
    query['format'] = "json";
    query['filter'] = "countrycode:us";

    final url = Uri.http(Config.addressAPI,Config.tail,query);

    List<String> results = [];

    try {
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {

        dynamic json = jsonDecode(response.body);

        for(dynamic data in json['results']){

          print(data['formatted']);
          results.add(data['formatted']);
        }

        return results;

      } else {
        return results;
      }
    } catch (e) {
      if (kDebugMode) {
        print("An error occurred: $e");
      }

      return results;
    }
    // List<String> l=["apple","banana","orange"];
    //
    // return Future(() => l);
  }
}
