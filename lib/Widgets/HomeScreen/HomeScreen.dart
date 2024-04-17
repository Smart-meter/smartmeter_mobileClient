import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartmeter/Widgets/HomeScreen/Carousel/Carousel.dart';
import 'package:smartmeter/Widgets/HomeScreen/Greet.dart';
import 'package:smartmeter/Widgets/HomeScreen/Meter.dart';
import 'package:smartmeter/helpers/SharedPrefHelper.dart';

import '../../helpers/user_details_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? prefs;

  List<String> messages = [];

  String? userName;
  String? date;
  String? meterReading;

  void asyncStuff() async {
    prefs = await SharedPrefsHelper.getPrefs();

    if (!prefs!.containsKey("userDetails")) {
      // make an api call and update the prefs.
      await UserDetailsHelper.fetchUserDetails();
    } else {
      if (kDebugMode) {
        print("User details present");
      }
    }

    messages = await UserDetailsHelper.fetchUserMessages();
    messages.add(
        "Your earlier meter submission failed, please try recapturing the image");
    //messages.add("Asshole");

    setState(() {
      userName = prefs?.getString("firstName");
      date = prefs?.getString("dateOfReading");
      meterReading = prefs?.getString("readingValue");
    });
  }

  @override
  void initState() {
    super.initState();
    asyncStuff();
    Future.delayed(Duration.zero).then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    Widget widget = ListView(
        padding: const EdgeInsets.all(8),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Greet(userName: userName ?? ""),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Last captured meter reading",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          Meter(meterReading: meterReading ?? ""),
          Center(
              child: Text("Last Updated On : ${date ?? ""}",
                  style: const TextStyle(color: Colors.grey))),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Notifications",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          const SizedBox(
            height: 16,
          ),
          messages.isEmpty
              ? const Center(
                  child: Text(
                  "All Notifications Caught Up",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ))
              : Carousel(
                  messages: messages,
                )
        ]);

    return userName == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : widget;
  }
}
