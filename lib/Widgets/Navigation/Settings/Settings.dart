import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<Settings> {
  void _clearData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  /**
   *
   */

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 64,
            backgroundColor: Colors.brown.shade800,
            child: const Text('CB', style: TextStyle(color: Colors.white, fontSize: 32),),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Chiruhas Bobbadi",
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 32,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "User Since : Jan 2024",
            style: TextStyle(
                color: Color(0xff9D9B9B),
                fontSize: 16,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 64,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                )),
            height: 48,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
                SizedBox(width: 8,),
                Text(
                  "Profile Info",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Spacer(flex: 1),
                Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)

              ],
            ),
          ),
          const SizedBox(height: 16,),

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                )),
            height: 48,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.group_add,
                  color: Colors.grey,
                ),
                SizedBox(width: 8,),
                Text(
                  "User Management",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Spacer(flex: 1),
                Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)

              ],
            ),
          ),
          const SizedBox(height: 16,),

          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                )),
            height: 48,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.electric_meter,
                  color: Colors.grey,
                ),
                SizedBox(width: 8,),
                Text(
                  "Utility Account Info",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Spacer(flex: 1),
                Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)

              ],
            ),
          ),
          const SizedBox(height: 16,),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 3,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                )),
            height: 48,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.support_rounded,
                  color: Colors.grey,
                ),
                SizedBox(width: 8,),
                Text(
                  "Help Center",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Spacer(flex: 1),
                Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)

              ],
            ),
          ),

          const Spacer(flex: 2,),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 24),
        child: ElevatedButton(onPressed: (){
          // clear shared prefs and navigate to main page
          _clearData();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
          );
        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent,shape : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // <-- Radius
        ),
            side: const BorderSide(color: Colors.red) ), child: const Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Logout"), SizedBox(width: 16,), Icon(Icons.logout_rounded)],),),
      )

        ],
      ),
    );
  }
}
