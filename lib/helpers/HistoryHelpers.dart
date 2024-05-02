import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/model/HistoryModel.dart';

import '../config.dart';

class HistoryHelper {
  static Future<List<HistoryModel>> fetchHistory() async {
    final prefs = await SharedPreferences.getInstance();

    String? uan = prefs.getString("utilityAccountNumber");

    final url = Uri.http(Config.meterApiUrl, "${Config.history}$uan");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('token')}'
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        List<HistoryModel> data = [];

        for (var b in body) {
          var d = HistoryModel(
              b["readingId"].toString(),
              b["dateOfReading"],
              b["status"],
              b["imageURL"],
              b["readingValue"] ?? "-",
              b["billAmount"].toString());

          data.add(d);
        }

        return data;
      } else {
        List<HistoryModel> data = [];
        return data;
      }
    } catch (e) {
      List<HistoryModel> data = [];
      return data;
    }
  }
}
